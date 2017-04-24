
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

SELECT  MAX(emp.sal) FROM emp GROUP BY emp.deptno; 

SELECT * FROM emp;

CREATE OR REPLACE FUNCTION (
    
)
RETURN SYS_REFCURSOR
IS 


BEGIN

END;
