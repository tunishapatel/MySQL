-- Select query to get name (firstname + lastname), department name, country name, job name

SELECT 
concat (emp.firstname, ' ' , emp.lastname) name,
d.name department_name, 
c.name country_name,
j.name job_name 
FROM employee emp
JOIN department d ON emp.fk_department_id = d.id
JOIN country c ON d.fk_country_id = c.id
JOIN job j ON emp.fk_job_id = j.id


-- Select query to get  2nd highest salary from all the employees


SELECT DISTINCT salary 
FROM employee emp1 
WHERE 2 =
(SELECT count(DISTINCT salary) 
FROM employee emp2
WHERE emp1.salary <= emp2.salary);


-- Select query to get  all job name and department name in single query

SELECT name FROM job
UNION
SELECT name FROM department
