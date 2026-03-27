-- DataBase
Create DataBase logistics_project;
Use logistics_project;

-- =====================================
-- SECTION 1: SCHEMA CREATION
-- =====================================

-- Order Table
Create Table orders (
    Order_ID Varchar(20) Primary Key,
    Order_Date Date,
    Customer_ID varchar(20),
    Product_ID varchar(20),
    Order_Quantity Int,
    Unit_Price Decimal(10,2),
    Discount Decimal(5,2),
    Order_Amount Decimal(20,2),
    Payment_Mode Varchar(20),
    Revenue_Category Varchar(10),
    Discount_Flag Varchar(5)
);

-- Shipment Table
Create Table shipments (
    Shipment_ID Varchar(20) Primary Key,
    Order_ID Varchar(20),
    Ship_Date Date,
    Delivery_Date Date,
    Shipping_Mode Varchar(20),
    Carrier Varchar(50),
    Warehouse_ID Varchar(20),
    Shipping_Time Int,
    Delivery_Speed Varchar(10),
    
    Foreign Key (Order_ID) References orders(Order_ID),
    Foreign Key (Warehouse_ID) References warehouse(Warehouse_ID)
);

-- Delivery Table
Create Table delivery (
    Order_ID Varchar(20),
    Expected_Delivery_Date Date,
    Actual_Delivery_Date Date,
    Delay_Days Int,
    Delivery_Status Varchar(20),
    Delay_Category Varchar(10),

    Foreign Key (Order_ID) References orders(Order_ID)
);

-- Product Table
Create Table product (
    Product_ID Varchar(20) Primary Key,
    Category Varchar(50),
    Sub_Category Varchar(50),
    Weight Decimal(10,2),
    Base_Price Decimal(10,2)
);

-- Warehouse Table
Create Table warehouse (
    Warehouse_ID Varchar(20) Primary Key,
    Warehouse_Location Varchar(50),
    Capacity Int,
    Region Varchar(20)
);

-- Cost Table 
Create Table cost (
    Shipment_ID Varchar(20),
    Shipping_Cost Decimal(10,2),
    Fuel_Cost Decimal(10,2),
    Handling_Cost Decimal(10,2),
    Total_Cost Decimal(12,2),
    Foreign Key (Shipment_ID) References shipments(Shipment_ID)
);

-- =====================================
-- SECTION 2: DATA LOADING
-- =====================================

-- order table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Order_ID,
 Order_Date,
 Customer_ID,
 Product_ID,
 Order_Quantity,
 Unit_Price,
 Discount,
 Order_Amount,
 Payment_Mode,
 Revenue_Category,
 Discount_Flag);
 
-- warehouse table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/warehouse.csv'
INTO TABLE warehouse
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Warehouse_ID,
 Warehouse_Location,
 Capacity,
 Region);
 
-- shipment table
 LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Shipments.csv'
INTO TABLE shipments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Shipment_ID,
 Order_ID,
 Ship_Date,
 Delivery_Date,
 Shipping_Mode,
 Carrier,
 Warehouse_ID,
 Shipping_Time,
 Delivery_Speed);

-- delivery table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Delivery.csv'
INTO TABLE delivery
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Order_ID,
 Expected_Delivery_Date,
 Actual_Delivery_Date,
 Delivery_Status,
 Delay_Days,
 Delay_Category);
 
-- product table
 LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product.csv'
INTO TABLE product
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Product_ID,
 Category,
 Sub_Category,
 Weight,
 Base_Price);
 
-- cost table
-- step - 1 create temporary table
CREATE TABLE cost_temp LIKE cost;

-- then loaded raw data into temp temporary table 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cost.csv'
INTO TABLE cost_temp
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- then insert value in main cost table by filterting and taking reference from shipment_id from shipment table
INSERT INTO cost
SELECT *
FROM cost_temp c
WHERE c.Shipment_ID IN (
    SELECT Shipment_ID FROM shipments
);

-- then Droped temporary table (optional but recommended)
Drop table cost_temp;
