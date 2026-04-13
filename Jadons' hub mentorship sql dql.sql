-- ============================================
-- HR DATABASE ANALYSIS PROJECT
-- Author: Isaac Mbagwu
-- ============================================


-- ============================================
-- DATABASE OVERVIEW
-- ============================================


-- View row count for each table

SELECT 'employees' AS table_name, COUNT(*) AS row_count FROM employees
UNION 
SELECT 'department', COUNT(*) FROM department 
UNION
SELECT 'payroll', COUNT(*) FROM payroll
UNION
SELECT 'emp_location', COUNT(*) FROM emp_location;

-- Preview tables

SELECT *
FROM department;
SELECT *
FROM emp_location;
SELECT *
FROM employees;
SELECT *
FROM payroll;

-- ============================================
-- BUSINESS QUESTIONS & ANALYSIS
-- ============================================

-- 1. Employee, Role, and Department Overview

SELECT e.emp_name,
	e.emp_role,
	d.department,
    d.segment
FROM employees e
JOIN department d
ON e.emp_id = d.employee_id
ORDER BY d.department ASC
;	

## SALARY LEADERBOARD
-- 2. Top 5 Highest Paid Employees

SELECT emp_name,
	emp_role,
    emp_salary
FROM employees 
ORDER BY emp_salary DESC
LIMIT 5;
	
## DEPARTMENT HEADCOUNT
-- 3. How many employees are assigned to each department?

SELECT 
	department,
    COUNT(employee_id) AS total_staff
FROM department
GROUP BY department
ORDER BY total_staffs DESC;

## TOTAL COMPENSATION ANALYSIS
-- 4. What is the total 'Take home' pay (salary + bonus) for every employee?

SELECT e.emp_name,
	p.salary,
	p.bonus,
	(p.salary + p.bonus) AS total_compensation
FROM employees E
JOIN payroll p
ON e.emp_id = p.emp_id
ORDER BY total_compensation DESC;
    
## 5. AGE DEMOGRAPHICS (OLDEST EMPLOYEES)
-- How old is each employee, and who is the oldest person on the team?

SELECT emp_name,
	emp_date_of_birth,
	TIMESTAMPDIFF(YEAR, emp_date_of_birth, CURDATE()) AS Age
FROM employees
ORDER BY Age DESC;    

## 6. REGIONAL FOOTPRINT
-- Which geographical locations have the highest concentration of staffs?

SELECT
	d.location,
	COUNT(l.location_id) AS number_of_staff
FROM emp_location l
JOIN department d
ON l.employee_id = d.employee_id
GROUP BY d.location
ORDER BY number_of_staffs DESC;

## AVERAGE PAY PER ROLE
-- 7 What is the average salary for each specific role in the company?

SELECT e.emp_role,
	ROUND(AVG(p.salary), 2) AS ave_role_salary
FROM employees e
JOIN payroll p 
ON e.emp_id = p.emp_id
GROUP BY e.emp_role
ORDER BY ave_role_salary DESC;

## BONUS VS. SALARY RATIO
-- 8. Which employees are receiving a bonus that is more than 15% their salary?

SELECT e.emp_name,
	p.salary,
    p.bonus,
    ROUND((p.bonus / p.salary) * 100, 2) AS bonus_percentage
FROM employees e
JOIN payroll p 
ON e.emp_id = p.emp_id
WHERE (p.bonus / p.salary) * 100 > 15
ORDER BY bonus_percentage DESC;
	