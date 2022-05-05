
--Retrieve Employees
SELECT 
	emp_no, 
	first_name, 
	last_name
FROM employees;

--Retrieve Titles
SELECT 
	title,
	from_date,
	to_date
FROM titles;

--Combining tables, filter birth dates, order by employee numbers
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
ON (t.emp_no=e.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-01-01')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles
	

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
 	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles

--Retrieve the number of employees by recent job title, and count the number of titles.

SELECT COUNT(ut.title),
	ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

SELECT * FROM retiring_titles

--Retrieve employee id, first and lase name, and birth date

SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (de.emp_no=e.emp_no)
INNER JOIN titles as t
ON (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')	
AND de.to_date='9999-01-01'
ORDER BY e.emp_no;
 
SELECT * FROM mentorship_eligibilty

--Creating table for names that are retiring and current
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO retiring_current
FROM employees as e
INNER JOIN dept_emp as de
ON (de.emp_no=e.emp_no)
INNER JOIN titles as t
ON (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-01-01')
AND de.to_date='9999-01-01'
ORDER BY e.emp_no;

SELECT * FROM retiring_current

--Creating count for unique titles for employees that are retiring. 
SELECT COUNT(rc.title),
	rc.title
INTO retiring_count
FROM retiring_current as rc
GROUP BY rc.title
ORDER BY rc.count DESC;

SELECT * FROM retiring_count


