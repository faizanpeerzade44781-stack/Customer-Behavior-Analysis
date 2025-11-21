# Customer-Behavior-Analysis
An end-to-end data analytics project using Python, SQL, and Power BI to clean data, generate KPIs, and build an interactive dashboard for customer purchase behavior insights.
🛍️ Customer Shopping Behavior Analysis

📖 Overview

This end-to-end data analytics project investigates customer shopping patterns to identify key revenue drivers and opportunities for loyalty program growth. The project simulates a real-world corporate workflow: cleaning raw data in Python, warehousing it in SQL Server, and delivering actionable insights via Power BI.

💾 Dataset

The dataset contains retail transaction records including:

Demographics: Age, Gender, Subscription Status.

Transactional: Purchase Amount (USD converted to INR), Frequency, Payment Method.

Product: Category, Size, Color, Season.

Engagement: Review Ratings, Discount Usage, Promo Codes.

🧰 Tools & Technologies

Tool

Usage

Python (Pandas/NumPy)

Data cleaning, handling missing values, and feature engineering.

SQL Server (SSMS)

Data storage and advanced SQL querying for EDA.

SQLAlchemy

Establishing a direct ETL pipeline from Python to SQL.

Power BI

Creating the interactive dashboard and DAX measures.

🔄 Project Workflow & Steps

1. Data Cleaning & Processing (Python)

Imputation: Handled missing Review Rating values by calculating the median rating per specific Category to ensure accuracy.

Standardization: Renamed all columns to snake_case for SQL compatibility.

Currency Conversion: Converted Purchase Amount from USD to INR (rate: 88) to localize the context.

2. Feature Engineering

Age Segmentation: Created a new age_group column to classify users into Young Adult, Adult, Middle Age, and Senior.

Frequency Quantification: Mapped text-based frequencies (e.g., "Fortnightly") to numeric values (e.g., 14 days) for analytical sorting.

3. Database Management (SQL)

Established a connection to the local MSSQLSERVER01 instance.

Automated the data load directly from the Pandas DataFrame to the customer_behavior table.

4. Exploratory Data Analysis (SQL)

Executed complex SQL queries to answer business questions:

How does shipping type affect spending?

Who are the high-value customers using discounts?

What is the retention rate based on previous purchases?

📊 Dashboard Insights

The Power BI Dashboard highlights the following KPIs:

Total Revenue: ₹21M

Avg Purchase Value: ₹5.26K

Avg Customer Rating: 3.75/5.0

Key Visuals:

Subscription Gap: A Donut Chart revealing that 92.7% of customers are non-subscribers.

Category Leader: "Clothing" is the dominant category for both revenue (₹9.2M) and volume.

Demographic Spread: Purchasing power is evenly distributed across all age groups, debunking the assumption that only "Young Adults" drive fashion sales.

📈 Key Results & Recommendations

Subscription Opportunity: The low subscription rate (7.3%) is a major growth area. I recommend targeting "Recurring" customers (identified via SQL as those with 5-15 purchases) with exclusive offers.

Inventory Focus: Clothing and Accessories account for ~75% of total revenue; stock should be optimized around these categories.

Shipping Preference: There is a minimal spend difference between "Standard" and "Express" shipping users, suggesting logistics costs could be optimized without hurting revenue.

🚀 How to Run

Clone the Repo:

git clone [https://github.com/yourusername/customer-shopping-analysis.git](https://github.com/yourusername/customer-shopping-analysis.git)


Install Requirements:

pip install pandas numpy sqlalchemy pyodbc


Setup SQL:

Create database customer_behaviorr.

Update the connection string in analysis_script.py.

Execute Pipeline:

python analysis_script.py


View Dashboard:

Open .pbix file and refresh data.

Created by [Sayed Faizan]
