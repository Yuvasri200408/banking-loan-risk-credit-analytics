USE banking_loan_risk;
-- OVERALL DEFAULT RATE

SELECT 
    loan_status,
    COUNT(*) AS total,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM loan_cleaned), 2) AS percentage
FROM loan_cleaned
GROUP BY loan_status;



-- INCOME RISK ANALYSIS
SELECT 
    CASE 
        WHEN person_income < 30000 THEN 'Low Income'
        WHEN person_income BETWEEN 30000 AND 70000 THEN 'Mid Income'
        ELSE 'High Income'
    END AS income_band,

    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS default_rate
FROM loan_cleaned
GROUP BY income_band
ORDER BY default_rate DESC;

-- CREDIT SCORE ANALYSIS

SELECT 
    CASE 
        WHEN credit_score < 580 THEN 'Poor'
        WHEN credit_score BETWEEN 580 AND 669 THEN 'Fair'
        WHEN credit_score BETWEEN 670 AND 739 THEN 'Good'
        WHEN credit_score BETWEEN 740 AND 799 THEN 'Very Good'
        ELSE 'Excellent'
    END AS credit_band,

    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS default_rate
FROM loan_cleaned
GROUP BY credit_band
ORDER BY default_rate DESC;

-- DTI (DEBT-TO-INCOME) ANALYSIS

SELECT 
    CASE 
        WHEN loan_percent_income < 0.1 THEN 'Low DTI'
        WHEN loan_percent_income BETWEEN 0.1 AND 0.3 THEN 'Medium DTI'
        ELSE 'High DTI'
    END AS dti_band,

    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS default_rate
FROM loan_cleaned
GROUP BY dti_band
ORDER BY default_rate DESC;

-- RISK SCORE- FEATURE ENGINEERING
SELECT 
    *,

    (
        CASE 
            WHEN person_income < 30000 THEN 30
            WHEN person_income BETWEEN 30000 AND 70000 THEN 15
            ELSE 5
        END +

        CASE 
            WHEN loan_percent_income > 0.3 THEN 40
            WHEN loan_percent_income BETWEEN 0.1 AND 0.3 THEN 20
            ELSE 5
        END +

        CASE 
            WHEN credit_score < 580 THEN 30
            WHEN credit_score BETWEEN 580 AND 669 THEN 15
            ELSE 5
        END
    ) AS risk_score

FROM loan_cleaned;

--  APPROVAL DECISION ENGINE
SELECT 
    *,

    CASE 
        WHEN (
            CASE 
                WHEN person_income < 30000 THEN 30
                WHEN person_income BETWEEN 30000 AND 70000 THEN 15
                ELSE 5
            END +

            CASE 
                WHEN loan_percent_income > 0.3 THEN 40
                WHEN loan_percent_income BETWEEN 0.1 AND 0.3 THEN 20
                ELSE 5
            END +

            CASE 
                WHEN credit_score < 580 THEN 30
                WHEN credit_score BETWEEN 580 AND 669 THEN 15
                ELSE 5
            END
        ) >= 70 THEN 'REJECT'

        WHEN (
            CASE 
                WHEN person_income < 30000 THEN 30
                WHEN person_income BETWEEN 30000 AND 70000 THEN 15
                ELSE 5
            END +

            CASE 
                WHEN loan_percent_income > 0.3 THEN 40
                WHEN loan_percent_income BETWEEN 0.1 AND 0.3 THEN 20
                ELSE 5
            END +

            CASE 
                WHEN credit_score < 580 THEN 30
                WHEN credit_score BETWEEN 580 AND 669 THEN 15
                ELSE 5
            END
        ) BETWEEN 40 AND 69 THEN 'REVIEW'

        ELSE 'APPROVE'
    END AS approval_decision

FROM loan_cleaned;
