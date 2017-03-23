CREATE TABLE student (id number(10), name varchar(20), sex varchar(10));

INSERT INTO student VALUES(1, 'С��', '��');
INSERT INTO student VALUES(2, 'С��', '��');
INSERT INTO student VALUES(3, 'С��', 'Ů');
INSERT INTO student VALUES(4, 'Сż', 'Ů');
INSERT INTO student VALUES(5, 'С��', 'Ů');
INSERT INTO student VALUES(6, 'С��', '��');
INSERT INTO student VALUES(7, 'С��', 'Ů');
INSERT INTO student VALUES(8, 'С��', 'Ů');
INSERT INTO student VALUES(9, 'С��', '��');
INSERT INTO student VALUES(10, 'С��', '��');

SELECT * FROM student;

SELECT id, name, sex FROM student GROUP BY sex HAVING id>5; --��ʾ����������

SELECT id, name, sex  FROM student GROUP BY id, name, sex HAVING id>5;

SELECT id, name, sex  FROM student GROUP BY id, name, sex;


SELECT id, name, sex  FROM student GROUP BY id, name, sex;


---�����ظ�
INSERT INTO student VALUES(11, 'Сż', 'Ů');
INSERT INTO student VALUES(12, 'С��', 'Ů');
INSERT INTO student VALUES(13, 'С��', '��');
INSERT INTO student VALUES(14, 'С��', 'Ů');

SELECT id, name, sex  FROM student GROUP BY id, name, sex;

SELECT id, name, sex  FROM student GROUP BY id, name, sex ORDER BY id;

--��������
--OVER
SELECT SUM(salary) OVER() over1 FROM employees;

SELECT SUM(salary) OVER(ORDER BY employee_id) over2 FROM employees;

SELECT SUM(salary) OVER(PARTITION BY department_id) over3 FROM employees;

SELECT SUM(salary) OVER(ORDER BY department_id) over4 FROM employees;

SELECT SUM(salary) OVER(PARTITION BY department_id ORDER BY employee_id) over5 FROM employees;


--RANK(), ROW_NUM����

SELECT 
department_id,
ROW_NUMBER() OVER(ORDER BY department_id DESC) row_number, 
DENSE_RANK() OVER(ORDER BY department_id DESC) dense_rank,
RANK() OVER(ORDER BY department_id DESC) rank
FROM employees;

SELECT * FROM employees;

SELECT salary FROM employees WHERE last_name = 'Abel';

SELECT * FROM employees WHERE salary> 11000 ORDER BY salary;

---��101����һ��

SELECT * FROM employees 
WHERE salary = (SELECT salary FROM employees WHERE employee_id = 101);


SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary)>
       (SELECT MIN(salary)
        FROM employees
        WHERE department_id = 50);

SELECT * FROM employees;

SELECT DISTINCT manager_id  FROM employees;

/*SELECT *
  FROM employees
 WHERE manager_id in (SELECT DISTINCT manager_id FROM employees)
 ORDER BY manager_id;
*/

-- ��ѯ���в��ǲ��ž�����Ա��

--��ѯ���ž�����Ա��ID--

SELECT DISTINCT manager_id FROM employees WHERE manager_id is not null;

SELECT * FROM  employees;

SELECT * FROM employees WHERE employee_id 
not in (SELECT DISTINCT manager_id FROM employees WHERE manager_id is not null);


SELECT e.department_id, e.salary, e.first_name
FROM employees e
WHERE e.salary > (
      SELECT AVG(salary) FROM employees 
      WHERE department_id = e.employee_id;
)


SELECT department_id, salary, first_name
FROM employees outer
WHERE salary > (
      SELECT AVG(salary) FROM employees 
      WHERE department_id = outer.employee_id;
)


                      
--���в�ѯ
--in������ ��ѯ���в��ǲ��ž�����Ա��

--��ѯԱ������������3�˵Ĳ�����ϸ��Ϣ

--ANY ��ѯ���ʴ��ڱ��Ϊ60���ŵ�����Ա��

--ALL ��ѯ���ʴ���60��������Ա������ ������Ա��

--����Ӳ�ѯ
SELECT last_name, salary, department_id
FROM employees outer
WHERE salary > (SELECT AVG(salary) 
                FROM employees 
                WHERE department_id = 
                      outer.department_id);


                  
--1.��ѯԱ�����е�6����12������  

SELECT *
  FROM (SELECT rownum row_num, e.*
          FROM employees e
         WHERE rownum <= 12)
 WHERE row_num >= 6;



2.��ѯ������ߵĵ�6����12��Ա��
SELECT *
  FROM (SELECT rownum row_num, e.*
          FROM (SELECT * FROM employees ORDER BY salary DESC) e
         WHERE rownum <= 12)
 WHERE row_num >= 6;

   
3.��ѯ��149��Ա��ͬһ�����ŵ�����Ա�� 



SELECT * FROM employees WHERE department_id=
(SELECT department_id FROM employees WHERE employee_id=149);

   
4.��ѯԱ����ţ����������ű�ţ����ʣ������ŵĹ����ܺ�                                                                                     
SELECT e.employee_id,
       e.last_name,
       e.department_id,
       e.salary,
       SUM(e.salary) OVER(ORDER BY department_id)
  FROM employees e;

SELECT * FROM student;

CREATE TABLE new_stu as SELECT * FROM student;

SELECT * FROM new_stu;

UPDATE student SET name='����' WHERE id=1;

UPDATE new_stu SET name='����COPY' WHERE id=1;

UPDATE new_stu SET name='ALLCHANGE';

CREATE TABLE new_stu1 AS SELECT * FROM student;

SELECT * FROM new_stu1;

UPDATE new_stu1 SET name='С����';

SELECT employee_id, last_name, manager_id FROM employees 
START WITH employee_id=206
connect by prior manager_id=employee_id;

SELECT * FROM employees 
START WITH employee_id=206
connect by prior manager_id=employee_id;



SELECT LEVEL, e.* FROM employees e
START WITH employee_id=206
connect by prior manager_id=employee_id;

--��������α��
SELECT LEVEL, ROWNUM, ROWID, e.* FROM employees e
START WITH employee_id=206
connect by prior manager_id=employee_id;

SELECT LEVEL, ROWNUM, ROWID FROM employees
START WITH employee_id=206
connect by prior manager_id=employee_id;

SELECT LEVEL, employee_id, last_name, manager_id  
FROM employees
connect by prior manager_id=employee_id;

SELECT LEVEL, employee_id, last_name, manager_id  
FROM employees
connect by prior manager_id=employee_id ORDER BY LEVEL DESC;


SELECT LEVEL, employee_id, last_name, manager_id  
FROM employees
START WITH  employee_id=101
connect by prior manager_id=employee_id ORDER BY LEVEL DESC;


CREATE TABLE test as SELECT * FROM employees;

SELECT * FROM test;

DELETE FROM test WHERE department_id = 
(SELECT department_id FROM departments WHERE department_name = 'IT');