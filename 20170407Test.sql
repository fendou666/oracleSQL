SELECT * FROM(
SELECT count(*) cnt, department_id FROM employees 
WHERE salary<800 OR salary>2000 
GROUP BY department_id)

WHERE cnt>1;

SELECT e.*, salary || null FROM employees e;
--DISTINCT�������SELECT����
SELECT manager_id, DISTINCT department_id FROM employees;
SELECT DISTINCT manager_id, department_id FROM employees;

--�����Ա���Ҫ AND OR NOT�߼������
SELECT * FROM employees WHERE manager_id>100, department_id =90;

SELECT * FROM employees WHERE manager_id BETWEEN 100 AND 120 AND department_id IN (90,50);

SELECT * FROM employees WHERE manager_id BETWEEN 100 AND 120;

SELECT employee_id "Ա��ID", department_id "����ID" FROM employees;

SELECT employee_id "Ա��ID", department_id "����ID" FROM employees ORDER BY "Ա��ID";

SELECT manager_id "������ID", department_id "����ID" FROM employees 
ORDER BY "������ID", "����ID" DESC;

SELECT * FROM employees WHERE first_name = 'Michael';


SELECT first_name �� FROM employees WHERE first_name = 'Michael';
