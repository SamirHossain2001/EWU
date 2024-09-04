drop table patient cascade constraints;
drop table doctor cascade constraints;
drop table appointments cascade constraints;
drop table medicalrecords cascade constraints;
drop table departments cascade constraints;

create table patient(
    patient_id varchar(3),
    name varchar(20),
    gender varchar(6),
    date_of_birth Date,
    contact_number varchar(20),
    address varchar(30)
);

create table doctor(
    doctor_id varchar(3),
    name varchar(30),
    specialization varchar(20),
    contact_number varchar(20),
    email varchar(30),
    department_id varchar(6)
);

create table appointments(
    appointment_id number,
    patient_id varchar(3),
    doctor_id varchar(3),
    appointment_date Date,
    appointment_time varchar(10),
    reason_for_visit varchar(30)  
);

create table medicalrecords(
    record_id number,
    patient_id varchar(3),
    doctor_id varchar(3),
    date_of_visit Date,
    diagnosis varchar(20),
    prescribed_medications varchar(40)  
);

create table departments(
    department_id varchar(6),
    department_name varchar(20),
    department_head varchar(30),
    number_of_employees number
);

-- INSERT INTO PATIENT 
INSERT INTO PATIENT(patient_id, name, gender, date_of_birth, contact_number, address)
    values('P-1', 'John Smith', 'Male', to_date('1985-08-10','yyyy-mm-dd'), 1234567890, '123 Main St'); 
INSERT INTO PATIENT(patient_id, name, gender, date_of_birth, contact_number, address)
    values('P-2', 'Jane Doe', 'Female', to_date('1990-04-15','yyyy-mm-dd'), 9876543210, '456 Elm St'); 
INSERT INTO PATIENT(patient_id, name, gender, date_of_birth, contact_number, address)
    values('P-3', 'Michael Johnson', 'Male', to_date('1978-12-22','yyyy-mm-dd'), 5551234567, '789 Oak Ave'); 
-- TEST 3
INSERT INTO PATIENT(patient_id, name, gender, date_of_birth, contact_number, address)
    values('P-4', 'Samir Hossain', 'Male', to_date('1978-12-22','yyyy-mm-dd'), 5551234567, '789 Oak Ave');

-- INSERT INTO DOCTOR
INSERT INTO Doctor(doctor_id, name, specialization, contact_number, email, department_id)
    values('D-1', 'Dr. Emily Adams', 'Cardiology', 5559876543, 'emily.adams@example.com', 'DEPT-1');
INSERT INTO Doctor(doctor_id, name, specialization, contact_number, email, department_id)
    values('D-2', 'Dr. Robert Davis', 'Pediatrics', 5551234567, 'robert.davis@example.com', 'DEPT-2');
INSERT INTO Doctor(doctor_id, name, specialization, contact_number, email, department_id)
    values('D-3', 'Dr. Sarah Wilson', 'Orthopedics', 5552223333, 'sarah.wilson@example.com', 'DEPT-3');

-- INSERT INTO APPOINTMENTS
INSERT INTO APPOINTMENTS(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit)
    values(1, 'P-1', 'D-1', to_date('2023-07-17','yyyy-mm-dd'), '10:00 AM', 'Chest pain');
INSERT INTO APPOINTMENTS(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit)
    values(2, 'P-2', 'D-3', to_date('2023-07-18','yyyy-mm-dd'), '2:30 PM', 'Broken arm');
INSERT INTO APPOINTMENTS(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit)
    values(3, 'P-3', 'D-2', to_date('2023-07-19','yyyy-mm-dd'), '9:15 AM', 'Fever');
-- for test 2
INSERT INTO APPOINTMENTS(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit)
    values(4, 'P-1', 'D-1', to_date('2023-07-19','yyyy-mm-dd'), '9:15 AM', 'Died');
INSERT INTO APPOINTMENTS(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit)
    values(5, 'P-1', 'D-2', to_date('2023-07-19','yyyy-mm-dd'), '9:15 AM', 'Died');
INSERT INTO APPOINTMENTS(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit)
    values(6, 'P-1', 'D-2', to_date('2023-07-19','yyyy-mm-dd'), '9:15 AM', 'Died');
INSERT INTO APPOINTMENTS(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit)
    values(7, 'P-2', 'D-2', to_date('2023-07-19','yyyy-mm-dd'), '9:15 AM', 'Died');
INSERT INTO APPOINTMENTS(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit)
    values(8, 'P-2', 'D-2', to_date('2023-07-19','yyyy-mm-dd'), '9:15 AM', 'Died');

-- INSERT INTO MEDICALRECORDS
INSERT INTO MEDICALRECORDS(record_id, patient_id, doctor_id, date_of_visit, diagnosis, prescribed_medications)
    values(101, 'P-1', 'D-1', to_date('2023-07-17','yyyy-mm-dd'), 'Angina', 'Nitroglycerin');
INSERT INTO MEDICALRECORDS(record_id, patient_id, doctor_id, date_of_visit, diagnosis, prescribed_medications)
    values(201, 'P-2', 'D-3', to_date('2023-07-18','yyyy-mm-dd'), 'Fractured radius', 'Painkiller, Cast');
INSERT INTO MEDICALRECORDS(record_id, patient_id, doctor_id, date_of_visit, diagnosis, prescribed_medications)
    values(301, 'P-3', 'D-2', to_date('2023-07-19','yyyy-mm-dd'), 'Influenza', 'Antipyretics');

-- INSERT INTO DEPARTMENTS
INSERT INTO DEPARTMENTS(department_id, department_name, department_head, number_of_employees)
    VALUES('DEPT-1', 'Cardiology', 'Dr. Emily Adams', 5);
INSERT INTO DEPARTMENTS(department_id, department_name, department_head, number_of_employees)
    VALUES('DEPT-2', 'Pediatrics', 'Dr. Robert Davis', 7);
INSERT INTO DEPARTMENTS(department_id, department_name, department_head, number_of_employees)
    VALUES('DEPT-3', 'Orthopedics', 'Dr. Sarah Wilson', 4);

SELECT * FROM PATIENT;
SELECT * FROM DOCTOR;
SELECT * FROM APPOINTMENTS;
SELECT * FROM MEDICALRECORDS;
SELECT * FROM DEPARTMENTS;


-- 1.1
SELECT DISTINCT p.name
FROM PATIENT p
JOIN APPOINTMENTS a
    USING(patient_id)
JOIN DOCTOR d
    USING(doctor_id)
WHERE d.specialization = 'Cardiology';

-- 1.2
SELECT p.name
FROM patient p
WHERE patient_id in (SELECT DISTINCT patient_id
                     FROM doctor d
                     JOIN appointments a
                        ON d.doctor_id = a.doctor_id
                     WHERE d.specialization = 'Cardiology')
-- 2.1
SELECT name
FROM PATIENT
WHERE patient_id in (
                     SELECT Distinct patient_id
                     from APPOINTMENTS
                     GROUP BY patient_id,  doctor_id
                     HAVING COUNT(*) > 1);
-- 2.2
SELECT Distinct p.name
FROM PATIENT p,(SELECT patient_id, doctor_id, count(*) AS times_visited
              from APPOINTMENTS
              GROUP BY patient_id,  doctor_id
              HAVING COUNT(*) > 1) VISITED
WHERE p.patient_id = visited.patient_id;

-- 3.1
SELECT p.name
FROM PATIENT p
LEFT OUTER JOIN APPOINTMENTS a
    ON p.patient_id = a.patient_id
WHERE a.doctor_id IS NULL;

-- 3.2
SELECT p.name
FROM patient p
WHERE p.patient_id NOT IN (SELECT DISTINCT patient_id
                       FROM appointments)

-- 4
WITH appointment_count(doctor_id, app_count) as
    (SELECT doctor_id, count(patient_id)
     FROM APPOINTMENTS
     GROUP BY doctor_id),
     avg_appointment(value) as
     (SELECT AVG(app_count)
      FROM appointment_count)
SELECT d.name
FROM DOCTOR d, APPOINTMENT_COUNT c, AVG_APPOINTMENT a
WHERE d.doctor_id = c.doctor_id
    AND c.app_count > a.value;

-- 5
SELECT d.name
FROM DOCTOR d, (SELECT a.doctor_id, COUNT(DISTINCT gender) AS gender_count
                FROM APPOINTMENTS a
                JOIN PATIENT p
                    ON a.patient_id = p.patient_id  
                GROUP BY a.doctor_id
                --ORDER BY a.doctor_id
                ) V
WHERE d.doctor_id = v.doctor_id
    AND v.gender_count = 2;
    
-- 6
SELECT department_name
FROM DEPARTMENTS
WHERE number_of_employees <= ALL(SELECT number_of_employees
                                 FROM DEPARTMENTS);

