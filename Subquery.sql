CREATE TABLE departments (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    location TEXT
);
CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    department_id INTEGER,
    salary INTEGER,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);
INSERT INTO departments (id, name, location) VALUES
(1, 'HR', 'Hyderabad'),
(2, 'Finance', 'Mumbai'),
(3, 'Engineering', 'Bangalore');
INSERT INTO employees (id, name, department_id, salary) VALUES
(1, 'Mahi', 1, 50000),
(2, 'Saru', 2, 60000),
(3, 'Manoj', 3, 70000),
(4, 'David', 3, 80000);
SELECT 
    name,
    (SELECT AVG(salary) FROM employees) AS avg_salary
FROM 
    employees;

SELECT 
    name 
FROM 
    employees 
WHERE 
    department_id IN (SELECT id FROM departments WHERE location = 'Hyderabad');

SELECT 
    e1.name 
FROM 
    employees e1 
WHERE 
    salary > (SELECT AVG(salary) FROM employees e2 WHERE e1.department_id = e2.department_id);

SELECT 
    dept_id, AVG(salary) 
FROM 
    (SELECT department_id AS dept_id, salary FROM employees) AS dept_salaries 
GROUP BY 
    dept_id;

SELECT 
    name 
FROM 
    employees e 
WHERE 
    EXISTS (
        SELECT 1 FROM departments d WHERE d.id = e.department_id AND d.name = 'HR'
    );