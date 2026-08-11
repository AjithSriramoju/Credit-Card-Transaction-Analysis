# ======================================================
# CREDIT CARD TRANSACTION ANALYSIS
# ======================================================

# ------------------------------------------------------
# 1. Import Libraries
# ------------------------------------------------------

import pandas as pd


# ------------------------------------------------------
# 2. Load Dataset
# ------------------------------------------------------

df = pd.read_csv("Credit Card Transactions Dataset/credit_card_transactions.csv")


# ------------------------------------------------------
# 3. Dataset Overview
# ------------------------------------------------------

print("Shape:", df.shape)


# ------------------------------------------------------
# 4. Data Quality Assessment
# ------------------------------------------------------

print(df.isnull().sum())

print(df.duplicated().sum())


# ------------------------------------------------------
# 5. Data Cleaning
# ------------------------------------------------------

df = df.drop(columns=["Unnamed: 0"])

df["trans_date_trans_time"] = pd.to_datetime(df["trans_date_trans_time"])

df["dob"] = pd.to_datetime(df["dob"])


# ------------------------------------------------------
# 6. Verification
# ------------------------------------------------------

print(df.info())

# ------------------------------------------------------
# 6. Feature Engineering
# ------------------------------------------------------

# Extract Year
df["year"] = df["trans_date_trans_time"].dt.year

# Extract Month
df["month"] = df["trans_date_trans_time"].dt.month

# Extract Month Name
df["month_name"] = df["trans_date_trans_time"].dt.month_name()

# Extract Day
df["day"] = df["trans_date_trans_time"].dt.day

# Extract Day Name
df["day_name"] = df["trans_date_trans_time"].dt.day_name()

# Extract Hour
df["hour"] = df["trans_date_trans_time"].dt.hour

print(df.head())
print(df.info())
print(df.shape)


df.to_csv(
    "Credit Card Transactions Dataset/credit_card_transactions_cleaned.csv",
    index=False
)