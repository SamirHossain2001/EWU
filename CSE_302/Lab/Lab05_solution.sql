@ D:\banking.sql
drop table depositor cascade constraints;
drop table borrower cascade constraints;
drop table account cascade constraints;
drop table loan cascade constraints;
drop table customer cascade constraints;
drop table branch cascade constraints;

SELECT * FROM depositor;
SELECT * FROM borrower;
SELECT * FROM account;
SELECT * FROM loan;
SELECT * FROM customer;
SELECT * FROM branch;

-- 1
SELECT customer_name, customer_street, customer_city
FROM customer
NATURAL JOIN depositor NATURAL JOIN account NATURAL JOIN branch
Where customer_city = branch_city;

SELECT c.customer_name, c.customer_street, c.customer_city
FROM customer c, (SELECT *
                FROM depositor NATURAL JOIN account NATURAL JOIN branch) b
WHERE c.customer_name = b.customer_name
    AND c.customer_city = b.branch_city;

--2
SELECT customer_name, customer_street, customer_city
FROM customer
NATURAL JOIN borrower NATURAL JOIN loan NATURAL JOIN branch
Where customer_city = branch_city;

SELECT c.customer_name, c.customer_street, c.customer_city
FROM customer c, (SELECT *
                FROM borrower NATURAL JOIN loan NATURAL JOIN branch) l
WHERE c.customer_name = l.customer_name
    AND c.customer_city = l.branch_city;

-- 3
SELECT branch_city, avg(balance)
FROM branch NATURAL JOIN account
GROUP BY branch_city
HAVING SUM(balance) >= 1000;

SELECT branch_city, AVG(balance)
FROM branch NATURAL JOIN account NATURAL JOIN 
(SELECT branch_city, SUM(balance) AS total
FROM branch NATURAL JOIN account
GROUP BY branch_city) B
WHERE B.total >= 1000
GROUP BY branch_city;

-- 4
SELECT branch_city, avg(amount)
FROM branch NATURAL JOIN loan
GROUP BY branch_city
HAVING avg(amount) >= 1500;

SELECT branch_city, AVG(amount)
FROM branch NATURAL JOIN loan NATURAL JOIN 
(SELECT branch_city, AVG(amount) AS average
FROM branch NATURAL JOIN loan
GROUP BY branch_city) L
WHERE L.average >= 1500
GROUP BY branch_city;

-- 5 
SELECT customer_name, customer_street, customer_city
from customer NATURAL JOIN depositor NATURAL JOIN account
WHERE balance >= ALL(SELECT balance FROM account);

SELECT customer_name, customer_street, customer_city
from customer NATURAL JOIN depositor NATURAL JOIN account
WHERE balance = (SELECT MAX(balance) FROM account);

-- 6
SELECT customer_name, customer_street, customer_city
from customer NATURAL JOIN borrower NATURAL JOIN loan
WHERE amount <= ALL(SELECT amount FROM loan);

SELECT customer_name, customer_street, customer_city
from customer NATURAL JOIN borrower NATURAL JOIN loan
WHERE amount = (SELECT MIN(amount) FROM loan);

-- 7 
SELECT DISTINCT b.branch_name, b.branch_city
FROM branch b
WHERE b.branch_name in (SELECT branch_name FROM account
                      INTERSECT
                      SELECT branch_name FROM loan);
                      
SELECT DISTINCT b.branch_name, b.branch_city
FROM branch b
WHERE EXISTS(SELECT 1 FROM account a
             WHERE a.branch_name = b.branch_name)
      AND EXISTS(SELECT 1 FROM loan l
             WHERE l.branch_name = b.branch_name);
        
-- 8
SELECT DISTINCT c.customer_name, c.customer_city
FROM customer C
WHERE c.customer_name IN (SELECT customer_name
                        FROM depositor
                        WHERE customer_name NOT IN(SELECT customer_name
                                                  FROM borrower));

SELECT DISTINCT c.customer_name, c.customer_city
FROM customer C
WHERE EXISTS (SELECT customer_name
              FROM depositor d
              WHERE d.customer_name = c.customer_name)
      AND NOT EXISTS (SELECT customer_name
                      FROM borrower b
                      WHERE b.customer_name = c.customer_name);
                
-- 9
WITH Total_Balance AS
(SELECT branch_name, SUM(balance) AS total
FROM account
GROUP BY branch_name),
Avg_balance AS
(SELECT AVG(total) AS val
FROM Total_Balance)
SELECT branch_name
FROM Total_balance, Avg_balance
WHERE total > val;

SELECT branch_name
FROM (SELECT branch_name, SUM(balance) AS total
      FROM account
      GROUP BY branch_name)
WHERE total > (SELECT AVG(total)
               FROM (SELECT branch_name, SUM(balance) AS total
                     FROM account
                     GROUP BY branch_name));

-- 10
WITH Total_amount AS
(SELECT branch_name, SUM(amount) AS total
FROM loan
GROUP BY branch_name),
Avg_loan AS
(SELECT AVG(total) AS val
FROM Total_amount)
SELECT branch_name
FROM Total_amount, Avg_loan
WHERE total < val;

SELECT branch_name
FROM (SELECT branch_name, SUM(amount) AS total
      FROM loan
      GROUP BY branch_name)
WHERE total < (SELECT AVG(total)
               FROM (SELECT branch_name, SUM(amount) AS total
                     FROM loan
                     GROUP BY branch_name));

