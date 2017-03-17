show user;
disc scott;
conn scott;
CREATE TABLE Employee (id number(10), 
                      name varchar(20), 
                      sal number(20), 
                      department varchar(10), 
                      tel number(20),
                      post varchar(10)
                    );
INSERT INTO Employee VALUES(11, '王晓华', 20000, '企训', 15888888888, '副经理');

SELECT * FROM Employee;

DELETE FROM Employee WHERE rowid='1';
INSERT INTO Employee VALUES(11, 'ls', 20000, '企训', 15888888888, '副经理');

SELECT upper(name) FROM Employee;

SELECT COUNT(name) FROM Employee;
INSERT INTO Employee VALUES(11, null, 20000, '企训', 15888888888, '副经理');
SELECT * FROM Employee;
SELECT COUNT(name) FROM Employee;

SELECT CEIL(11.2), CEIL(11.6), MOD(11, 2), MOD(12,3), 
       POWER(10,2), ROUND(11.2453, 3), ROUND(11.3,1), ROUND(11.4) FROM Employee;
SELECT ROUND(11.66, 3) FROM Employee;

INSERT INTO Employee VALUES(11, null, 123, '企训', 15888888888, '副经理');
SELECT AVG(sal) FROM Employee;
SELECT MAX(sal) FROM Employee;
SELECT MIN(sal) FROM Employee;

SELECT CEIL(sal) FROM Employee;
SELECT MOD(sal, 10) FROM Employee;
SELECT POWER(id, 10) FROM Employee;
SELECT SUM(sal) FROM Employee;

SELECT INITCAP('it is true') FROM dual;
SELECT CONCAT('hello', ' world') FROM dual;
SELECT 'hello' ||  ' world' FROM dual;
SELECT SUBSTR('synchronized', 3) FROM dual;
SELECT SUBSTR('synchronized', 3, 5) FROM dual;
SELECT SUBSTR('synchronized', -3, 2) FROM dual;
--截取长度即使超过了长度依然支持截取，大于长度部分截取为空--
SELECT SUBSTR('synchronized', -3, 5) FROM dual;
--查看版本信息--
select * from v$version 

--第一题--
select * FROM Employee;
select * FROM emp;
SELECT empno as "员工编号",
       ename as "员工姓名",
       job as "职位",
       mgr as "雇员的领导编号",
       hiredate as "雇佣日期",
       sal as "月薪",
       comm as "奖金",
       deptno as "部门编号"
       FROM  emp;

SELECT * FROM emp;
SELECT DISTINCT job  FROM emp ORDER BY sal; /*报错，因为前面为选择sal字段，所以不可以order by sal*/
SELECT DISTINCT job  FROM emp ORDER BY job desc; /*这个就正常了*/
SELECT * FROM emp WHERE comm IS NOT NULL; /*不为空*/
SELECT *  FROM emp WHERE (NOT (comm IS NULL)) AND sal>1000 ORDER BY sal;
       
/*第三题*/
CREATE TABLE flower (num varchar(15),
                    name varchar(30),
                    count number(20), 
                    price number(20));
DESC flower;
SELECT * FROM flower;
       
/*第四题*/
CREATE TABLE employees (num varchar(20),
                       name varchar(20),
                       age number(10),
                       sal number(15)
                       );
desc employees; /*不适合查这个语句*/

INSERT TABLE employees VALUES('ox1201', '张三', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '张三', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '张三', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '张三', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '张三', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '张三', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '张三', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '张三', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '张三', 25, 27000);

--第五题--
SELECT * FROM emp;
SELECT '至尊', sal FROM emp WHERE  sal>2000;
SELECT '钻石', sal FROM emp WHERE  sal>2000;
SELECT '白金', sal FROM emp WHERE  sal>2000;
SELECT '黄金', sal FROM emp WHERE  sal>2000;
SELECT '青铜', sal FROM emp WHERE  sal>2000;

SELECT COUNT(*) FROM emp WHERE sal>2000;

SELECT * FROM (SELECT * FROM emp ORDER BY sal DESC) WHERE  rownum<=5;

