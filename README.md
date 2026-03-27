# 📦 Logistics & Supply Chain Analytics Project

---

## 🚀 Project Title  
**Logistics & Supply Chain Analytics Dashboard**

---

## 📖 Project Overview  
This project focuses on analyzing logistics and supply chain operations using a complete data analytics pipeline. It covers data cleaning, transformation, analysis, and visualization using Excel, SQL, Python, and Power BI.

The goal is to extract meaningful insights related to logistics cost, delivery performance, and operational efficiency to support data-driven decision-making.

---

## ❗ Problem Statement  
Logistics operations often suffer from high costs and delivery inefficiencies. 
This project analyzes data to identify cost drivers and improve performance.

---

## 📊 Dataset Description  

The dataset consists of multiple relational tables:

- Orders → Customer orders and transaction details 
- Shipments → Shipping and transportation details  
- Delivery → Delivery performance and delays  
- Product → Product category and weight  
- Warehouse → Warehouse location and capacity 
- Cost → Logistics cost breakdown  

---

## 🧠 Data Modelling (ER Diagram)

- Orders → Shipments (1:M)  
- Orders → Delivery (1:1)  
- Orders → Product (M:1)  
- Shipments → Warehouse (M:1)  
- Shipments → Cost (1:1)  

![ER-Diagram](ER_diagram.png)

---

## 🎯 Objectives & KPIs  

### 🔹 Objectives:
- Analyze logistics cost drivers  
- Evaluate delivery performance  
- Identify inefficiencies  
- Understand impact of shipping modes  

### 🔹 KPIs:
- Total Logistics Cost  
- Total Orders  
- Average Cost per Order  
- Average Delivery Delay  
- On-Time / Late Delivery %  

---

## 🏗️ Project Structure  
Logistics-Analytics-Project/

│

├── Data/

│ ├── Raw_dataset/

│ └── Cleaned_dataset/

│

├── Sql_Scripts/

│ ├── database_setup.sql

│ └── logistics_analysis.sql

│

├── Python_Notebook/

│ └── logistics_eda_analysis.ipynb

│

├── Power_BI/

│ └── logistics_&_supply_chain_dashboard.pbix

│

├── images/

│ ├── Overview_Dashboard.png

│ ├── Deep Analysis Dashboard.png

│ └── ER diagram.png

│

└── README.md

---

## 📊 Dashboard Preview  

This project includes **two interactive dashboards**:

### 🔹 1. Overview Dashboard  
- Displays key KPIs such as Total Cost, Total Orders, Average Cost, and Average Delay  
- Shows cost distribution by region and shipping mode  
- Includes delivery performance breakdown  
- Monthly trend analysis of logistics cost  

![Overview Dashboard](Images/Overview_Dashboard.png)

---

### 🔹 2. Deep Analysis Dashboard  
- Provides detailed insights into cost drivers  
- Cost distribution by product category  
- Delivery performance vs cost analysis  
- Shipping mode vs delay comparison  
- Matrix view for regional cost patterns  

![Deep Analysis Dashboard](Images/Deep_Analysis_Dashboard.png)    

### 🔹Key Features:
- KPI cards (Cost, Orders, Delay)
- Cost analysis by region and shipping mode
- Delivery performance distribution
- Trend analysis over time
- Deep analysis using advanced visuals

---

## 🛠️ Tools & Technologies  

- Excel → Data Cleaning & Preprocessing
- SQL (MySQL) → Data Analysis & Modeling
- Python (Pandas, Matplotlib) → EDA & Visulization 
- Power BI → Interactive Dashboard  
- DAX → KPI Measures  

---

## 📌 Sample Business Questions  

- Which cost component contributes the most?  
- Which region has the highest logistics cost?  
- Does delivery delay impact cost?  
- Which shipping mode is most expensive?  
- What are the top cost drivers?  

---

## 🏁 Final Outcome / Conclusion  

- Logistics cost is influenced by multiple factors such as shipping mode, delivery delays, and regional operations  
- Delivery timelines are conservatively estimated, with a majority of deliveries completed early  
- Certain regions contribute disproportionately to total cost  
- Shipping mode plays a key role in cost vs efficiency trade-off  

---

## 🎤 Project Summary  

This project demonstrates end-to-end data analysis including:
- Data cleaning and transformation  
- SQL-based analysis  
- Python-based EDA  
- Power BI dashboard creation  

---

## 👤 Author  
**Paras Sukheja**





























