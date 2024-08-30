@ D:\Lab03_banking.sql

DROP TABLE depositor CASCADE CONSTRAINTS;
DROP TABLE borrower CASCADE CONSTRAINTS;
DROP TABLE account CASCADE CONSTRAINTS;
DROP TABLE loan CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE branch CASCADE CONSTRAINTS;

SELECT * FROM depositor;
SELECT * FROM borrower;
SELECT * FROM account;
SELECT * FROM loan;
SELECT * FROM customer;
SELECT * FROM branch;

-- 1
SELECT branch_name, branch_city
FROM branch
WHERE assets > 1000000;

-- 2
SELECT account_number, balance
FROM account
WHERE branch_name = 'Downtown' OR balance BETWEEN 600 AND 750;

-- 3
SELECT account_number
FROM account
NATURAL JOIN BRANCH
WHERE branch_city = 'Rye';

-- 4
SELECT loan_number
FROM loan
NATURAL JOIN borrower
NATURAL JOIN customer
WHERE amount >= 1000 AND customer_city = 'Harrison';

-- 5
SELECT *
FROM account
ORDER BY balance DESC;

-- 6
SELECT * 
FROM customer
ORDER BY customer_city;

-- 7
SELECT customer_name
FROM customer
NATURAL JOIN depositor
INTERSECT
SELECT customer_name
FROM customer
NATURAL JOIN borrower;

-- 8
SELECT customer_name, customer_street, customer_city
FROM customer
NATURAL JOIN depositor
UNION
SELECT customer_name, customer_street, customer_city
FROM customer
NATURAL JOIN borrower;

-- 9
SELECT customer_name, customer_city
FROM customer
NATURAL JOIN borrower
MINUS
SELECT customer_name, customer_city
FROM customer
NATURAL JOIN depositor;

-- 10
SELECT SUM(assets) as Total_assets
FROM branch;

-- 11
SELECT branch_name, AVG(balance)
FROM ACCOUNT
GROUP BY branch_name;

-- 12
SELECT branch_city, AVG(balance)
FROM ACCOUNT
NATURAL JOIN BRANCH
GROUP BY branch_city;

-- 13
SELECT branch_name, MIN(amount)
FROM loan
GROUP BY branch_name;

-- 14
SELECT branch_name, COUNT(amount)
FROM loan
GROUP BY branch_name;

-- 15
SELECT account_number, customer_name
FROM account
NATURAL JOIN depositor
WHERE balance = (SELECT MAX(balance)
                 FROM account);












