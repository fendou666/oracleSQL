--������[���ؾ��ǵ���n�ű�]
SELECT * FROM employees ORDER BY employee_id;
--��ѯԱ����ţ����������ű�ţ��������ƣ������ӣ�û�в��ŵ�Ա��Ҳ���أ�
SELECT e.employee_id, e.last_name, m.employee_id, m.last_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id ORDER by e.employee_id;
--������û�в��ŵ�Ա��Ҳ����
SELECT e.employee_id,
       e.last_name,
       m.employee_id mgr_id,
       m.last_name   mgr_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id(+)
ORDER by e.employee_id;
--��ѯ˭�Ĺ��ʱ�Able��[����������]
SELECT e1.employee_id, e1.last_name, e1.salary
FROM employees e1, employees e2
WHERE e1.salary>e2.salary
AND e2.last_name='Abel'; 

--1999�����Ƽ�99���Ч�ʿ�,ֻ��һ����ͨ��join��Ӷ���� 
--��ѯԱ����ţ����������ű��,��������(�����)
SELECT e.employee_id, e.last_name, d.d
FROM employees e
CROSS JOIN departments d;

---CROSS JOIN����
--2.��ѯԱ����ţ����������ű��,�������ƣ�ְ���ţ�ְ������
92�﷨
SELECT 
e.employee_id, e.first_name, 
d.department_id, d.department_name, 
j.job_id, j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id and e.job_id = j.job_id;


SELECT 
e.employee_id, e.first_name, 
d.department_id, d.department_name, 
j.job_id, j.job_title
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id INNER JOIN jobs j ON e.job_id = j.job_id;

--3.��ѯ���в��ŵı�ţ��������ƣ����ž���ID�����ž����������������ڵĳ��У����ң�����
--deprartments manager locations  countries regions
SELECT * FROM locations;
SELECT 
d.department_id, d.department_name, m.manage_id, m.manage_name, l.city, cou.country_name, reg.region_name 
FROM departments d, manager m,locations l,countries cou,regions reg
WHERE d.manager_id=m.manage_id 
AND d.location_id=l.location_id 
AND l.country_id=cou.country_id 
AND cou.region_id=reg.region_id; 


SELECT 
d.department_id, d.department_name, m.manage_id, m.manage_name, l.city,  cou.country_name, reg.region_name 
FROM departments d INNER JOIN manager m on d.manager_id=m.manage_id 
INNER JOIN locations l ON d.location_id=l.location_id
INNER JOIN countries cou ON l.country_id=cou.country_id
INNER JOIN regions reg ON cou.region_id=reg.region_id;


--��������[]
SELECT e.employee_id,
       e.last_name,
       m.employee_id mgr_id,
       m.last_name   mgr_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id(+)
ORDER by e.employee_id;


SELECT e.employee_id,
       e.last_name,
       m.employee_id mgr_id,
       m.last_name   mgr_name
FROM employees e LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER by e.employee_id;


SELECT e.employee_id,
       e.last_name,
       m.employee_id mgr_id,
       m.last_name   mgr_name
FROM employees e Full JOIN employees m ON e.manager_id = m.employee_id(+)
ORDER by e.employee_id;




----------------�ܽ�����
---�ѿ�����
--92
SELECT 
d.department_id, d.department_name, m.manage_id, m.manage_name, l.city, cou.country_name, reg.region_name 
FROM departments d, manager m,locations l,countries cou,regions reg

--99
SELECT 
d.department_id, d.department_name, m.manage_id, m.manage_name, l.city,  cou.country_name, reg.region_name 
FROM departments d CROSS JOIN manager m
CROSS JOIN locations l 
CROSS JOIN countries cou 
CROSS JOIN regions reg;

---������
--92
SELECT 
d.department_id, d.department_name, m.manage_id, m.manage_name, l.city, cou.country_name, reg.region_name 
FROM departments d, manager m,locations l,countries cou,regions reg
WHERE d.manager_id=m.manage_id 
AND d.location_id=l.location_id 
AND l.country_id=cou.country_id 
AND cou.region_id=reg.region_id; 
--99
SELECT 
d.department_id, d.department_name, m.manage_id, m.manage_name, l.city,  cou.country_name, reg.region_name 
FROM departments d INNER JOIN manager m on d.manager_id=m.manage_id 
INNER JOIN locations l ON d.location_id=l.location_id
INNER JOIN countries cou ON l.country_id=cou.country_id
INNER JOIN regions reg ON cou.region_id=reg.region_id;


--ȫ����

SELECT e.employee_id,
       e.last_name,
       m.employee_id mgr_id,
       m.last_name   mgr_name
FROM employees e Full JOIN employees m ON e.manager_id = m.employee_id
ORDER by e.employee_id;

SELECT e.employee_id,
       e.last_name,
       m.employee_id mgr_id,
       m.last_name   mgr_name
FROM employees e Full JOIN employees m ON e.manager_id = m.employee_id(+)
ORDER by e.employee_id;
