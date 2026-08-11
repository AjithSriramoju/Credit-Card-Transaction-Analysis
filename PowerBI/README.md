# 📊 Power BI Report

This folder contains the documentation for the Power BI report created for the **Credit Card Transaction & Fraud Analysis** project.

The report transforms the results from Python and PostgreSQL analysis into an interactive business intelligence solution.

---

## 🎯 Report Objective

The Power BI report was designed to provide stakeholders with an interactive view of:

- Overall transaction performance
- Transaction amount trends
- Fraud activity and risk patterns
- Customer transaction behavior
- Category-level transaction analysis
- Merchant-level transaction analysis
- Time-based transaction patterns

---

## 📑 Report Pages

The Power BI report contains three interactive pages.

### 1. Executive Overview

Provides a high-level summary of overall credit card transaction performance.

#### Key KPIs

- **Total Transactions:** 1,296,675
- **Total Transaction Amount:** 91.22M
- **Average Transaction Amount:** 70.35
- **Fraud Transactions:** 7,506
- **Fraud Percentage:** 0.58%

#### Analysis

- Transaction amount trends
- Transaction analysis by category
- Transaction analysis by merchant
- Fraud vs. non-fraud transactions
- Interactive slicers

---

### 2. Fraud & Risk Analysis

Focuses on fraudulent transactions and risk patterns.

#### Key KPIs

- **Fraud Transactions:** 7,506
- **Fraud Percentage:** 0.58%
- **Average Fraud Transaction Amount:** 531.32
- **Non-Fraud Transaction Amount:** 87.23M
- **Fraud Transaction Amount:** 3.99M

#### Analysis

- Fraud trends over time
- Fraud rate by category
- Fraud transactions by category
- Fraud analysis by gender
- Time-based fraud analysis
- Interactive slicers

---

### 3. Customer & Transaction Analysis

Focuses on customer behavior and detailed transaction patterns.

#### Key KPIs

- **Unique Customers:** 983
- **Transactions per Customer:** 1.32K
- **Average Transaction Amount:** 70.35
- **Median Transaction Amount:** 47.52
- **Maximum Transaction Amount:** 28.95K

#### Analysis

- Year-over-Year transaction analysis
- Transaction amount by category
- Top merchants by transaction amount
- Transactions by hour
- Customer transaction behavior
- Interactive slicers

---

## 🧮 DAX & Calculations

The report uses DAX measures for business KPIs and time-based analysis.

Examples include:

- Total Transactions
- Total Transaction Amount
- Average Transaction Amount
- Fraud Transactions
- Fraud Percentage
- Previous Year Transactions
- Year-over-Year analysis
- Customer-level KPIs

Time intelligence was implemented using a dedicated date table and functions such as `SAMEPERIODLASTYEAR`.

---

## 🎛️ Interactivity

The report includes:

- Slicers
- Filters
- KPI cards
- Interactive charts
- Page navigation
- Cross-filtering
- Consistent report-wide design

Users can navigate between:

**Executive Overview → Fraud & Risk Analysis → Customer & Transaction Analysis**

using the navigation buttons.

---

## 🎨 Report Design

The report was designed with a consistent professional layout across all three pages.

Design elements include:

- Consistent color theme
- KPI cards
- Structured visual layout
- Sidebar navigation
- Credit-card branding
- Page navigation buttons
- Interactive slicers
- Consistent headings and spacing

---

## 📸 Dashboard Screenshots

Dashboard screenshots are available in the project's `Screenshots` folder.

### Executive Overview

![Executive Overview](../Screenshots/Executive_Overview.png)

### Fraud & Risk Analysis

![Fraud & Risk Analysis](../Screenshots/Fraud_Risk_Analysis.png)

### Customer & Transaction Analysis

![Customer & Transaction Analysis](../Screenshots/Customer_Transaction_Analysis.png)

---

## 📁 Power BI File

The original Power BI `.pbix` file is approximately **125 MB** and is therefore not uploaded through GitHub's standard web upload.

The dashboard screenshots included in this repository provide a visual representation of the completed report.

---

## 🔄 Data Flow

```text
Raw Credit Card Dataset
          ↓
Python Data Cleaning
          ↓
Feature Engineering
          ↓
Processed Dataset
          ↓
PostgreSQL Analysis
          ↓
Power BI Data Model
          ↓
DAX Measures
          ↓
3-Page Interactive Report
          ↓
Business Insights
```

---

## 🛠️ Technologies Used

- Power BI Desktop
- Power Query
- DAX
- Data Modeling
- PostgreSQL
- Python

---

## 👤 Author

**Ajith Sriramoju**

Aspiring Data Analyst | Python | SQL | Power BI | Excel

- GitHub: [Ajith Sriramoju](https://github.com/AjithSriramoju)
- LinkedIn: [Ajith Sriramoju](https://www.linkedin.com/in/sriramojuajith/)
