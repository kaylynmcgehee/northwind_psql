DROP DATABASE IF EXISTS COMPANY;
CREATE DATABASE COMPANY;

\c COMPANY;

CREATE TABLE public.EMPLOYEE();
ALTER TABLE EMPLOYEE
  add column   Fname varchar,
  add column   Minit char,
  add column   Lname varchar,
  add column   Ssn int,
  add column   Bdate date,
  add column   Address varchar,
  add column   Sex char,
  add column   Salary decimal,
  add column   Super_ssn int,
  add column   Dno int;
ALTER TABLE EMPLOYEE
  add primary key (Ssn);
ALTER TABLE EMPLOYEE
 alter column Ssn type bigint;
ALTER TABLE EMPLOYEE
 alter column Super_ssn type bigint;

CREATE TABLE public.DEPARTMENT();
ALTER TABLE DEPARTMENT
 add column   Dname varchar,
 add column   Dnumber int,
 add column   Mgr_ssn int,
 add column   Mgr_start_date date;
ALTER TABLE DEPARTMENT
  add primary key (Dnumber);
ALTER TABLE DEPARTMENT
 add unique (dname),
 add foreign key (Mgr_ssn) references employee(Ssn);


CREATE TABLE public.DEPT_LOCATIONS();
ALTER TABLE DEPT_LOCATIONS
 add column   Dnumber int,
 add column   Dlocation varchar;
ALTER TABLE DEPT_LOCATIONS
  add primary key (Dnumber, Dlocation);
ALTER TABLE DEPT_LOCATIONS
 add foreign key (Dnumber) references department(Dnumber);


CREATE TABLE public.PROJECT();
ALTER TABLE PROJECT
 add column   Pname varchar,
 add column   Pnumber int,
 add column   Plocation varchar,
 add column   Dnum int;
ALTER TABLE PROJECT
 add primary key (Pnumber);
ALTER TABLE PROJECT
 add unique (Pname),
 add foreign key (Dnum) references department(Dnumber);


CREATE TABLE public.WORKS_ON();
ALTER TABLE WORKS_ON
 add column   Essn int,
 add column   Pno int,
 add column   Hours decimal;
ALTER TABLE WORKS_ON
 add primary key (Essn, Pno);
ALTER TABLE WORKS_ON
 add foreign key (Essn) references employee(Ssn),
 add foreign key (Pno) references project(Pnumber);


CREATE TABLE public.DEPENDENT();
ALTER TABLE DEPENDENT
 add column   Essn int,
 add column   Dependent_name varchar,
 add column   Sex char,
 add column   Bdate date,
 add column   Relationship varchar;
ALTER TABLE DEPENDENT
 add primary key (Essn, Dependent_name);
ALTER TABLE DEPENDENT
 add foreign key (Essn) references employee(Ssn);

CREATE TABLE EXPENSES(
 Essn int,
 Totalex decimal
);

CREATE TABLE PAYCHECKS(
 Essn int,
 Totalpay decimal
);




INSERT INTO EMPLOYEE(Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno)
VALUES
 ('John', 'B', 'Smith', '123456789','1965-01-09', '731 Fondren, Houston, TX', 'M', '30000','333445555','5'),
 ('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638 Voss, Houston, TX', 'M', '40000', '888665555', '5'),
 ('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring, TX', 'F', '25000', '987654321','4'),
 ('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX', 'F', '43000', '8886655555', '4'),
 ('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', '38000', '333445555', '5'),
 ('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', '25000', '333445555', '5'),
 ('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston, TX', 'M', '25000', '987654321', '4'),
 ('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston, TX', 'M', '55000', NULL, '1');

INSERT INTO DEPARTMENT(Dname, Dnumber, Mgr_ssn, Mgr_start_date)
VALUES
 ('Research', '5', '333445555', '1988-05-22'),
 ('Administration', '4', '987654321', '1995-01-01'),
 ('Headquarters', '1', '888665555', '1981-06-19');

INSERT INTO DEPT_LOCATIONS(Dnumber, Dlocation)
VALUES
 ('1', 'Houston'),
 ('4', 'Stafford'),
 ('5', 'Bellaire'),
 ('5', 'Sugarland'),
 ('5', 'Houston');

INSERT INTO WORKS_ON(Essn, Pno, Hours)
VALUES
 ('123456789', '1', '32.5'),
 ('123456789', '2', '7.5'),
 ('666884444', '3', '40.0'),
 ('453453453', '1', '20.0'),
 ('453453453', '2', '20.0'),
 ('333445555', '2', '10.0'),
 ('333445555', '3', '10.0'),
 ('333445555', '10', '10.0'),
 ('333445555', '20', '10.0'),
 ('999887777', '30', '30.0'),
 ('999887777', '10', '10.0'),
 ('987987987', '10', '35.0'),
 ('987987987', '30', '5.0'),
 ('987654321', '30', '20.0'),
 ('987654321', '20', '15.0'),
 ('888665555', '20', NULL);

INSERT INTO PROJECT(Pname, Pnumber, Plocation, Dnum)
VALUES
 ('ProductX', '1', 'Bellaire', '5'),
 ('ProductY', '2', 'Sugarland', '5'),
 ('ProductZ', '3', 'Houston', '5'),
 ('Computerization', '10', 'Stafford', '4'),
 ('Reorganization', '20', 'Houston', '1'),
 ('Newbenefits', '30', 'Stafford', '4');

INSERT INTO DEPENDENT(Essn, Dependent_name, Sex, Bdate, Relationship)
VALUES
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'),
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'),
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'),
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'),
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'),
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');



--queries from 6.10
--a
    SELECT Fname, Minit, Lname
    FROM EMPLOYEE
    WHERE Dno= '5'
    AND Ssn IN(
        SELECT Essn
        FROM WORKS_ON
        WHERE Pno IN(
            SELECT Pnumber
            FROM PROJECT
            WHERE Pname = 'ProductX'
            )
        AND Hours>10
        );
--b
    SELECT Fname, Minit, Lname
    FROM EMPLOYEE
    WHERE EXISTS(
        SELECT 1
        FROM DEPENDENT x
        WHERE x.Essn = Ssn
        AND x.dependent_name = Fname
    );
--c
    SELECT Fname, Minit, Lname
    FROM EMPLOYEE
    WHERE Ssn IN(
        SELECT Ssn
        FROM EMPLOYEE
        WHERE Super_ssn = (
            SELECT Ssn
            FROM EMPLOYEE
            WHERE Fname = 'Franklin'
            AND Lname = 'Wong'
            )
        );
