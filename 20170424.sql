
-- 注意;is Varray 和 exception when下无end, bulk 中加collect
DECLARE
	TYPE t_numArr is Varray(19) of varchar2(15);
	V_rec t_numArr;
BEGIN
	SELECT name bulk collect into V_rec FROM student;
	V_rec.trim();
	--for in只能遍历存在的东西
	for x in 1 .. V_rec.count loop
		dbms_output.put_line(V_rec(x));
	end loop;
EXCEPTION
	WHEN others THEN
		dbms_output.put_line(sqlcode);
	
END;
--
--张恒
begin
	for x in (select emp.empno, emp.ename from emp) loop
		dbms_output.put_line('empno:' || x.empno || ' ename:' || x.ename);
	end loop;
end;
--

--游标for三种
SELECT * FROM student;

--性能最佳的写法
--while循环不需要带括号，无中括号，用loop,end loop替换
DECLARE
	CURSOR C_col is
		SELECT name FROM student;
	name varchar(15);
BEGIN

	OPEN C_col;
	FETCH C_col
		into name;
	WHILE C_col%found loop
		dbms_output.put_line(name);
		FETCH C_col
			into name;
	end loop;
	CLOSE C_col;

END;

DECLARE
	CURSOR C_col is
		SELECT name, sex FROM student;
	name student.name%TYPE;
	sex  varchar(10);
BEGIN

	OPEN C_col;
	FETCH C_col
		into name, sex;
	WHILE C_col%found loop
		dbms_output.put_line(name || sex);
		FETCH C_col
			into name, sex;
	end loop;
	CLOSE C_col;

END;

DECLARE
	CURSOR C_col is
		SELECT * FROM student;
	V_record student%ROWTYPE;
BEGIN

	OPEN C_col;
	FETCH C_col
		into V_record;
	WHILE C_col%found loop
		dbms_output.put_line(V_record.name || V_record.sex);
		FETCH C_col
			into V_record;
	end loop;
	CLOSE C_col;

END;

--过渡写法
DECLARE
    CURSOR Student_cursor is SELECT * FROM student;
BEGIN
    FOR x in Student_cursor LOOP
        DBMS_OUTPUT.put_line('姓名：' || x.name || ' 性别：'|| x.sex);
    END LOOP;

END;

--最简便写法
BEGIN
    FOR x in (SELECT * FROM student) loop
        dbms_output.put_line('姓名：' || x.name || '性别：' || x.sex);
    end loop;
END;

--over
order by 计算基础
order by 内部为一组的全部计算为一个值
partition by 分区基础(即只计算分区部分，互不干涉) , 跟group by 一样，不过group by 只能选择可以分组的一个值
 
SELECT e.employee_id, e.salary, e.department_id, 
       SUM(salary) OVER(ORDER BY employee_id) ore
FROM employees e;

SELECT e.employee_id, e.salary, e.department_id, 
       SUM(salary) OVER(ORDER BY department_id) ord
FROM employees e;

SELECT e.employee_id, e.salary, e.department_id, 
       SUM(salary) OVER(PARTITION BY department_id) pad
FROM employees e;

SELECT e.employee_id, e.salary, e.department_id, 
       SUM(salary) OVER(PARTITION BY department_id ORDER BY employee_id) padore
FROM employees e;


SELECT 
       e.employee_id, 
       e.salary, 
       e.department_id,
       SUM(salary) OVER(ORDER BY employee_id) ore, 
       SUM(salary) OVER(ORDER BY department_id) ord,
       SUM(salary) OVER(PARTITION BY department_id) pad,
       SUM(salary) OVER(PARTITION BY department_id ORDER BY employee_id) padore

FROM employees e;

SELECT ROW_NUMBER() OVER(ORDER BY department_id) row_number,
       dense_rank() OVER(ORDER BY department_id) dense_rank,
       RANK() OVER(ORDER BY department_id) rank,
       department_id,
       employee_id
FROM employees;


SELECT * FROM emp,（SELECT DISTINCT emp.deptno, 
       MAX(emp.sal) OVER(PARTITION BY emp.deptno) depMaxSal, 
       MIN(emp.sal) OVER(PARTITION BY emp.deptno) depMinSal
FROM emp）maxmin
WHERE emp.deptno = maxmin.deptno AND (emp.sal = maxmin.depMaxSal OR emp.sal = maxmin.depMinSal);



SELECT * FROM emp,（SELECT emp.deptno, 
       MAX(emp.sal) depMaxSal, 
       MIN(emp.sal) depMinSal
FROM emp group by emp.deptno）maxmin
WHERE emp.deptno = maxmin.deptno AND (emp.sal = maxmin.depMaxSal OR emp.sal = maxmin.depMinSal);


--open 游标 for, 注意：open 游标 for后面不可以带括号
CREATE OR REPLACE FUNCTION getMaxMinEmp
RETURN SYS_REFCURSOR
AS 
       RS SYS_REFCURSOR;
BEGIN
       OPEN RS FOR SELECT * FROM emp,（SELECT emp.deptno, 
                                              MAX(emp.sal) depMaxSal, 
                                              MIN(emp.sal) depMinSal
                                     FROM emp group by emp.deptno）maxmin
                 WHERE emp.deptno = maxmin.deptno 
                 AND (emp.sal = maxmin.depMaxSal 
                 OR emp.sal = maxmin.depMinSal);
       RETURN RS;
       
END;
--传递参数全是父引用, AS下不可以分开赋值
CREATE OR REPLACE FUNCTION getMaxMinEmp1(errorInfo OUT varchar)
RETURN SYS_REFCURSOR
AS 
       RS SYS_REFCURSOR;
	   /*aa number(10) --这样是错误的
	   aa:=22;*/
       aa number(10);
BEGIN
       errorInfo:=' ';
       aa:=20/0;
       OPEN RS FOR SELECT * FROM emp,（SELECT emp.deptno, 
                                              MAX(emp.sal) depMaxSal, 
                                              MIN(emp.sal) depMinSal
                                     FROM emp group by emp.deptno）maxmin
                 WHERE emp.deptno = maxmin.deptno 
                 AND (emp.sal = maxmin.depMaxSal 
                 OR emp.sal = maxmin.depMinSal);
       RETURN RS;
EXCEPTION
       WHEN others THEN
            errorInfo:=sqlerrm;
            return null;
END;



--注意：如果无参数传递，函数名后不需要小括号
CREATE OR REPLACE FUNCTION test111(V_err out varchar)
RETURN NUMBER
AS
       
BEGIN
       V_err:='aaaa';
       return 110;
EXCEPTION
       WHEN others then
            V_err:=sqlerrm;
            --dbms_output.put_line(V_err);
            --dbms_output.put_line(sqlerrm);
END;

DECLARE
            aa varchar(100);
BEGIN
     aa := 'asdadsas'||''''||'x'||'''';
     dbms_output.put_line(aa);
End;

SELECT user, 
       systimestamp, 
       system_privilege_map, 
       system, 
       sysoper, 
       sysdba, 
       sysdate, 
       sysaux, FROM dual;

CREATE TABLE emp_his(userName varchar(20), 
             systime varchar(50),
             operation varchar(10), 
             empno number(10), 
             empsal number(10,2), 
             empdepno number(2));
DROP TABLE emp_his;

INSERT INTO  emp_his VALUES(User, systimestamp, 'INSERT', 222, 33.22,20);
SELECT * from emp;
--after后面每个操作必须要加OR
CREATE OR REPLACE TRIGGER userDML
AFTER INSERT OR UPDATE OR DELETE
ON emp
--FOR EACH ROW  不需要，因为用户只可能创建一次
DECLARE
--      V_operation varchar(10);      

BEGIN
    IF INSERTING THEN
       INSERT INTO  emp_his VALUES(User, systimestamp, 'INSERT', new.empno, new.sal, new.deptno);
    ELSIF UPDATING THEN 
       INSERT INTO emp_his VALUES(User, systimestamp, 'UPDATE', new.empno, new.sal,new.deptno);
    ELSIF DELETING THEN    
       INSERT INTO emp_his  VALUES(User, systimestamp, 'DELETE', old.empno, old.sal, old.deptno);
    END IF;

END;


ALTER TABLE student RENAME COLUMN name to xingming;
ALTER TABLE student RENAME COLUMN xingming to name;

