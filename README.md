<div align="center">

# 🛍️ Customer Shopping Behavior Analysis

**End-to-end ETL pipeline (Python → SQL Server → Power BI) uncovering the customer subscription rate as the key growth lever.**

![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=flat-square&logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![SQLAlchemy](https://img.shields.io/badge/SQLAlchemy-D71F00?style=flat-square&logo=python&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

`#data-analytics` `#python` `#sql-server` `#power-bi` `#etl` `#customer-analytics` `#pandas`

</div>

<p align="center"><img src="assets/dashboard_preview.png" alt="Customer Behavior Dashboard" width="850"/></p>

---

## 📖 Table of Contents
- [Business Problem](#-business-problem)
- [Objectives](#-objectives)
- [Dataset](#-dataset)
- [Tech Stack](#-tech-stack)
- [Folder Structure](#-folder-structure)
- [Installation](#-installation)
- [Data Cleaning Steps](#-data-cleaning-steps)
- [Python Workflow](#-python--etl-workflow)
- [SQL Exploration](#-sql-exploration)
- [Power BI Dashboard](#-power-bi-dashboard)
- [KPIs](#-kpis)
- [Business Insights](#-business-insights)
- [Recommendations](#-recommendations)
- [Dashboard Screenshots](#️-dashboard-screenshots)
- [Future Improvements](#-future-improvements)
- [License](#-license)
- [Acknowledgements](#-acknowledgements)

---

## 🧩 Business Problem

A retailer wants to grow its subscription program but doesn't know which levers actually move subscription and repeat-purchase behavior. Raw transactional data exists but has never been cleaned, warehoused, or turned into a dashboard leadership can act on — this project simulates that corporate workflow end-to-end.

## 🎯 Objectives

- Clean and standardize raw customer shopping data for analysis
- Warehouse the data in SQL Server via an automated Python → SQL load
- Compute customer-level KPIs (CLV, repeat-purchase rate, basket size)
- Build a Power BI dashboard to surface subscription and category insights
- Recommend concrete actions to grow the subscriber base

## 💾 Dataset

| Attribute | Detail |
|---|---|
| Format | `.csv` |
| Granularity | One row per customer transaction |
| Currency | Originally USD, converted to INR (rate: 88) for local context |

**Fields captured**

- **Demographics:** Age, Gender, Subscription Status
- **Transactional:** Purchase Amount, Frequency, Payment Method
- **Product:** Category, Size, Color, Season
- **Engagement:** Review Ratings, Discount Usage, Promo Codes

## 🧰 Tech Stack

| Layer | Tools |
|---|---|
| Cleaning & feature engineering | Python (Pandas, NumPy) |
| ETL to warehouse | SQLAlchemy → SQL Server |
| Querying / EDA | SQL Server (SSMS) |
| Dashboard | Power BI (DAX) |

## 📁 Folder Structure

```
Customer-Behavior-Analysis/
│
├── data/
│   └── customer_shopping_behavior.csv
│
├── notebooks/
│   └── Cleaned_Data.ipynb               # Cleaning, feature engineering, SQL load
│
├── sql/
│   └── customer_behavior_project.sql    # EDA & business-question queries
│
├── dashboard/
│   └── Customer_Behavior.pbix
│
├── assets/
│   └── dashboard_preview.png
│
├── README.md
└── LICENSE
```

## ⚙️ Installation

```bash
# 1. Clone the repository
git clone https://github.com/faizanpeerzade44781-stack/Customer-Behavior-Analysis.git
cd Customer-Behavior-Analysis

# 2. Create a virtual environment
python -m venv venv
source venv/bin/activate      # Windows: venv\Scripts\activate

# 3. Install dependencies
pip install pandas numpy sqlalchemy pyodbc jupyter

# 4. Configure your SQL Server connection string in the notebook,
#    then run the ETL cells to load data into the `customer_behavior` table

# 5. Open the dashboard
#    Open dashboard/Customer_Behavior.pbix in Power BI Desktop and refresh
```

## 🧹 Data Cleaning Steps

- **Imputation:** filled missing `review_rating` values using the median rating *per product category* (category-aware, not a global median)
- **Standardization:** renamed all columns to `snake_case` for SQL compatibility
- **Currency conversion:** converted `purchase_amount` from USD to INR (rate: 88) to localize reporting
- **Feature engineering:**
  - `age_group`: bucketed into Young Adult / Adult / Middle Age / Senior
  - Numeric frequency mapping: text values like *"Fortnightly"* converted to day-counts (e.g., 14) for proper numeric sorting

## 🐍 Python + ETL Workflow

1. Load raw CSV with Pandas
2. Clean, impute, and feature-engineer as above
3. Connect to a local SQL Server instance via SQLAlchemy
4. Load the cleaned DataFrame directly into a `customer_behavior` SQL table
5. Hand off to SQL for exploratory querying and Power BI for visualization

## 🗄️ SQL Exploration

Representative business questions answered directly in SQL against the warehoused table:

- How does shipping type (Standard vs. Express) affect average spend?
- Who are the high-value customers who also use discounts?
- What does the retention/repeat-purchase pattern look like based on purchase history?

## 📊 Power BI Dashboard

- KPI cards: Total Revenue, Avg Purchase Value, Avg Customer Rating
- Subscription-status donut chart
- Category-wise revenue and volume breakdown
- Age-group spend distribution

## 📈 KPIs

| KPI | Value |
|---|---|
| Total Revenue | **₹21M** |
| Average Purchase Value | **₹5.26K** |
| Average Customer Rating | **3.75 / 5.0** |
| Subscriber Share | **7.3%** |
| Non-Subscriber Share | **92.7%** |

## 💡 Business Insights

- **Subscription gap:** only **7.3%** of customers are subscribers — this is the single largest visible growth lever in the dataset
- **Category leader:** *Clothing* dominates both revenue (**₹9.2M**) and order volume
- **Demographic spread:** purchasing power is fairly even across all age groups — the common assumption that "Young Adults" drive most fashion spend does **not** hold in this data
- **Shipping preference:** minimal spend difference between Standard and Express shipping customers

## ✅ Recommendations

1. **Target "recurring" customers for subscription conversion** — customers identified in SQL with 5–15 historical purchases are the highest-propensity subscription candidates; offer them an exclusive incentive
2. **Concentrate inventory investment in Clothing and Accessories**, which together account for ~75% of total revenue
3. **Stop age-targeting assumptions** in marketing — since spend is evenly distributed by age, campaigns should segment by behavior (frequency, discount usage) instead of age bracket
4. **Reconsider Express shipping premiums** — since the spend delta vs. Standard is minimal, logistics cost could potentially be optimized without hurting revenue

## 🖼️ Dashboard Screenshots

<!-- Replace with real exported PNGs -->
<p align="center">
  <img src="assets/subscription_donut.png" alt="Subscription Breakdown" width="45%"/>
  <img src="assets/category_revenue.png" alt="Category Revenue" width="45%"/>
</p>

## 🔮 Future Improvements

- [ ] A/B test framework to measure the impact of a subscription incentive campaign
- [ ] Cohort analysis of repeat-purchase behavior over time (currently a single-snapshot view)
- [ ] Automate the Python → SQL Server load as a scheduled job instead of a manual notebook run
- [ ] Add RFM (Recency, Frequency, Monetary) segmentation
- [ ] Migrate the `.pbix` to Power BI Service with scheduled refresh

## 📄 License

Licensed under the [MIT License](LICENSE).

## 🙏 Acknowledgements

Built as an independent portfolio project by **Sayed Faizan Peerzade**, using a publicly available customer shopping behavior dataset for demonstration purposes.

---

<div align="center">

📧 [faizanpeerzade44781@gmail.com](mailto:faizanpeerzade44781@gmail.com) · 💼 [LinkedIn](https://www.linkedin.com/in/sayed-peerzade-82377a24a) · 🐙 [GitHub](https://github.com/faizanpeerzade44781-stack)

</div>
