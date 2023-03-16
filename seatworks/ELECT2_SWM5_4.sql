DROP SCHEMA IF EXISTS corpdb;
CREATE SCHEMA corpdb;
USE corpdb;

DROP TABLE employeeInfo;
DROP TABLE departments;
DROP TABLE employeePerfReview;
DROP TABLE employeeLeaveHist;

CREATE TABLE departments (
    deparment_id            INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    department_name         VARCHAR(45) NOT NULL
);

CREATE TABLE employeeInfo (
    employee_id         INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    employee_firstName  VARCHAR(45) NOT NULL,
    employee_lastName   VARCHAR(45) NOT NULL,
    employee_email      VARCHAR(45) NOT NULL,
    employee_contactNo  VARCHAR(11) NOT NULL,
    employee_address    VARCHAR(45) NOT NULL,
    employee_bdate      DATE NULL,
    employee_jobTitle   VARCHAR(45) NOT NULL,
    employee_hourlyRate DECIMAL(10, 2) NOT NULL,

    department_id       INT NOT NULL,
    INDEX fk_departmentE_idx (department_id ASC) VISIBLE,
    CONSTRAINT fk_departmentE_id
        FOREIGN KEY (department_id)
        REFERENCES departments (deparment_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);

CREATE TABLE employeeLeaveHist (
    employeeLeave_id    INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    leave_startDate     DATE NOT NULL,
    leave_endDate       DATE NOT NULL,
    leave_purpose       VARCHAR(255) NOT NULL,
    leave_paidLeave     INT NOT NULL,

    employee_id         INT NOT NULL,
    INDEX fk_employeeL_idx (employee_id ASC) VISIBLE,
    CONSTRAINT fk_employeeL_id
        FOREIGN KEY (employee_id)
        REFERENCES employeeInfo (employee_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);
CREATE TABLE employeePerfReview (
    employeePerfRev_id  INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    employee_remarks    VARCHAR(45) NOT NULL,
    employee_rating     INT NOT NULL,
    employee_dateReview DATE NOT NULL,

    employee_id         INT NOT NULL,
    INDEX fk_employeePR_idx (employee_id ASC) VISIBLE,
    CONSTRAINT fk_employeePR_id
        FOREIGN KEY (employee_id)
        REFERENCES employeeInfo (employee_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);