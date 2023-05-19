-- Use the provided information to create a table schema for each of the six CSV files
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
	dept_no VARCHAR NOT NULL,
	dept_name VARCHAR NOT NULL,
	PRIMARY KEY (dept_no)
);
DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	PRIMARY KEY (emp_no,dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	PRIMARY KEY (dept_no,emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
	emp_no INT NOT NULL,
	emp_title_id VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);
DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
	title_id VARCHAR NOT NULL,
	title VARCHAR NOT NULL,
	PRIMARY KEY (title_id)
);

-- Import each CSV file into its corresponding SQL table.

-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, 
  employees.last_name, 
  employees.first_name, 
  employees.sex, 
  salaries.salary
FROM employees
JOIN salaries 
ON employees.emp_no = salaries.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT employees.first_name, 
  employees.last_name, 
  employees.hire_date 
FROM employees
WHERE hire_date 
BETWEEN '1986-01-01' AND '1987-01-01';

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dept_manager.dept_no,
	departments.dept_name,
	dept_manager.emp_no,
	employees.last_name, 
 	employees.first_name
FROM dept_manager
JOIN departments
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON employees.emp_no = dept_manager.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT dept_emp.dept_no,
	dept_emp.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT employees.first_name,
	employees.last_name,
	employees.sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT departments.dept_name,
	dept_emp.emp_no,
	employees.last_name,
	employees.first_name
FROM departments
JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT departments.dept_name,
	dept_emp.emp_no,
	employees.last_name,
	employees.first_name
FROM departments
JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name,
COUNT(last_name)
FROM employees GROUP BY last_name ORDER BY COUNT(last_name) DESC;