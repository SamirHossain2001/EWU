-- SOLUTION - 5 
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE ORDER_ CASCADE CONSTRAINTS;
DROP TABLE ORDERITEM CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;

CREATE TABLE PRODUCT(
    product_id VARCHAR2(3),
    product_name VARCHAR2(20),
    category VARCHAR2(20),
    price NUMBER
);

CREATE TABLE ORDER_(
    order_id VARCHAR2(3),
    customer_id VARCHAR2(3),
    order_date DATE
);

CREATE TABLE ORDERITEM(
    order_item_id VARCHAR2(4),
    order_id VARCHAR2(3),
    product_id VARCHAR2(3),
    quantity NUMBER
);

CREATE TABLE CUSTOMER(
    customer_id VARCHAR2(3), 
    customer_name VARCHAR2(20),
    contact_number VARCHAR2(11),
    address VARCHAR2(30)
);

INSERT INTO PRODUCT VALUES('P-1', 'p_name-1', 'A', 10);
INSERT INTO PRODUCT VALUES('P-2', 'p_name-2', 'A', 20);
INSERT INTO PRODUCT VALUES('P-3', 'p_name-3', 'A', 30);
INSERT INTO PRODUCT VALUES('P-4', 'p_name-4', 'B', 100);
INSERT INTO PRODUCT VALUES('P-5', 'p_name-5', 'B', 200);
INSERT INTO PRODUCT VALUES('P-6', 'p_name-6', 'C', 300);

INSERT INTO CUSTOMER VALUES('C-1', 'c_name-1', '000', 'Neptune');
INSERT INTO CUSTOMER VALUES('C-2', 'c_name-2', '000', 'Neptune');
INSERT INTO CUSTOMER VALUES('C-3', 'c_name-3', '000', 'Neptune');
INSERT INTO CUSTOMER VALUES('C-4', 'c_name-4', '000', 'Neptune');
INSERT INTO CUSTOMER VALUES('C-5', 'c_name-5', '000', 'Neptune');
INSERT INTO CUSTOMER VALUES('C-6', 'c_name-6', '000', 'Neptune');
INSERT INTO CUSTOMER VALUES('C-7', 'co_name-6', '000', 'Neptune');

INSERT INTO ORDER_ VALUES('O-1', 'C-1', to_date('23-3-11','yy-mm-dd'));
INSERT INTO ORDER_ VALUES('O-1', 'C-2', to_date('23-3-11','yy-mm-dd'));
INSERT INTO ORDER_ VALUES('O-1', 'C-3', to_date('23-3-11','yy-mm-dd'));
INSERT INTO ORDER_ VALUES('O-2', 'C-1', to_date('23-3-11','yy-mm-dd'));
INSERT INTO ORDER_ VALUES('O-3', 'C-1', to_date('23-3-11','yy-mm-dd'));
INSERT INTO ORDER_ VALUES('O-4', 'C-1', to_date('23-3-11','yy-mm-dd'));
INSERT INTO ORDER_ VALUES('O-4', 'C-2', to_date('23-3-11','yy-mm-dd'));
INSERT INTO ORDER_ VALUES('O-4', 'C-2', to_date('23-3-11','yy-mm-dd'));
INSERT INTO ORDER_ VALUES('O-4', 'C-7', to_date('23-3-11','yy-mm-dd'));

INSERT INTO ORDERITEM VALUES('OI-1', 'O-1', 'P-1', 2);
INSERT INTO ORDERITEM VALUES('OI-2', 'O-2', 'P-2', 3);
INSERT INTO ORDERITEM VALUES('OI-3', 'O-3', 'P-3', 4);
INSERT INTO ORDERITEM VALUES('OI-4', 'O-4', 'P-4', 5);
INSERT INTO ORDERITEM VALUES('OI-5', 'O-1', 'P-5', 6);
INSERT INTO ORDERITEM VALUES('OI-1', 'O-1', 'P-1', 7);
INSERT INTO ORDERITEM VALUES('OI-1', 'O-1', 'P-1', 28);
INSERT INTO ORDERITEM VALUES('OI-1', 'O-4', 'P-3', 8);

SELECT * FROM PRODUCT;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDER_;
SELECT * FROM ORDERITEM;

-- A
SELECT DISTINCT c.customer_name
FROM customer c
JOIN Order_ o
    ON c.customer_id = o.customer_id
JOIN ORDERITEM ot
    ON o.order_id = ot.order_id
JOIN PRODUCT p
    ON ot.product_id = p.product_id
WHERE p.product_name = 'p_name-1';
-- p_name-1 = Headphones

-- B
SELECT  c.customer_name, sum(p.price) as To_amount
FROM customer c
JOIN Order_ o
    ON c.customer_id = o.customer_id
JOIN ORDERITEM ot
    ON o.order_id = ot.order_id
JOIN PRODUCT p
    ON ot.product_id = p.product_id
-- ORDER BY c.customer_id
Group by c.customer_name;

-- C
SELECT DISTINCT p.product_name, p.price
FROM customer c
JOIN Order_ o
    ON c.customer_id = o.customer_id
JOIN ORDERITEM ot
    ON o.order_id = ot.order_id
JOIN PRODUCT p
    ON ot.product_id = p.product_id
WHERE p.price < 100
    and c.customer_name like '%o%';
    
-- D
SELECT c.customer_name, c.address
FROM CUSTOMER c
LEFT OUTER JOIN ORDER_ o
    ON C.customer_id = o.customer_id
WHERE o.order_id is NULL;

-- D.2
SELECT customer_name, address
FROM CUSTOMER
WHERE CUSTOMER_ID NOT IN (SELECT DISTINCT CUSTOMER_ID
                          FROM ORDER_)
                            
-- E
SELECT C.CUSTOMER_NAME
FROM CUSTOMER C
WHERE EXISTS(
             SELECT O.CUSTOMER_ID
             FROM product p
             JOIN ORDERITEM OT
                 ON p.product_id = ot.product_id
             JOIN order_ o
                 on ot.order_id = o.order_id
             WHERE p.category = 'A' -- A = Clothing
                AND C.CUSTOMER_ID = O.CUSTOMER_ID 
             GROUP BY O.CUSTOMER_ID
             HAVING COUNT(*) >= 1
             );

-- SOLUTION - 6                          
-- A
ALTER TABLE ORDER_ ADD
order_status VARCHAR2(20);

-- B
ALTER TABLE ORDER_ ADD
CONSTRAINT ORDER_STATUS_CONSTRAINT CHECK(order_status in ('Processing', 'Shipped', 'Done', 'Canceled'));

-- C
UPDATE ORDER_
SET order_status = 'Shipped'
WHERE order_id = 'O-2';

-- D 
DELETE FROM ORDER_
WHERE customer_id = 'C-1';

SELECT * FROM ORDER_;
