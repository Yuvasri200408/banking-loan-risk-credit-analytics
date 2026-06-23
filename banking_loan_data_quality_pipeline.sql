 USE banking_loan_risk;

-- DATA TYPE 
ALTER TABLE bank_loan
MODIFY person_age INT,
MODIFY person_income INT,
MODIFY loan_amnt INT,
MODIFY cb_person_cred_hist_length INT;

-- NULL CHECK 

SELECT
    SUM(person_age IS NULL) AS person_age_nulls,
    SUM(person_gender IS NULL) AS person_gender_nulls,
    SUM(person_education IS NULL) AS person_education_nulls,
    SUM(person_income IS NULL) AS person_income_nulls,
    SUM(person_emp_exp IS NULL) AS person_emp_exp_nulls,
    SUM(person_home_ownership IS NULL) AS person_home_nulls,
    SUM(loan_amnt IS NULL) AS loan_amount_nulls,
    SUM(loan_intent IS NULL) AS loan_intent_nulls,
    SUM(loan_int_rate IS NULL) AS loan_interest_nulls,
    SUM(loan_percent_income IS NULL) AS loan_percent_income_nulls,
    SUM(cb_person_cred_hist_length IS NULL) AS credit_history_nulls,
    SUM(credit_score IS NULL) AS credit_score_nulls,
    SUM(previous_loan_defaults_on_file IS NULL) AS previous_default_nulls,
    SUM(loan_status IS NULL) AS loan_status_nulls
FROM bank_loan;

-- DATA QUALITY CHECK 

SELECT
    SUM(person_age < 18 OR person_age > 100) AS invalid_age,
    SUM(person_income < 0) AS invalid_income,
    SUM(loan_amnt <= 0) AS invalid_loan_amount,
    SUM(credit_score < 300 OR credit_score > 850) AS invalid_credit_score,
    SUM(loan_percent_income < 0) AS invalid_loan_percent_income
FROM bank_loan;

-- REMOVE INVALID AGE RECORDS

SET SQL_SAFE_UPDATES = 0;

DELETE FROM bank_loan
WHERE person_age < 18 OR person_age > 100;

SET SQL_SAFE_UPDATES = 1;

--  VERIFY CLEANING

SELECT COUNT(*) AS remaining_invalid_age
FROM bank_loan
WHERE person_age < 18 OR person_age > 100;

--  CATEGORICAL VALUE CHECK

SELECT DISTINCT person_gender FROM bank_loan;
SELECT DISTINCT person_education FROM bank_loan;
SELECT DISTINCT person_home_ownership FROM bank_loan;
SELECT DISTINCT loan_intent FROM bank_loan;
SELECT DISTINCT previous_loan_defaults_on_file FROM bank_loan;
SELECT DISTINCT loan_status FROM bank_loan;

-- CREATE CLEAN ANALYSIS LAYER

CREATE VIEW loan_cleaned AS
SELECT * FROM bank_loan;

