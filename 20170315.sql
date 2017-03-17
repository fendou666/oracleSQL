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
INSERT INTO Employee VALUES(11, '������', 20000, '��ѵ', 15888888888, '������');

SELECT * FROM Employee;

DELETE FROM Employee WHERE rowid='1';
INSERT INTO Employee VALUES(11, 'ls', 20000, '��ѵ', 15888888888, '������');

SELECT upper(name) FROM Employee;

SELECT COUNT(name) FROM Employee;
INSERT INTO Employee VALUES(11, null, 20000, '��ѵ', 15888888888, '������');
SELECT * FROM Employee;
SELECT COUNT(name) FROM Employee;

SELECT CEIL(11.2), CEIL(11.6), MOD(11, 2), MOD(12,3), 
       POWER(10,2), ROUND(11.2453, 3), ROUND(11.3,1), ROUND(11.4) FROM Employee;
SELECT ROUND(11.66, 3) FROM Employee;

INSERT INTO Employee VALUES(11, null, 123, '��ѵ', 15888888888, '������');
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
--��ȡ���ȼ�ʹ�����˳�����Ȼ֧�ֽ�ȡ�����ڳ��Ȳ��ֽ�ȡΪ��--
SELECT SUBSTR('synchronized', -3, 5) FROM dual;
--�鿴�汾��Ϣ--
select * from v$version 

--��һ��--
select * FROM Employee;
select * FROM emp;
SELECT empno as "Ա�����",
       ename as "Ա������",
       job as "ְλ",
       mgr as "��Ա���쵼���",
       hiredate as "��Ӷ����",
       sal as "��н",
       comm as "����",
       deptno as "���ű��"
       FROM  emp;

ALTER TABLE emp RENAME COLUMN empno TO "Ա�����"; 
SELECT * FROM emp;
ALTER TABLE emp RENAME COLUMN "Ա�����" TO empno; 

SELECT * FROM emp;
SELECT DISTINCT job  FROM emp ORDER BY sal; /*������Ϊǰ��Ϊѡ��sal�ֶΣ����Բ�����order by sal*/
SELECT DISTINCT job  FROM emp ORDER BY job desc; /*�����������*/
SELECT * FROM emp WHERE comm IS NOT NULL; /*��Ϊ��*/
SELECT *  FROM emp WHERE (NOT (comm IS NULL)) AND sal>1000 ORDER BY sal;
       
/*������*/
CREATE TABLE flower (num varchar(15),
                    name varchar(30),
                    count number(20), 
                    price number(20));
DESC flower;
SELECT * FROM flower;
       
/*������*/
CREATE TABLE employees (num varchar(20),
                       name varchar(20),
                       age number(10),
                       sal number(15)
                       );
desc employees; /*���ʺϲ�������*/

INSERT TABLE employees VALUES('ox1201', '����', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '����', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '����', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '����', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '����', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '����', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '����', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '����', 25, 27000);
INSERT TABLE employees VALUES('ox1201', '����', 25, 27000);

--������--
SELECT * FROM emp;
SELECT '����', sal FROM emp WHERE  sal>2000;
SELECT '��ʯ', sal FROM emp WHERE  sal>2000;
SELECT '�׽�', sal FROM emp WHERE  sal>2000;
SELECT '�ƽ�', sal FROM emp WHERE  sal>2000;
SELECT '��ͭ', sal FROM emp WHERE  sal>2000;

SELECT COUNT(*) FROM emp WHERE sal>2000;

SELECT * FROM (SELECT * FROM emp ORDER BY sal DESC) WHERE  rownum<=5;

SELECT 
       CASE
         WHEN sal > 5000 THEN
          '����'
         WHEN sal > 4000 THEN
          '��ʯ'
         WHEN sal > 3000 THEN
          '�׽�'
         WHEN sal > 2000 THEN
          '�ƽ�'
         WHEN sal > 1000 THEN
          '��ͭ'
         ELSE
          '�޵ȼ�'
       END AS �ȼ�
       FROM emp;
                     

