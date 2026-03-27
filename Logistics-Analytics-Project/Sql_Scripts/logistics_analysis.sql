-- Project: Logistics & Supply Chain Analytics
-- Description: SQL queries for cost, delivery, and performance analysis
-- Author: Paras Sukheja

-- Business Question 1: Which cost component contributes the most to total logistics cost?
select sum(Shipping_Cost) as total_shipping_cost,
sum(Fuel_Cost) as total_fuel_cost,
sum(Handling_Cost) as total_handling_cost
from cost;

-- Business Question 2: What is the total logistics cost across all shipments?
select sum(Total_Cost) as total_logistic_cost
from cost;

-- Business Questions 3: Which shipping mode has the highest average cost per shipment?
select s.Shipping_Mode, avg(c.Total_Cost) as avg_cost, count(*) as total_shipments
from shipments s inner join cost c
on s.Shipment_ID = c.Shipment_ID
group by s.Shipping_Mode
order by avg_cost DESC;

-- Businnes Questions 4: Does faster delivery result in higher logistics cost?
select s.Delivery_Speed, avg(c.Total_Cost) as avg_cost
from shipments s inner join cost c
on s.Shipment_ID = c.Shipment_ID
group by s.Delivery_Speed
order by avg_cost DESC;

-- Business Questions 5: Do delayed shipments incur higher cost than on-time deliveries?
select d.Delivery_Status, avg(c.Total_Cost) as avg_cost
from delivery d 
inner join shipments s on d.Order_ID = s.Order_ID
inner join cost c on s.Shipment_ID = c.Shipment_ID
group by d.Delivery_Status;

-- Businees Question 6: What is the average delay by shipping mode?
select s.Shipping_Mode, avg(d.Delay_Days) as avg_delay
from shipments s 
inner join delivery d on s.Order_ID = d.Order_ID
group by s.Shipping_Mode;

-- Business Question 7: Which warehouse contributes the highest logistics cost?
select s.Warehouse_ID, sum(c.Total_Cost) as total_cost
from shipments s inner join cost c
on s.Shipment_ID = c.Shipment_ID
group by s.Warehouse_ID
order by total_cost DESC;

-- Business Question 8: Which region has the highest logistics cost?
select w.Region, sum(c.Total_Cost) as total_cost
from warehouse w 
inner join shipments s on w.Warehouse_ID = s.Warehouse_ID
inner join cost c on s.Shipment_ID = c.Shipment_ID
group by w.Region
order by total_cost DESC;

-- Business Question 9: Which warehouses have above-average logistics cost?
with warehouse_cost as(
select s.Warehouse_ID, sum(c.Total_Cost) as total_cost
from shipments s inner join cost c
on s.Shipment_ID = c.Shipment_ID
group by s.Warehouse_ID
)
select * from warehouse_cost 
where total_cost > ( select avg(total_cost) from warehouse_cost);

-- Business Question 10: Which revenue category generates the highest logistics cost?
select o.Revenue_Category, sum(c.Total_Cost) as total_cost
from orders o 
inner join shipments s on o.Order_ID = s.Order_ID
inner join cost c on s.Shipment_ID = c.Shipment_ID
group by o.Revenue_Category
order by total_cost DESC;

-- Business Question 11: Do higher order quantities lead to higher logistics cost?
select 
	case
		when o.Order_Quantity <=3 then 'Low'
		when o.Order_Quantity <=7 then 'Medium'
		else 'High'
	end as quantity_group,
	avg(c.Total_Cost) as avg_cost
from orders o 
inner join shipments s on o.Order_ID = s.Order_ID
inner join cost c on s.Shipment_ID = c.Shipment_ID
group by quantity_group;

-- Business Question 12: Which payment mode has the highest logistics cost?
select o.Payment_Mode, sum(c.Total_Cost) as total_cost, count(*) as total_orders
from orders o 
inner join shipments s on o.Order_ID = s.Order_ID
inner join cost c on s.Shipment_ID = c.Shipment_ID
group by o.Payment_Mode
order by total_cost DESC;

-- Business Question 13: Which product category contributes most to logistics cost?
select p.Category, sum(c.Total_Cost) as total_cost
from product p 
inner join orders o on p.Product_ID = o.Product_ID
inner join shipments s on o.Order_ID = s.Order_ID
inner join cost c on s.Shipment_ID = c.Shipment_ID
group by p.Category
order by total_cost DESC;

-- Business Question 14: Does product weight impact logistics cost?
select 
	case
		when p.Weight < 2 then 'Light'
        when p.Weight < 5 then 'Medium'
        else 'Heavy'
	end as weight_group,
	avg(c.Total_Cost) as avg_cost
from product p
inner join orders o on p.Product_ID = o.Product_ID
inner join shipments s on o.Order_ID = s.Order_ID
inner join cost c on s.Shipment_ID = c.Shipment_ID
group by weight_group;

-- Business Question 15: Rank shipments based on total cost
select Shipment_ID, Total_Cost,
rank() over(order by Total_Cost DESC) as cost_rank
from cost;

-- Business Question 16: Which shipments have cost significantly higher than the overall average?
select Shipment_ID, Total_Cost,
avg(Total_Cost) over() as avg_cost,
Total_Cost - avg(Total_Cost) over() as deviation
from cost
order by deviation DESC;

-- Business Question 17: Which are the top 3 most expensive shipments in each shipping mode?
with shipment_rank as (
select s.Shipment_ID, s.Shipping_Mode, c.Total_Cost,
rank() over(partition by s.Shipping_Mode order by c.Total_Cost DESC) as rnk
from shipments s inner join cost c
on s.Shipment_ID = c.Shipment_ID
)
select * from shipment_rank
where rnk <=3;

-- Business Question 18: How does total cost accumulate over shipment dates?
select s.Ship_Date,
sum(c.Total_Cost) over(order by s.Ship_date, s.Shipment_ID) as running_total
from shipments s inner join cost c
on s.Shipment_ID = c.Shipment_ID;


-- view created to import the data in python for analysis

CREATE OR REPLACE VIEW logistics_view AS
SELECT 
    o.Order_ID,
    o.Order_Date,
    o.Order_Quantity,
    o.Order_Amount,
    o.Payment_Mode,
    o.Revenue_Category,

    p.Category,
    p.Weight,
	
    s.Shipment_ID,
    s.Shipping_Mode,
    s.Warehouse_ID,
    s.Shipping_Time,
    s.Delivery_Speed,

    w.Region,

    d.Delay_Days,
    d.Delay_Category,

    c.Total_Cost

FROM orders o
JOIN product p ON o.Product_ID = p.Product_ID
JOIN shipments s ON o.Order_ID = s.Order_ID
JOIN warehouse w ON s.Warehouse_ID = w.Warehouse_ID
JOIN delivery d ON o.Order_ID = d.Order_ID
JOIN cost c ON s.Shipment_ID = c.Shipment_ID;



