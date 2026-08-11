import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv(
    "Credit Card Transactions Dataset/credit_card_transactions_cleaned.csv"
)

# ==========================================================
# Visualization 1 : Transactions by Category
# ==========================================================

transactions_by_category = (
    df["category"]
      .value_counts()
      .sort_values(ascending=False)
)

plt.figure(figsize=(14,7))

sns.barplot(
    x=transactions_by_category.index,
    y=transactions_by_category.values,
    hue=transactions_by_category.index,
    legend=False
)

plt.title(
    "Total Transactions by Category",
    fontsize=16,
    fontweight="bold"
)

plt.xlabel("Transaction Category", fontsize=12)

plt.ylabel("Number of Transactions", fontsize=12)

plt.xticks(rotation=45, ha="right")

plt.grid(axis="y", linestyle="--", alpha=0.5)

plt.tight_layout()

plt.show()



# ==========================================================
# Visualization 2 : Revenue by Category
# ==========================================================

revenue_by_category = (
    df.groupby("category")["amt"]
      .sum()
      .sort_values(ascending=False)
)

plt.figure(figsize=(14,7))

sns.barplot(
    x=revenue_by_category.index,
    y=revenue_by_category.values,
    hue=revenue_by_category.index,
    legend=False
)

plt.title(
    "Total Revenue by Category",
    fontsize=16,
    fontweight="bold"
)

plt.xlabel(
    "Transaction Category",
    fontsize=12
)

plt.ylabel(
    "Total Revenue ($)",
    fontsize=12
)

plt.xticks(rotation=45, ha="right")

plt.grid(axis="y", linestyle="--", alpha=0.5)

plt.tight_layout()

plt.show()



# ==========================================================
# Visualization 3 : Average Transaction Amount by Category
# ==========================================================

average_transaction = (
    df.groupby("category")["amt"]
      .mean()
      .sort_values(ascending=False)
)

plt.figure(figsize=(14,7))

sns.barplot(
    x=average_transaction.index,
    y=average_transaction.values,
    hue=average_transaction.index,
    legend=False
)

plt.title(
    "Average Transaction Amount by Category",
    fontsize=16,
    fontweight="bold"
)

plt.xlabel(
    "Transaction Category",
    fontsize=12
)

plt.ylabel(
    "Average Transaction Amount ($)",
    fontsize=12
)

plt.xticks(rotation=45, ha="right")

plt.grid(axis="y", linestyle="--", alpha=0.5)

plt.tight_layout()

plt.show()



# ==========================================================
# Visualization 4 : Fraud Transactions by Category
# ==========================================================

fraud_by_category = (
    df[df["is_fraud"] == 1]
      .groupby("category")
      .size()
      .sort_values(ascending=False)
)

plt.figure(figsize=(14,7))

sns.barplot(
    x=fraud_by_category.index,
    y=fraud_by_category.values,
    hue=fraud_by_category.index,
    legend=False
)

plt.title(
    "Fraud Transactions by Category",
    fontsize=16,
    fontweight="bold"
)

plt.xlabel(
    "Transaction Category",
    fontsize=12
)

plt.ylabel(
    "Fraud Transactions",
    fontsize=12
)

plt.xticks(rotation=45, ha="right")

plt.grid(axis="y", linestyle="--", alpha=0.5)

plt.tight_layout()

plt.show()


# ==========================================================
# Visualization 5 : Fraud Rate by Category
# ==========================================================

category_transactions = (
    df.groupby("category")
      .size()
)

fraud_transactions = (
    df[df["is_fraud"] == 1]
      .groupby("category")
      .size()
)

fraud_rate = (
    fraud_transactions / category_transactions * 100
).sort_values(ascending=False)

plt.figure(figsize=(14,7))

sns.barplot(
    x=fraud_rate.index,
    y=fraud_rate.values,
    hue=fraud_rate.index,
    legend=False
)

plt.title(
    "Fraud Rate by Category (%)",
    fontsize=16,
    fontweight="bold"
)

plt.xlabel(
    "Transaction Category",
    fontsize=12
)

plt.ylabel(
    "Fraud Rate (%)",
    fontsize=12
)

plt.xticks(rotation=45, ha="right")

plt.grid(axis="y", linestyle="--", alpha=0.5)

plt.tight_layout()

plt.show()



# ==========================================================
# Visualization 6 : Transactions by Month
# ==========================================================

transactions_by_month = (
    df.groupby(["month", "month_name"])
      .size()
      .reset_index(name="Total_Transactions")
      .sort_values("month")
)

plt.figure(figsize=(14,7))

sns.barplot(
    x=transactions_by_month["month_name"],
    y=transactions_by_month["Total_Transactions"],
    hue=transactions_by_month["month_name"],
    legend=False
)

plt.title("Transactions by Month", fontsize=16, fontweight="bold")
plt.xlabel("Month", fontsize=12)
plt.ylabel("Total Transactions", fontsize=12)
plt.grid(axis="y", linestyle="--", alpha=0.5)
plt.tight_layout()
plt.show()




# ==========================================================
# Visualization 7 : Revenue by Month
# ==========================================================

revenue_by_month = (
    df.groupby(["month", "month_name"])["amt"]
      .sum()
      .reset_index(name="Total_Revenue")
      .sort_values("month")
)

plt.figure(figsize=(14,7))

sns.barplot(
    x=revenue_by_month["month_name"],
    y=revenue_by_month["Total_Revenue"],
    hue=revenue_by_month["month_name"],
    legend=False
)

plt.title("Revenue by Month", fontsize=16, fontweight="bold")
plt.xlabel("Month", fontsize=12)
plt.ylabel("Revenue ($)", fontsize=12)
plt.grid(axis="y", linestyle="--", alpha=0.5)
plt.tight_layout()
plt.show()



# ==========================================================
# Visualization 8 : Fraud Transactions by Month
# ==========================================================

fraud_by_month = (
    df[df["is_fraud"] == 1]
      .groupby(["month", "month_name"])
      .size()
      .reset_index(name="Fraud_Transactions")
      .sort_values("month")
)

plt.figure(figsize=(14,7))

sns.barplot(
    x=fraud_by_month["month_name"],
    y=fraud_by_month["Fraud_Transactions"],
    hue=fraud_by_month["month_name"],
    legend=False
)

plt.title("Fraud Transactions by Month", fontsize=16, fontweight="bold")
plt.xlabel("Month", fontsize=12)
plt.ylabel("Fraud Transactions", fontsize=12)
plt.grid(axis="y", linestyle="--", alpha=0.5)
plt.tight_layout()
plt.show()



# ==========================================================
# Visualization 9 : Fraud Rate by Month
# ==========================================================

transactions = (
    df.groupby(["month", "month_name"])
      .size()
)

frauds = (
    df[df["is_fraud"] == 1]
      .groupby(["month", "month_name"])
      .size()
)

fraud_rate = (
    frauds / transactions * 100
).reset_index(name="Fraud_Rate")

plt.figure(figsize=(14,7))

sns.barplot(
    x=fraud_rate["month_name"],
    y=fraud_rate["Fraud_Rate"],
    hue=fraud_rate["month_name"],
    legend=False
)

plt.title("Fraud Rate by Month (%)", fontsize=16, fontweight="bold")
plt.xlabel("Month", fontsize=12)
plt.ylabel("Fraud Rate (%)", fontsize=12)
plt.grid(axis="y", linestyle="--", alpha=0.5)
plt.tight_layout()
plt.show()



# ==========================================================
# Visualization 10 : Transactions by Day
# ==========================================================

day_order = [
    "Monday","Tuesday","Wednesday",
    "Thursday","Friday","Saturday","Sunday"
]

transactions_by_day = (
    df.groupby("day_name")
      .size()
      .reindex(day_order)
      .reset_index(name="Total_Transactions")
)

plt.figure(figsize=(12,6))

sns.barplot(
    x=transactions_by_day["day_name"],
    y=transactions_by_day["Total_Transactions"],
    hue=transactions_by_day["day_name"],
    legend=False
)

plt.title("Transactions by Day of Week", fontsize=16, fontweight="bold")
plt.xlabel("Day")
plt.ylabel("Transactions")
plt.grid(axis="y", linestyle="--", alpha=0.5)
plt.tight_layout()
plt.show()



# ==========================================================
# Visualization 11 : Fraud by Day
# ==========================================================

fraud_by_day = (
    df[df["is_fraud"] == 1]
      .groupby("day_name")
      .size()
      .reindex(day_order)
      .reset_index(name="Fraud_Transactions")
)

plt.figure(figsize=(12,6))

sns.barplot(
    x=fraud_by_day["day_name"],
    y=fraud_by_day["Fraud_Transactions"],
    hue=fraud_by_day["day_name"],
    legend=False
)

plt.title("Fraud Transactions by Day", fontsize=16, fontweight="bold")
plt.xlabel("Day")
plt.ylabel("Fraud Transactions")
plt.grid(axis="y", linestyle="--", alpha=0.5)
plt.tight_layout()
plt.show()



# ==========================================================
# Visualization 12 : Transactions by Hour
# ==========================================================

transactions_by_hour = (
    df.groupby("hour")
      .size()
      .reset_index(name="Total_Transactions")
)

plt.figure(figsize=(14,6))

sns.barplot(
    x=transactions_by_hour["hour"],
    y=transactions_by_hour["Total_Transactions"]
)

plt.title("Transactions by Hour", fontsize=16, fontweight="bold")
plt.xlabel("Hour")
plt.ylabel("Transactions")
plt.grid(axis="y", linestyle="--", alpha=0.5)
plt.tight_layout()
plt.show()




# ==========================================================
# Visualization 13 : Fraud by Hour
# ==========================================================

fraud_by_hour = (
    df[df["is_fraud"] == 1]
      .groupby("hour")
      .size()
      .reset_index(name="Fraud_Transactions")
)

plt.figure(figsize=(14,6))

sns.barplot(
    x=fraud_by_hour["hour"],
    y=fraud_by_hour["Fraud_Transactions"]
)

plt.title("Fraud Transactions by Hour", fontsize=16, fontweight="bold")
plt.xlabel("Hour")
plt.ylabel("Fraud Transactions")
plt.grid(axis="y", linestyle="--", alpha=0.5)
plt.tight_layout()
plt.show()




