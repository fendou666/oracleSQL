CREATE TABLE student (id number(10), name varchar(20), sex varchar(10));

INSERT INTO student VALUES(1, '小明', '男');
INSERT INTO student VALUES(2, '小亮', '男');
INSERT INTO student VALUES(3, '小红', '女');
INSERT INTO student VALUES(4, '小偶', '女');
INSERT INTO student VALUES(5, '小哈', '女');
INSERT INTO student VALUES(6, '小子', '男');
INSERT INTO student VALUES(7, '小秒', '女');
INSERT INTO student VALUES(8, '小美', '女');
INSERT INTO student VALUES(9, '小逗', '男');
INSERT INTO student VALUES(10, '小醉', '男');

SELECT * FROM student;

SELECT id, name, sex FROM student GROUP BY sex HAVING id>5; --提示不可以运行

SELECT id, name, sex  FROM student GROUP BY id, name, sex HAVING id>5;

SELECT id, name, sex  FROM student GROUP BY id, name, sex;


SELECT id, name, sex  FROM student GROUP BY id, name, sex;


---添加重复
INSERT INTO student VALUES(11, '小偶', '女');
INSERT INTO student VALUES(12, '小哈', '女');
INSERT INTO student VALUES(13, '小子', '男');
INSERT INTO student VALUES(14, '小秒', '女');

SELECT id, name, sex  FROM student GROUP BY id, name, sex;

SELECT id, name, sex  FROM student GROUP BY id, name, sex ORDER BY id;

--分析函数
--OVER
SELECT SUM(salary) OVER() over1 FROM employees;

SELECT SUM(salary) OVER(ORDER BY employee_id) over2 FROM employees;

SELECT SUM(salary) OVER(PARTITION BY departments_id) over3 FROM employees;

SELECT SUM(salary) OVER(ORDER BY departments_id) over4 FROM employees;

SELECT SUM(salary) OVER(PARTITION BY departments_id PARTITION BY employee_id) over5 FROM employees;


--RANK(), ROW_NUM函数

SELECT 
department_id,
ROW_NUMBER() OVER(ORDER BY department_id DESC) row_number, 
DENSE_RANK() OVER(ORDER BY department_id DESC) dense_rank,
RANK() OVER(ORDER BY department_id DESC) rank
FROM employees;

SELECT * FROM employees;

SELECT salary FROM employees WHERE last_name = 'Abel';

SELECT * FROM employees WHERE salary> 11000 ORDER BY salary;

---和101工资一样

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

-- 查询所有不是部门经理的员工

--查询部门经理的员工ID--

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


                      
--多行查询
--in操作， 查询所有不是部门经理的员工

--查询员工人数不少于3人的部门详细信息

--ANY 查询工资大于编号为60部门的所有员工

--ALL 查询工资大于60部门所有员工工资 的所有员工

--相关子查询
SELECT last_name, salary, department_id
FROM employees outer
WHERE salary > (SELECT AVG(salary) 
                FROM employees 
                WHERE department_id = 
                      outer.department_id);


                  
--1.查询员工表中第6到第12条数据  

SELECT rownum FROM employees;
/*SELECT ROW_NUMBER() OVER() as rownum1 FROM employees;*/


SELECT * FROM (SELECT ROWNUM AS "行号", *  FROM employees) WHERE "行号" between 6 and 12;



SELECT * FROM employees, (SELECT ROWNUM AS "行号" FROM employees)  WHERE "行号" between 6 and 12;


2.查询工资最高的第6到第12条员工   
3.查询和149号员工同一个部门的其他员工    
4.查询员工编号，姓名，部门编号，工资，本部门的工资总和                                                                                     
