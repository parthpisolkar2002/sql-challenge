CREATE TABLE Titles (
    title_id VARCHAR PRIMARY KEY NOT NULL,
    title VARCHAR NOT NULL
);

--Drop table employees cascade;
CREATE TABLE Employees(
    emp_no INT PRIMARY KEY NOT NULL,
    emp_title_id VARCHAR,
    birth_date VARCHAR,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    sex VARCHAR,
    hire_date VARCHAR,
  	FOREIGN KEY (emp_title_id) REFERENCES Titles(title_id)
);

CREATE TABLE Departments (
    dept_no VARCHAR PRIMARY KEY NOT NULL,
    dept_name VARCHAR NOT NULL
);
--drop table department_managers;
CREATE TABLE Department_managers (
	dept_no VARCHAR not null, -- changed order of this columns
	emp_no varchar not null, -- changed the data type to int
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),	
    PRIMARY KEY (dept_no, emp_no)
);
--drop table Department_Employees;
CREATE TABLE Department_Employees (
    emp_no INT NOT NULL,
    dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
    PRIMARY KEY (dept_no, emp_no)
);
--drop table salaries;
CREATE TABLE Salaries (
    emp_no INT primary key NOT NULL,
    salary VARCHAR,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);


--Data Analysis 1
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM Employees e
JOIN Salaries s ON e.emp_no = s.emp_no;

--Data Analysis 2
SELECT first_name, last_name, hire_date
FROM Employees
WHERE EXTRACT(YEAR FROM TO_DATE(hire_date, 'MM/DD/YYYY')) = 1986;

--Data Analysis 3
Select dm.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
From Department_managers dm
JOIN Employees e ON e.emp_no = dm.emp_no
JOIN Departments d ON d.dept_no = dm.dept_no;

--Data Analysis 4
Select de.emp_no, de.dept_no, e.last_name, e.first_name, d.dept_name
From Department_employees de
JOIN Employees e ON e.emp_no = de.emp_no
JOIN Departments d ON d.dept_no = de.dept_no;

--Data Analysis 5
Select first_name, last_name, sex
From Employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--Data Analysis 6
Select de.emp_no, e.last_name, e.first_name
FROM Department_employees de
JOIN Employees e ON e.emp_no = de.emp_no
JOIN Departments d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';

--Data Analysis 7
Select de.emp_no, e.last_name, e.first_name, d.dept_name
FROM Department_employees de
JOIN Employees e ON e.emp_no = de.emp_no
JOIN Departments d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Development';

--Data Analysis 8
SELECT last_name, COUNT(*) AS frequency
FROM Employees
GROUP BY last_name
ORDER BY frequency DESC;




