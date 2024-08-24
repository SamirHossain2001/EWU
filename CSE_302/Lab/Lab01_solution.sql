
-- Lab task #01
DROP TABLE instructor CASCADE CONSTRAINTS;
DROP TABLE course CASCADE CONSTRAINTS;

CREATE TABLE instructor(
    id CHAR(5),
    name VARCHAR2(20),
    dept_name VARCHAR2(30),
    salary NUMBER
);

CREATE TABLE course(
    course_id VARCHAR2(15),
    title VARCHAR2(50),
    dept_name VARCHAR2(30),
    
    credits NUMERIC(2,1)
);


-- Lab Task #02
INSERT INTO instructor VALUES('10101', 'Srinivasan', 'Comp. Sci.', 65000);
INSERT INTO instructor VALUES('12121', 'Wu', 'Finance', 90000);
INSERT INTO instructor VALUES('15151', 'Mozart', 'Music', 40000);
INSERT INTO instructor VALUES('22222', 'Einstein', 'Physics', 95000);
INSERT INTO instructor VALUES('32343', 'El Said', 'History', 60000);
INSERT INTO instructor VALUES('33456', 'Gold', 'Physics', 87000);
INSERT INTO instructor VALUES('45565', 'Katz', 'Comp. Sci.', 75000);
INSERT INTO instructor VALUES('58583', 'Califieri', 'History', 62000);
INSERT INTO instructor VALUES('76543', 'Singh', 'Finance', 80000);
INSERT INTO instructor VALUES('76766', 'Crick', 'Biology', 72000);
INSERT INTO instructor VALUES('83821', 'Brandt', 'Comp. Sci.', 92000);
INSERT INTO instructor VALUES('98345', 'Kim', 'Elec. Eng.', 80000);

INSERT INTO course VALUES('BIO-101', 'Intro. to Biology', 'Biology', 4);
INSERT INTO course VALUES('BIO-301', 'Genetics', 'Biology', 4);
INSERT INTO course VALUES('BIO-399', 'Computational Biology', 'Biology', 3);
INSERT INTO course VALUES('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', 4);
INSERT INTO course VALUES('CS-190', 'Game Design', 'Comp. Sci.', 4);
INSERT INTO course VALUES('CS-315', 'Robotics', 'Comp. Sci.', 3);
INSERT INTO course VALUES('CS-319', 'Image Processing', 'Comp. Sci.', 3);
INSERT INTO course VALUES('CS-347', 'Database System Concepts', 'Comp. Sci.', 3);
INSERT INTO course VALUES('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', 3);
INSERT INTO course VALUES('FIN-201', 'Investment Banking', 'Finance', 3);
INSERT INTO course VALUES('HIS-351', 'World History', 'History', 3);
INSERT INTO course VALUES('MU-199', 'Music Video Production', 'Music', 3);
INSERT INTO course VALUES('PHY-101', 'Physical Principles', 'Physics', 4);


-- Lab Task #03
-- 1
SELECT name FROM instructor;

-- 2
SELECT course_id, title FROM course;

-- 3
SELECT name, dept_name FROM instructor WHERE id = '22222';

-- 4
SELECT title, credits FROM course WHERE dept_name = 'Comp. Sci.';

-- 5
SELECT NAME, dept_name FROM instructor WHERE salary > 70000;

-- 6
SELECT title FROM course WHERE credits >= 4;

-- 7
SELECT name, dept_name FROM instructor WHERE salary >= 80000 AND salary <= 100000; 

-- 8 
SELECT title, credits FROM course WHERE dept_name != 'Comp. Sci.';

-- 9 
SELECT * FROM instructor;

-- 10
SELECT * FROM COURSE WHERE dept_name = 'Biology' AND credits != 4; 
