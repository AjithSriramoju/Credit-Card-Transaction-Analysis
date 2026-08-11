# 📊 Dataset

This folder contains the dataset used for the **Credit Card Transaction Analysis** project.

The dataset was used to analyze credit card transactions, customer behavior, merchant activity, transaction patterns, and fraudulent transactions.

---

## 📌 Dataset Overview

The original dataset contains transaction, customer, merchant, geographic, demographic, and fraud-related information.

| Metric | Value |
|---|---:|
| Total Records | 1,296,675 |
| Original Columns | 24 |
| Processed Columns | 29 |
| Domain | Credit Card Transactions |

During Python data preparation and feature engineering, additional analytical columns were created, resulting in a processed dataset containing **29 columns**.

---

## 📂 Data Categories

The dataset contains information related to:

- Transaction details
- Customer information
- Merchant information
- Transaction categories
- Geographic information
- Customer demographics
- Fraud indicators
- Date and time attributes

---

## 🧹 Data Preparation

Python was used to prepare the dataset before performing SQL analysis and Power BI visualization.

The data preparation process included:

- Loading the raw dataset
- Inspecting the dataset structure
- Checking missing values
- Checking duplicate records
- Removing unnecessary columns
- Converting date/time columns into appropriate formats
- Creating analytical date and time features
- Exporting the processed dataset for further analysis

---

## ⚙️ Feature Engineering

Additional analytical fields were created from the transaction timestamp.

The processed dataset contains the following time-based features:

- Year
- Month
- Month Name
- Day
- Day Name
- Hour

These features were used for time-based analysis and Power BI visualizations.

---

## 🔍 Dataset Usage

The processed dataset was used throughout the project for:

### Python

- Data cleaning
- Feature engineering
- Exploratory Data Analysis
- Transaction analysis
- Fraud analysis
- Time-based analysis
- Data visualization

### PostgreSQL

- Business-oriented SQL analysis
- Transaction KPIs
- Customer analysis
- Merchant analysis
- Category analysis
- Fraud analysis
- Aggregations
- Ranking and analytical queries

### Power BI

The processed dataset was used to build an interactive three-page Power BI report covering:

1. **Executive Overview**
2. **Fraud & Risk Analysis**
3. **Customer & Transaction Analysis**

---

## 📈 Key Dataset Metrics

The dataset supports analysis of:

- Total transactions
- Total transaction amount
- Average transaction amount
- Fraud transactions
- Fraud percentage
- Customer transaction behavior
- Merchant transaction activity
- Transaction categories
- Transaction trends over time
- Fraud patterns across categories and time

---

## 🔗 Project Workflow

```text
Raw Dataset
     ↓
Python Data Cleaning
     ↓
Feature Engineering
     ↓
Exploratory Data Analysis
     ↓
PostgreSQL Analysis
     ↓
Power BI Report
     ↓
Business Insights



## 🛠️ Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- PostgreSQL
- SQL
- Power BI

---

## 📁 Dataset Role in the Project

The dataset acts as the foundation of the complete end-to-end analytics workflow.

The same prepared data was used to generate analytical results in Python, PostgreSQL, and Power BI.

---

## 👤 Author

**Ajith Sriramoju**

Aspiring Data Analyst | Python | SQL | Power BI | Excel

- GitHub: Ajith Sriramoju( https://github.com/AjithSriramoju )
- LinkedIn: Ajith Sriramoju( https://www.linkedin.com/in/sriramojuajith/ )
