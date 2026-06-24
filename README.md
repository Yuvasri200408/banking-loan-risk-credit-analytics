# Banking Loan Risk & Credit Analytics

## Project Overview

This project analyzes borrower demographics, financial characteristics, credit history, and loan behavior to identify key drivers of loan default risk and support data-driven lending decisions.

Using SQL, Python, and Power BI, the project follows a complete analytics workflow including data validation, exploratory data analysis (EDA), feature engineering, risk segmentation, and interactive dashboard development.

The objective is to help financial institutions better understand borrower risk, improve loan approval decisions, reduce default exposure, and strengthen portfolio quality through analytical insights.

---

## Business Problem

Loan defaults create significant financial risk for lending institutions. Identifying high-risk borrowers before loan approval is essential for minimizing losses and improving credit portfolio performance.

This project addresses the following business questions:

* Which borrower segments exhibit the highest default risk?
* How does income level influence loan repayment behavior?
* What impact does credit score have on default probability?
* How does debt burden affect loan performance?
* Which customer profiles should be approved, reviewed, or rejected?
* How can lenders improve decision-making using risk-based segmentation?

---

## Dataset Overview

**Source:** Consumer Loan Risk Dataset

| Metric       |                           Value |
| ------------ | ------------------------------: |
| Rows         |                          44,993 |
| Columns      |                              14 |
| Dataset Type |          Loan Applicant Records |
| Domain       | Banking & Credit Risk Analytics |

### Original Dataset Fields

* person_age
* person_gender
* person_education
* person_income
* person_emp_exp
* person_home_ownership
* loan_amnt
* loan_intent
* loan_int_rate
* loan_percent_income
* cb_person_cred_hist_length
* credit_score
* previous_loan_defaults_on_file
* loan_status

### Target Variable

**loan_status**

* 0 = No Default
* 1 = Default

---

## Tools & Technologies

* Python (Pandas, NumPy, Matplotlib, Seaborn)
* SQL (MySQL)
* Power BI
* GitHub

---

## Key Skills Demonstrated

* Data Cleaning & Validation
* Exploratory Data Analysis (EDA)
* Feature Engineering
* Credit Risk Analytics
* Risk Segmentation
* SQL Querying
* KPI Development
* Dashboard Design
* Financial Risk Assessment
* Business Intelligence Reporting
* Data Storytelling

---

## Data Preparation & Validation

The analysis began with a comprehensive data quality assessment to ensure the dataset was suitable for analytical reporting.

### Data Validation

* Verified dataset structure and column data types
* Checked all fields for missing values
* Conducted duplicate record validation
* Validated age, income, credit score, and loan-related attributes
* Identified and removed invalid applicant records
* Verified consistency of categorical variables
* Created a clean analytical layer using SQL views

### Data Quality Results

* No missing values identified across analytical variables
* No duplicate records detected
* Invalid age records were removed
* Credit score and financial attributes passed validation checks
* Final dataset prepared for downstream analysis and reporting

---

## Exploratory Data Analysis (EDA)

EDA was performed to understand borrower characteristics, financial profiles, and default behavior.

The analysis included:

* Applicant age distribution
* Income distribution analysis
* Loan amount distribution
* Credit score distribution
* Loan default rate analysis
* Income-based risk assessment
* Credit quality analysis
* Debt-to-Income (DTI) evaluation
* Home ownership analysis
* Correlation analysis among financial variables

The analysis revealed strong relationships between income level, credit quality, debt burden, and loan repayment performance.

---

## Feature Engineering

To improve risk assessment and borrower segmentation, several analytical features were created:

* Income Band (Low, Middle, High Income)
* Age Group Segmentation
* Credit Quality Segment
* Employment Stability Group
* High Risk Flag
* Custom Risk Score
* Loan Approval Decision Engine

These engineered features enabled more effective risk classification and business-focused analysis.

---

## SQL Analysis

SQL was used to validate business metrics and evaluate borrower risk patterns.

### Overall Default Rate

```sql
SELECT
    CASE
        WHEN credit_score < 580 THEN 'Poor'
        WHEN credit_score BETWEEN 580 AND 669 THEN 'Fair'
        WHEN credit_score BETWEEN 670 AND 739 THEN 'Good'
        ELSE 'Excellent'
    END AS credit_band,

    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,

    ROUND(
        SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS default_rate

FROM loan_cleaned
GROUP BY credit_band
ORDER BY default_rate DESC;

```

 SQL analysis included:

* Income Risk Analysis
* Credit Score Segmentation
* Debt-to-Income Analysis
* Risk Score Calculation
* Approval Decision Framework
* Portfolio Risk Assessment

---

## Dashboard Preview

### Executive Risk Overview

This dashboard provides an executive-level view of loan portfolio quality, borrower characteristics, default performance, and risk distribution.

![Executive Dashboard](executive_risk_overview.png)

### Risk Segmentation & Credit Insights

This dashboard focuses on borrower segmentation, credit quality analysis, income risk patterns, debt burden evaluation, and approval decision support.

![Risk Dashboard](cutomer_credit_insight.png)

---

## Key Business Insights

* Approximately 22% of applicants defaulted on their loans while 78% successfully repaid.
* Low-income borrowers represented the highest-risk lending segment and demonstrated substantially higher default rates.
* Borrowers with poor credit scores consistently underperformed compared to applicants with stronger credit profiles.
* High debt-to-income ratios emerged as a critical indicator of repayment risk.
* Risk segmentation successfully isolated borrower groups with significantly different default behaviors.
* The custom risk score framework provides a practical foundation for data-driven lending decisions.
* Income level, credit score, and debt burden emerged as the strongest predictors of loan risk.
* Risk-based lending strategies can help reduce portfolio exposure and improve approval quality.

---

## Business Recommendations

* Strengthen approval criteria for high-risk applicants.
* Incorporate credit score thresholds into underwriting policies.
* Monitor debt-to-income ratios during loan evaluation.
* Implement enhanced review processes for medium-risk borrowers.
* Use risk segmentation to prioritize portfolio monitoring.
* Leverage risk-scoring models to improve approval consistency and reduce future defaults.

---

## Project Files

- [README.md](README.md) — Project documentation and business findings.
- [banking_loan_data_quality_pipeline.sql](banking_loan_data_quality_pipeline.sql) — Data validation, quality checks, cleaning rules, and analytical view creation.
- [banking_loan_eda_feature_engineering.ipynb](banking_loan_eda_feature_engineering.ipynb) — Exploratory Data Analysis (EDA), feature engineering, risk segmentation, and visualization.
- [banking_loan_risk_analysis.sql](banking_loan_risk_analysis.sql) — Business-focused SQL analysis covering default risk, credit quality, affordability, and approval decision logic.
- [banking_loan_risk_dashboard.pbix](banking_loan_risk_dashboard.pbix) — Interactive Power BI dashboard for risk monitoring and portfolio analysis.
- [banking_loan_risk_engineered.csv](banking_loan_risk_engineered.csv) — Final analytical dataset containing engineered risk features and customer segments.
- [customer_credit_insights.png](customer_credit_insights.png) — Dashboard page focused on borrower characteristics, credit quality, and default behavior.
- [executive_risk_overview.png](executive_risk_overview.png) — Executive-level dashboard summarizing portfolio risk, default performance, and lending insights.

---

## Repository Structure

```text
Banking-Loan-Risk-Credit-Analytics

├── README.md
├── banking_loan_risk_analysis.ipynb
├── banking_loan_risk_queries.sql
├── banking_loan_risk_engineered.csv
├── banking_loan_risk_dashboard.pbix
├── banking_loan_risk_dashboard_1.png
└── banking_loan_risk_dashboard_2.png
```

---

## Project Link

GitHub Repository:

https://github.com/Yuvasri200408/banking-loan-risk-credit-analytics/tree/main

---

## Conclusion

This project demonstrates an end-to-end credit risk analytics workflow using SQL, Python, and Power BI. Through data validation, exploratory analysis, feature engineering, risk segmentation, and dashboard reporting, the project converts raw borrower data into actionable lending insights that support better risk management and loan approval decisions.

