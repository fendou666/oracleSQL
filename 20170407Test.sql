SELECT * FROM(
SELECT count(*) cnt, department_id FROM employees 
WHERE salary<800 OR salary>2000 
GROUP BY department_id)

WHERE cnt>1;

SELECT e.*, salary || null FROM employees e;
--DISTINCT必须放在SELECT后面
SELECT manager_id, DISTINCT department_id FROM employees;
SELECT DISTINCT manager_id, department_id FROM employees;

--经测试必须要 AND OR NOT逻辑运算符
SELECT * FROM employees WHERE manager_id>100, department_id =90;

SELECT * FROM employees WHERE manager_id BETWEEN 100 AND 120 AND department_id IN (90,50);

SELECT * FROM employees WHERE manager_id BETWEEN 100 AND 120;

SELECT employee_id "员工ID", department_id "部门ID" FROM employees;

SELECT employee_id "员工ID", department_id "部门ID" FROM employees ORDER BY "员工ID";

SELECT manager_id "管理者ID", department_id "部门ID" FROM employees 
ORDER BY "管理者ID", "部门ID" DESC;

SELECT * FROM employees WHERE first_name = 'Michael';


SELECT first_name 姓 FROM employees WHERE first_name = 'Michael';
