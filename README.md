# 🚀 Sales Insights Dashboard - Insurance Company

## Overview

This project aims to build a **Sales Insights Dashboard** for a fictional insurance company, providing real-time, data-driven insights into sales performance, customer behavior, and financial outcomes. The dashboard will enable quick, automated decision support for stakeholders, leveraging key technologies such as **Snowflake**, **DBT**, **Tableau**, and **Apache Airflow**.

### 📊 Business Questions Addressed
- **Product Performance**: Which insurance products are performing best?
- **Customer Segmentation**: Who's buying which insurance products?
- **Sales Trends & Forecasting**: What does the future hold for sales?
- **Geographical Insights**: How do sales vary across regions?
- **Revenue & Profit Optimization**: Where is growth happening, and how are margins performing?

## 🛠️ Technologies Used
- **Snowflake**: Raw data storage and warehousing
- **DBT**: Data transformations and modeling
- **Apache Airflow**: Data orchestration and automation
- **Tableau**: Data visualization and dashboards
- **GitHub**: Version control and repository management

## 🎯 Problem Statements
The sales director is looking to understand the company's performance across multiple dimensions:
- **Top-performing insurance products**
- **Customer segments most likely to purchase**
- **Future sales forecasts**
- **Regional sales performance**
- **Revenue and profit margins**

## 🔄 Workflow
1. **Data Ingestion**: Load local files into Snowflake.
2. **Transformation**: Transform the raw data using DBT.
3. **Data Views**: Use Snowflake views to create the final data model.
4. **Orchestration**: Automate the data pipeline using Apache Airflow.
5. **Visualization**: Build insightful dashboards in Tableau.

## 📈 Key Insights
- Top-performing insurance products.
- Most profitable customer segments.
- Sales forecasts and trend analysis.
- Regional breakdown of sales performance.
- Revenue growth and profit margins.

## 👨‍💻 Certifications 📜
The following certifications were obtained to ensure the successful implementation of this project:
- **Data Visualization with Tableau** (Cognizant LED training)
- **Snowflake Hands-on Essentials Data Engineering Badge** (Snowflake)
- **DBT Tool Certification** (Udemy)
- **Apache Airflow Certification** (LinkedIn Learning)
- **GitHub** (YouTube)

## 📝 Setup Instructions

### Step 1: Generate Dummy Data
Use the Python `faker` library to generate synthetic data for agents, customers, policies, and claims.

### Step 2: Import Data into Snowflake
Load the generated data into Snowflake and perform any necessary ETL processes.

### Step 3: Setup DBT Environment
- Sign up for a free trial of DBT.
- Create a DBT environment and connect it to the Snowflake database.

### Step 4: Install Apache Airflow
- Install Apache Airflow locally.
- Create and schedule DAGs to automate data pipeline workflows.

### Step 5: Download Tableau
- Download **Tableau Public** (Free) or **Tableau Desktop** (14-day trial).
- Connect Tableau to the Snowflake database and create visualizations.

### Step 6: Save Tableau Dashboard
- Save your Tableau file as `.twb` or `.twbx` for sharing and publishing.

---

## 👥 Stakeholders
- **Sales Director**: Decision-maker seeking insights for better strategy.
- **I.T. Team**: Ensures smooth integration and data flow.
- **Customer Service Team**: Understands customer behavior through insights.
- **Data & Analytics Team**: Builds, monitors, and enhances the dashboard.

## 🎯 Project Goal
The goal is to unlock key sales insights that were previously inaccessible, automate data gathering processes, and support decision-making with a self-updating dashboard.

---

## 📈 Future Enhancements
- **Advanced Forecasting Models**: Integrate ML models for enhanced sales prediction.
- **Real-Time Data Ingestion**: Set up streaming data pipelines.
- **Enhanced User Experience**: Add more interactive visualizations.

## 🛠 Project Maintenance
For any issues or feature requests, please create an issue in this repository.
