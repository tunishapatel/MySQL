-- Creating employee table query

CREATE TABLE `employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `mobile_number` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));

-- Creating hobby table query

CREATE TABLE `hobby` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));

-- Creating employee_hobby table query

CREATE TABLE `employee_hobby` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_employee_id` INT NOT NULL,
  `fk_hobby_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employee_id_idx` (`fk_employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_id`
    FOREIGN KEY (`fk_employee_id`)
    REFERENCES `employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_hobby_id`
    FOREIGN KEY (`fk_hobby_id`)
    REFERENCES `hobby` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- Creating employee_salary table query

CREATE TABLE `employee_salary` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_employeeID` INT NOT NULL,
  `salary` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employeeID_idx` (`fk_employeeID` ASC) VISIBLE,
  CONSTRAINT `fk_employeeID`
    FOREIGN KEY (`fk_employeeID`)
    REFERENCES `employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



----------------------------------------------------------------------------

-- INSERT, UPDATE & DELETE QUERY FOR EMPLOYEE TABLE


INSERT INTO employee (first_name, last_name, age, mobile_number,address)
value ('Richa', 'Pandey', 23, '+91 6482448443', 'Delhi');

UPDATE employee
SET first_name ='Victoria'
WHERE id = 3;

DELETE FROM employee WHERE id = 6;
DELETE FROM employee WHERE id = 3;



-- INSERT, UPDATE & DELETE QUERY FOR HOBBY TABLE


INSERT INTO hobby (name)
VALUE ('Micky');

UPDATE hobby
SET name ='Maggie'
WHERE id = 4;

DELETE FROM hobby WHERE id = 3;
DELETE FROM hobby WHERE id = 2;


-- INSERT, UPDATE & DELETE QUERY FOR EMPLOYEE_HOBBY TABLE

INSERT INTO  employee_hobby(fk_employee_id, fk_hobby_id)
VALUE (2, 3);

UPDATE employee_hobby 
SET fk_employee_id = 2
WHERE id = 4;

DELETE FROM employee_hobby WHERE id = 9;


-- INSERT, UPDATE & DELETE QUERY FOR EMPLOYEE_SALARY TABLE


INSERT INTO employee_salary(fk_employee_id, salary, date)
VALUE (1, 50000, ‘20/02/11’);

UPDATE employee_salary 
SET fk_employee_id = 2, salary = 52000
WHERE id = 4;

DELETE FROM employee_salary WHERE id = 6;



-- Truncate employee_hobby table 

TRUNCATE TABLE employee_hobby;

-- Truncate employee_salary table 

TRUNCATE TABLE employee_salary;

-- Truncate employee table and hobby table 

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE employee;
TRUNCATE hobby;

SET FOREIGN_KEY_CHECKS = 1;



-- A select query to get only employee name, hobby_name

SELECT first_name FROM employee
UNION 
SELECT name FROM hobby;

-- A select query to get  employee name, his/her employee_salary

SELECT emp.first_name, es.salary
FROM employee_salary es
INNER JOIN employee emp ON emp.id = es.fk_employee_id ;


-- Creating select query of employee name, total salary, hobby name

SELECT emp.id, concat(emp.first_name," ", emp.last_name) name, 
es.SUM(salary) paid,
(
SELECT group_concat(hb.name)
FROM employee_hobby eh
INNER JOIN hobby hb ON hb.id = eh.fk_hobby_id
WHERE emp.id = eh.fk_employee_id
) hobby_name
FROM employee_salary es
INNER JOIN employee emp ON emp.id = es.fk_employee_id
GROUP BY emp.id;

