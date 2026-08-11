import pandas as pd

df = pd.read_csv(
    "Credit Card Transactions Dataset/credit_card_transactions_cleaned.csv"
)

# print(df.head())

# print(df.shape)



# ==========================================================
# EDA 1 : Total Number of Transactions
# ==========================================================

total_transactions = len(df)

print("Total Transactions :", total_transactions)


# ==========================================================
# EDA 2 : Total Transaction Amount
# ==========================================================

total_amount = df["amt"].sum()

print(f"Total Transaction Amount : ${total_amount:,.2f}")


# ==========================================================
# EDA 3 : Average Transaction Amount
# ==========================================================

average_amount = df["amt"].mean()

print(f"Average Transaction Amount : ${average_amount:,.2f}")


# ==========================================================
# EDA 4 : Minimum & Maximum Transaction Amount
# ==========================================================

minimum_amount = df["amt"].min()
maximum_amount = df["amt"].max()

print(f"Minimum Transaction Amount : ${minimum_amount:,.2f}")
print(f"Maximum Transaction Amount : ${maximum_amount:,.2f}")


print("=" * 55)
print("      CREDIT CARD TRANSACTION KPI SUMMARY")
print("=" * 55)

print(f"Total Transactions       : {total_transactions:,}")
print(f"Total Amount             : ${total_amount:,.2f}")
print(f"Average Transaction      : ${average_amount:,.2f}")
print(f"Minimum Transaction      : ${minimum_amount:,.2f}")
print(f"Maximum Transaction      : ${maximum_amount:,.2f}")

print("=" * 55)



# ==========================================================
# EDA 5 : Fraud Analysis
# ==========================================================

# Total Fraud Transactions
fraud_transactions = df["is_fraud"].sum()

# Fraud Rate
fraud_rate = (fraud_transactions / total_transactions) * 100

print(f"Fraud Transactions      : {fraud_transactions:,}")
print(f"Fraud Rate              : {fraud_rate:.2f}%")


# ==========================================================
# EDA 6 : Genuine Transactions
# ==========================================================

genuine_transactions = total_transactions - fraud_transactions

print(f"Genuine Transactions    : {genuine_transactions:,}")




# ==========================================================
# EDA 7 : Transaction Count by Category
# ==========================================================

category_transactions = (
    df.groupby("category")
      .size()
      .sort_values(ascending=False)
)

print(category_transactions)


# ==========================================================
# EDA 8 : Total Transaction Amount by Category
# ==========================================================

category_amount = (
    df.groupby("category")["amt"]
      .sum()
      .sort_values(ascending=False)
)

print(category_amount)

# ==========================================================
# EDA 9 : Average Transaction Amount by Category
# ==========================================================

category_average = (
    df.groupby("category")["amt"]
      .mean()
      .sort_values(ascending=False)
)

print(category_average)


# ==========================================================
# EDA 10 : Fraud Transactions by Category
# ==========================================================

fraud_category = (
    df[df["is_fraud"] == 1]
      .groupby("category")
      .size()
      .sort_values(ascending=False)
)

print(fraud_category)



# ==========================================================
# EDA 11 : Fraud Rate by Category (%)
# ==========================================================

fraud_rate_category = (
    (fraud_category / category_transactions) * 100
).sort_values(ascending=False)

print(fraud_rate_category)



# ==========================================================
# EDA 12 : Transactions by Year
# ==========================================================

transactions_by_year = (
    df.groupby("year")
      .size()
      .sort_index()
)

print(transactions_by_year)


# ==========================================================
# EDA 13 : Transactions by Month
# ==========================================================

transactions_by_month = (
    df.groupby(["month", "month_name"])
      .size()
      .reset_index(name="Total_Transactions")
      .sort_values("month")
)

print(transactions_by_month)



# ==========================================================
# EDA 14 : Revenue by Month
# ==========================================================

revenue_by_month = (
    df.groupby(["month", "month_name"])["amt"]
      .sum()
      .reset_index(name="Total_Revenue")
      .sort_values("month")
)

print(revenue_by_month)


# ==========================================================
# EDA 15 : Fraud Transactions by Month
# ==========================================================

fraud_by_month = (
    df[df["is_fraud"] == 1]
      .groupby(["month", "month_name"])
      .size()
      .reset_index(name="Fraud_Transactions")
      .sort_values("month")
)

print(fraud_by_month)



# ==========================================================
# EDA 16 : Fraud Rate by Month (%)
# ==========================================================

fraud_rate_by_month = (
    fraud_by_month.copy()
)

fraud_rate_by_month["Fraud_Rate (%)"] = (
    fraud_rate_by_month["Fraud_Transactions"]
    / transactions_by_month["Total_Transactions"]
) * 100

print(fraud_rate_by_month)


# ==========================================================
# EDA 17 : Transactions by Day of Week
# ==========================================================

day_order = [
    "Monday", "Tuesday", "Wednesday",
    "Thursday", "Friday", "Saturday", "Sunday"
]

transactions_by_day = (
    df.groupby("day_name")
      .size()
      .reindex(day_order)
      .reset_index(name="Total_Transactions")
)

print(transactions_by_day)


# ==========================================================
# EDA 18 : Fraud Transactions by Day of Week
# ==========================================================

fraud_by_day = (
    df[df["is_fraud"] == 1]
      .groupby("day_name")
      .size()
      .reindex(day_order)
      .reset_index(name="Fraud_Transactions")
)

print(fraud_by_day)


# ==========================================================
# EDA 19 : Transactions by Hour
# ==========================================================

transactions_by_hour = (
    df.groupby("hour")
      .size()
      .reset_index(name="Total_Transactions")
      .sort_values("hour")
)

print(transactions_by_hour)



# ==========================================================
# EDA 20 : Fraud Transactions by Hour
# ==========================================================

fraud_by_hour = (
    df[df["is_fraud"] == 1]
      .groupby("hour")
      .size()
      .reset_index(name="Fraud_Transactions")
      .sort_values("hour")
)

print(fraud_by_hour)