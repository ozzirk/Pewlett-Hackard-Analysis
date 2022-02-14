-------DELIVERABLE 1

--Setting up tables for query

Create Table Employees(emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
)
Create Table Titles(emp_no INT NOT NULL,
				   title varchar NOT Null,
				   from_date DATE NOT NULL,
				   to_date DATE NOT NULL)
				   
--Selecting relevant columns and joining tables on employee number				   
SELECT 
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- check retirement_titles table
select * from retirement_titles;

-- remove duplicates, filter for current employees
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

-- check unique_titles table
select * from unique_titles

-- find employees near retirement by title
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY count(ut.title) DESC;

-- check retirement counts 
SELECT * FROM retiring_titles

-------DELIVERABLE 2
-- set up dept_emp table
CREATE TABLE dept_emp(
			 emp_no	INT NOT NULL,
			 dept_no VARCHAR NOT NULL,
			from_date DATE,
			to_date DATE)

Select * FROM dept_emp

-- create table for mentorship eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- check table
select * from mentorship_eligibilty