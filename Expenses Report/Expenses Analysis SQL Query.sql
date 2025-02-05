--- OVER-VIEWING THE DATA
SELECT * FROM [Expenses 2022]

--- TOTAL EXPENSES
SELECT FORMAT(SUM(PAID),'C','EN-IN') AS TOTAL_EXPENSES FROM [Expenses 2022]

--- MONTHLY EXPENSES
SELECT DATENAME(MONTH,DATE) AS MONTH,
FORMAT(SUM(PAID),'C','EN-IN') AS EXPENSES_AMOUNT
FROM [Expenses 2022] GROUP BY DATEPART(MONTH,DATE),DATENAME(MONTH,DATE)
ORDER BY DATEPART(MONTH,DATE)

--- CATEGORICAL EXPENSES
SELECT EXPENSES AS CATEGORY, FORMAT(SUM(FINAL_AMOUNT),'C','EN-IN') AS AMOUNT
FROM [Expenses 2022] WHERE FINAL_AMOUNT <> 0
GROUP BY EXPENSES ORDER BY SUM(FINAL_AMOUNT) DESC

--- TOTAL CREDIT AMOUNT & PERCENTAGE OF CREDIT PURCHASE 
SELECT FORMAT(SUM(CARRY_FORWARD), 'C', 'EN-IN') AS TOTAL_CREDIT_AMOUNT,
FORMAT(ROUND(SUM(CARRY_FORWARD) * 100 / (SELECT SUM(FINAL_AMOUNT) FROM [Expenses 2022]), 2), 'N2')
+ '%' AS PERCENTAGE_OF_CREDIT_PURCHASE
FROM [Expenses 2022]

--- CREDIT AMOUNT & PERCENTAGE BY CATEGORY
SELECT EXPENSES, FORMAT(SUM(CARRY_FORWARD), 'C', 'EN-IN') AS CREDIT_AMOUNT,
FORMAT(ROUND(SUM(CARRY_FORWARD) * 100 / (SELECT SUM(FINAL_AMOUNT) FROM [Expenses 2022]), 2), 'N2')
+ '%' AS PERCENTAGE_OF_CREDIT_PURCHASE FROM [Expenses 2022] WHERE CARRY_FORWARD <> 0
GROUP BY EXPENSES 
ORDER BY PERCENTAGE_OF_CREDIT_PURCHASE DESC

--- MONTHLY CREDIT AMOUNT & PERCENTAGE OF CREDIT PURCHASE
SELECT DATENAME(MONTH,DATE) AS MONTH,
FORMAT(SUM(CARRY_FORWARD), 'C', 'EN-IN') AS CREDIT_AMOUNT,
FORMAT(ROUND(SUM(CARRY_FORWARD) * 100 / (SELECT SUM(FINAL_AMOUNT) FROM [Expenses 2022]), 2), 'N2')
+ '%' AS PERCENTAGE_OF_CREDIT_PURCHASE FROM [Expenses 2022]
GROUP BY DATEPART(MONTH,DATE),DATENAME(MONTH,DATE)
ORDER BY DATEPART(MONTH,DATE)

--- YEARLY EXPENSES FOR SALARY, RENT & EB AND PERCENTAGE OF SELECTED EXPENSES
SELECT EXPENSES AS CATEGORY, FORMAT(SUM(FINAL_AMOUNT), 'C', 'EN-IN') AS AMOUNT,
FORMAT(SUM(FINAL_AMOUNT) * 100.0 / (SELECT SUM(FINAL_AMOUNT) FROM [Expenses 2022]), 'N2')
+ '%' AS PERCENTAGE_OF_EXPENSES FROM [Expenses 2022] 
WHERE EXPENSES IN ('SALARY', 'RENT', 'EB')
GROUP BY EXPENSES ORDER BY EXPENSES DESC;

--- MONTHLY EXPENSES FOR SALARY, RENT & EB AND PERCENTAGE OF SELECTED EXPENSES
SELECT DATENAME(MONTH,DATE) AS MONTH, FORMAT(SUM(FINAL_AMOUNT), 'C', 'EN-IN') AS AMOUNT,
FORMAT(SUM(FINAL_AMOUNT) * 100.0 / (SELECT SUM(FINAL_AMOUNT) FROM [Expenses 2022]), 'N2')
+ '%' AS PERCENTAGE_OF_EXPENSES FROM [Expenses 2022] 
WHERE EXPENSES IN ('SALARY', 'RENT', 'EB')
GROUP BY DATEPART(MONTH,DATE),DATENAME(MONTH,DATE)
ORDER BY DATEPART(MONTH,DATE)

--- TOTAL DISCOUNT AMOUNT BY CATEGORY
SELECT EXPENSES AS CATEGORY, FORMAT(SUM(DISCOUNT),'C','EN-IN') AS DISCOUNT_AMOUNT
FROM [Expenses 2022] WHERE DISCOUNT <> 0 GROUP BY EXPENSES 
ORDER BY SUM(DISCOUNT) DESC

--- PERCENTAGE OF DISCOUNT BY CATEGORY
SELECT EXPENSES AS CATEGORY,
FORMAT(SUM(DISCOUNT) * 100 / (SELECT SUM(FINAL_AMOUNT) FROM [Expenses 2022]),'N2') 
+ '%' AS PERCENTAGE_OF_DISCOUNT
FROM [Expenses 2022] WHERE DISCOUNT <> 0
GROUP BY EXPENSES ORDER BY PERCENTAGE_OF_DISCOUNT DESC



