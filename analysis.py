import pandas as pd

# Load banking dataset
df = pd.read_csv("data/Churn_Modelling.csv")

# Show first 5 rows
print(df.head())
print("\nDataset Shape:")
print(df.shape)

print("\nColumn Names:")
print(df.columns.tolist())

print("\nDataset Information:")
print(df.info())

print("\nMissing Values:")
print(df.isnull().sum())
# Remove unnecessary columns
df = df.drop(columns=["RowNumber", "CustomerId", "Surname"])

print("\nColumns after cleaning:")
print(df.columns.tolist())

print("\nDataset Shape after cleaning:")
print(df.shape)
# Check customer churn

print("\nChurn Count:")
print(df["Exited"].value_counts())

print("\nChurn Percentage:")
print(df["Exited"].value_counts(normalize=True) * 100)
# Churn by Geography

print("\nChurn by Geography:")
print(
    df.groupby("Geography")["Exited"]
      .mean()
      .mul(100)
      .sort_values(ascending=False)
)
# Churn by Active Member Status

print("\nChurn by Active Member Status:")
print(
    df.groupby("IsActiveMember")["Exited"]
      .mean()
      .mul(100)
)
# Churn by Number of Products

print("\nChurn by Number of Products:")
print(
    df.groupby("NumOfProducts")["Exited"]
      .mean()
      .mul(100)
      .sort_values(ascending=False)
)
# Churn by Age

print("\nAverage Age by Churn Status:")
print(
    df.groupby("Exited")["Age"]
      .mean()
)
# Average Credit Score by Churn Status

print("\nAverage Credit Score by Churn Status:")
print(
    df.groupby("Exited")["CreditScore"]
      .mean()
)
# Average Balance by Churn Status

print("\nAverage Balance by Churn Status:")
print(
    df.groupby("Exited")["Balance"]
      .mean()
)
# Churn by Gender

print("\nChurn by Gender:")
print(
    df.groupby("Gender")["Exited"]
      .mean()
      .mul(100)
)
# Create customer risk level

def risk_level(row):
    risk_score = 0

    if row["Geography"] == "Germany":
        risk_score += 2

    if row["IsActiveMember"] == 0:
        risk_score += 2

    if row["NumOfProducts"] >= 3:
        risk_score += 3

    if row["Age"] >= 45:
        risk_score += 1

    if row["Balance"] >= 90000:
        risk_score += 1

    if risk_score >= 5:
        return "High Risk"
    elif risk_score >= 3:
        return "Medium Risk"
    else:
        return "Low Risk"


df["RiskLevel"] = df.apply(risk_level, axis=1)

print("\nRisk Level Distribution:")
print(df["RiskLevel"].value_counts())
# Check actual churn rate for each risk level

print("\nActual Churn Rate by Risk Level:")
print(
    df.groupby("RiskLevel")["Exited"]
      .mean()
      .mul(100)
      .sort_values(ascending=False)
)
# Create final customer risk report

df.to_csv("customer_risk_report.csv", index=False)

print("\nCustomer risk report created successfully!")
print("File: customer_risk_report.csv")
# Calculate risk score for each customer

def calculate_risk_score(row):
    score = 0

    if row["Geography"] == "Germany":
        score += 2

    if row["IsActiveMember"] == 0:
        score += 2

    if row["NumOfProducts"] >= 3:
        score += 3

    if row["Age"] >= 45:
        score += 1

    if row["Balance"] >= 90000:
        score += 1

    return score


df["RiskScore"] = df.apply(calculate_risk_score, axis=1)

# Save updated report
df.to_csv("customer_risk_report.csv", index=False)

print("\nRisk score added successfully!")
print(df[["RiskScore", "RiskLevel"]].head())
# Create automated action based on risk level

def customer_action(risk):
    if risk == "High Risk":
        return "Immediate Follow-up"
    elif risk == "Medium Risk":
        return "Contact Customer"
    else:
        return "Normal Monitoring"


df["Action"] = df["RiskLevel"].apply(customer_action)

# Save final automation report
df.to_csv("customer_risk_report.csv", index=False)

print("\nAutomation action added successfully!")
print(df[["RiskScore", "RiskLevel", "Action"]].head())
# Automation action summary

print("\nAutomation Action Summary:")
print(df["Action"].value_counts())

print("\nRisk Level Summary:")
print(df["RiskLevel"].value_counts())
# Create clean automation report

final_report = df[
    [
        "Geography",
        "Gender",
        "Age",
        "CreditScore",
        "Balance",
        "NumOfProducts",
        "IsActiveMember",
        "RiskScore",
        "RiskLevel",
        "Action"
    ]
]

final_report.to_csv("final_customer_risk_report.csv", index=False)

print("\nFinal customer risk report created successfully!")
print(final_report.head())
# Add actual churn status to final report

final_report["Exited"] = df["Exited"]

# Save updated final report
final_report.to_csv("final_customer_risk_report.csv", index=False)

print("\nExited column added successfully!")
print(final_report[["RiskLevel", "RiskScore", "Action", "Exited"]].head())