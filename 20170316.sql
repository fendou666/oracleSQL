SELECT * FROM emp;
--DECODE表达式--
SELECT ename, DECODE(deptno, 10,'ASP', 20,'国际事务部', 30, 'ATEAM') as 等级 FROM emp;

--CASE表达式--

SELECT ename, 
       CASE deptno
       when 10 THEN 'ASP'
       WHEN 20 THEN '国际事务部'
       WHEN 30 THEN 'ATEAM'
       end as 等级
       FROM emp;     
              
DROP TABLE  flower;



SELECT * FRoM Employees;
SELECT  e.employee_id, d.department_id, d.department_name FROM employees e, departments d;

SELECT * FROM employees;

SELECT   
        e.employee_id, e.first_name, 
        d.department_id, d.department_name,
        j.job_id, j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id=d.department_id and e.job_id = j.job_id and e.department_id= d.department_id;

SELECT * FROM employees;

CREATE TABLE MANAGER (MANAGE_ID Number(6),
                     MANAGE_NAME VARCHAR(20)
                     );
                    
 
INSERT INTO  MANAGER VALUES(101, '张三');
INSERT INTO  MANAGER VALUES(102, '王五');
INSERT INTO  MANAGER VALUES(700, '王晓华');
INSERT INTO  MANAGER VALUES(103, '张震');

SELECT * FROM manager;

SELECT e.manager_id, e.first_name, m.manage_id, m.manage_name
FROM employees e, manager m;

SELECT e.manager_id, e.first_name, m.manage_id, m.manage_name
FROM employees e, manager m
WHERE e.manager_id(+) = m.manage_id(+);



SELECT e.manager_id, e.first_name, m.manage_id, m.manage_name
FROM employees e, manager m
WHERE e.manager_id = m.manage_id;

SELECT e.manager_id, e.first_name, m.manage_id, m.manage_name
FROM employees e, manager m
WHERE e.manager_id(+) = m.manage_id;

SELECT * FROM employees;



--1.查询员工编号，姓名，部门编号,部门名称（表别名）
SELECT 
e.employee_id, e.first_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--2.查询员工编号，姓名，部门编号,部门名称，职务编号，职务名称
SELECT 
e.employee_id, e.first_name, 
d.department_id, d.department_name, 
j.job_id, j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id and e.job_id = j.job_id;

--3.查询所有部门的编号，部门名称，部门经理ID，部门经理姓名，部门所在的城市，国家，地区
SELECT * FROM employees;
SELECT * FROM DEPT;
SELECT * FROM departments;
SELECT * FROM manager;
/*DELETE FROM manager;
INSERT INTO manager VALUES(100, '张三');
INSERT INTO manager VALUES(101, '王五');
INSERT INTO manager VALUES(103, '王晓华');
INSERT INTO manager VALUES(200, '窦材宁');
INSERT INTO manager VALUES(201, '康迈翔');
INSERT INTO manager VALUES(205, '费效霏');
INSERT INTO manager VALUES(124, '田信品');
INSERT INTO manager VALUES(149, '祝越潇');
INSERT INTO manager VALUES(123, '翁锦宏');
INSERT INTO manager VALUES(147, '费自鸣');
INSERT INTO manager VALUES(207, '宗义庚');*/

SELECT * FROM locations;
SELECT 
d.department_id, d.department_name, m.manage_id, m.manage_name, l.city, l.country_id, l.state_province
FROM departments d, manager m,locations l
WHERE d.manager_id = m.manage_id AND d.location_id = l.location_id; 


SELECT * FROM locations;
SELECT 
d.department_id, d.department_name, m.manage_id, m.manage_name, l.city, l.country_id, l.state_province
FROM departments d, manager m,locations l, countries
WHERE d.manager_id = m.manage_id AND d.location_id = l.location_id; 




--4.查看员工职务变更历史记录：员工编号，姓名，起始日期，终止日期，职务名称，部门名称
SELECT * FROM job_history;

SELECT 
e.employee_id, e.first_name, 
jh.start_date, jh.end_date, 
j.job_title, d.department_name
FROM  employees e, job_history jh, jobs j, departments d
WHERE e.employee_id = jh.employee_id AND jh.job_id = j.job_id AND jh.department_id = d.department_id


--5.查询每个员工编号，姓名，工资，工资级别（非等值连接）
SELECT * FROM employees;
SELECT * FROM SALGRADE;
SELECT 
e.employee_id, e.first_name, e.salary, salG.Grade
FROM employees e, salgrade salG
WHERE e.salary between salG.Losal AND salG.Hisal;


--6.查询员工编号，姓名，工资，奖金金额，实发工资（工资+奖金）
SELECT * FROM employees;
SELECT * FROM bonus;
SELECT * FROM emp;

SELECT 
e.employee_id, e.first_name, e.salary, e.salary*nvl(e.commission_pct,0), e.salary*(1+ nvl(e.commission_pct,0)) relSal 
FROM employees e


--7.查询10号，20号和没有部门的员工(不用is null is not null实现)
SELECT * FROM jobs;
SELECT * FROM job_history;
SELECT * FROM regions;
SELECT * FROM countries;
SELECT * FROM employees;

SELECT * FROM employees e WHERE decode(e.date, 10, 1, 20, 1, 0) == 0 || not coalesece(e.department_id); 

SELECT * FROM employees e 
WHERE decode(e.department_id, 100, -1, 200, -1, 0) = -1
OR nvl(e.department_id, -10)<0;

SELECT * FROM employees e 
WHERE decode(e.department_id, 100, -1, 200, -1, 0) < 0;


SELECT * FROM employees e 
WHERE e.employee_id = 100 
OR e.employee_id = 200 
OR nvl(e.department_id, -10)<0;

SELECT * FROM employees e WHERE  nvl(e.department_id, -10)<0;
SELECT * FROM employees e WHERE  nullif(e.department_id, null) IS  NULL;
SELECT * FROM employees e WHERE  decode(e.department_id, null, -10, 0) ;


select e.employee_id, decode(e.employee_id, 100, -1,0) from employees e;
  
select e.employee_id from employees e where  decode(e.employee_id, 100, -1, 200,-1, 0)<0;
  
select e.employee_id from employees e where  decode(e.employee_id, 100, -1, 200,-1, 0) OR decode(e.department_id, null, -1, 0)<0;
  
select e.employee_id from employees e where  e.employee_id in(100, 200);

select e.employee_id from employees e where  e.department_id in(null);

