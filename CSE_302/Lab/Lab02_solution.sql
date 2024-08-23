
-- Lab Task #01
DROP TABLE ACCOUNT CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE DEPOSITOR CASCADE CONSTRAINTS;

CREATE TABLE ACCOUNT(
    account_no CHAR(5),
    balance NUMBER NOT NULL,
    CONSTRAINT PK_ACCOUNT PRIMARY KEY(account_no),
    CONSTRAINT CHECK_BALANCE CHECK(balance >= 0)
);

CREATE TABLE CUSTOMER(
    customer_no CHAR(5),
    customer_name VARCHAR(20) NOT NULL,
    customer_city VARCHAR(10),
    CONSTRAINT PK_CUSTOMER PRIMARY KEY(customer_no)
);

CREATE TABLE  DEPOSITOR(
    account_no CHAR(5),
    customer_no CHAR(5),
    CONSTRAINT PK_DEPOSITOR PRIMARY KEY(account_no, customer_no)
);

DESC ACCOUNT;
DESC CUSTOMER;
DESC DEPOSITOR;

-- Lab Task #02
ALTER TABLE CUSTOMER ADD date_of_birth DATE;
ALTER TABLE CUSTOMER DROP COLUMN date_of_birth;
ALTER TABLE DEPOSITOR RENAME COLUMN account_no to a_no;
ALTER TABLE DEPOSITOR RENAME COLUMN customer_no to c_no;

ALTER TABLE DEPOSITOR
ADD CONSTRAINT depositor_fk1
   FOREIGN KEY (a_no)
   REFERENCES ACCOUNT (account_no) ON DELETE CASCADE;

ALTER TABLE DEPOSITOR
ADD CONSTRAINT depositor_fk2
   FOREIGN KEY (c_no)
   REFERENCES CUSTOMER (customer_no) ON DELETE CASCADE;
   
-- Lab Task #03
INSERT INTO ACCOUNT COLUMNS(account_no, balance) VALUES('A-101', 12000);
INSERT INTO ACCOUNT COLUMNS(account_no, balance) VALUES('A-102', 6000);
INSERT INTO ACCOUNT COLUMNS(account_no, balance) VALUES('A-103', 2500);

INSERT INTO CUSTOMER COLUMNS(customer_no, customer_name, customer_city) VALUES('C-101', 'Alice', 'Dhaka');
INSERT INTO CUSTOMER COLUMNS(customer_no, customer_name, customer_city) VALUES('C-102', 'Annie', 'Dhaka');
INSERT INTO CUSTOMER COLUMNS(customer_no, customer_name, customer_city) VALUES('C-103', 'Bob', 'Chittagong');
INSERT INTO CUSTOMER COLUMNS(customer_no, customer_name, customer_city) VALUES('C-104', 'Charlie', 'Khulna');

INSERT INTO DEPOSITOR COLUMNS(a_no, c_no) VALUES('A-101', 'C-101');
INSERT INTO DEPOSITOR COLUMNS(a_no, c_no) VALUES('A-103', 'C-102');
INSERT INTO DEPOSITOR COLUMNS(a_no, c_no) VALUES('A-103', 'C-104');
INSERT INTO DEPOSITOR COLUMNS(a_no, c_no) VALUES('A-102', 'C-103');

SELECT * FROM ACCOUNT;
SELECT * FROM CUSTOMER;
SELECT * FROM DEPOSITOR;


-- Lab Task #04
-- 1
SELECT customer_name, customer_city FROM CUSTOMER;

-- 2
SELECT DISTINCT customer_city FROM CUSTOMER;

-- 3
SELECT account_no FROM ACCOUNT WHERE balance > 7000;

-- 4
SELECT customer_no, customer_name FROM CUSTOMER WHERE customer_city = 'Khulna';

-- 5
SELECT customer_no, customer_name FROM CUSTOMER WHERE customer_city != 'Dhaka';

-- 6
Select customer_name, customer_city
from CUSTOMER
JOIN DEPOSITOR
    ON customer_no = c_no
JOIN ACCOUNT
    ON account_no = a_no
WHERE balance > 7000;

-- 7
Select customer_name, customer_city
from CUSTOMER
JOIN DEPOSITOR
    ON customer_no = c_no
JOIN ACCOUNT
    ON account_no = a_no
WHERE balance > 7000 and customer_city != 'Khulna';

-- 8
SELECT account_no, balance
FROM ACCOUNT
JOIN DEPOSITOR
    ON account_no = a_no
WHERE c_no = 'C-102';

-- 9
SELECT account_no, balance
FROM ACCOUNT 
JOIN DEPOSITOR
    ON account_no = a_no
JOIN CUSTOMER
    ON customer_no = c_no
WHERE customer_city IN ('Dhaka', 'Khulna');

-- 10
SELECT customer_name
FROM CUSTOMER
LEFT JOIN DEPOSITOR
    ON customer_no = c_no
WHERE a_no IS NULL;

