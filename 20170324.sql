
SELECT * FROM emp;
DECLARE 
/*TYPE Emp_table_type IS TABLE OF emp%ROWTYPE INDEX BY BINARY_INTEGER;
EmpDate Emp_table_type;*/

CURSOR Emp_cursor IS SELECT * FROM emp WHERE empno=;
BEGIN
  null;
  if Emp_cursor%ISOPEN THEN
     dbms_output.put_line('游标状态是打开的');
  ELSE
     dbms_output.put_line('游标状态是未打开');
  END IF;
  
  if Emp_cursor%FOUND THEN
     dbms_output.put_line('游标状态已经指向数据');
  ELSE
     dbms_output.put_line('游标状态未指向数据');
  END IF;
  
  OPEN Emp_cursor;
  
  FETCH Emp_cursor BULK COLLECT INTO EmpDate;
  dbms_output.put_line(Emp_cursor%ROWCOUNT);
 
END;

--游标
--直接变量
--复合数据类型（多个表列）
--参照引用表行
--复合数据类型表（表行）
--游标属性
--普通for
--游标参数
--普通for
--游标for

DECLARE
  V_ename emp.ename%TYPE:=7396;
  V_empno emp.empno%TYPE;
  --声明游标
  CURSOR Emp_cursor IS SELECT empno,ename FROM emp WHERE deptno=20;
BEGIN
  --打开游标
  OPEN Emp_cursor;
  dbms_output.put_line('****************************');
  --提取游标，每次提取后，游标指针下移，直到最后 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('员工编号：' || V_empno || '  员工姓名：' || V_ename); 
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('员工编号：' || V_empno || '  员工姓名：' || V_ename);
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('员工编号：' || V_empno || '  员工姓名：' || V_ename);
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('员工编号：' || V_empno || '  员工姓名：' || V_ename);
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('员工编号：' || V_empno || '  员工姓名：' || V_ename);
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('员工编号：' || V_empno || '  员工姓名：' || V_ename);
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('员工编号：' || V_empno || '  员工姓名：' || V_ename);
  
  CLOSE Emp_cursor;
END;

--引入游标属性

--%ISOPEN, %NOTFOUND, %FOUND, %ROWCOUNT
DECLARE
  V_ename emp.ename%TYPE:=7396;
  V_empno emp.empno%TYPE;
  --声明游标
  CURSOR Emp_cursor IS SELECT empno,ename FROM emp WHERE deptno=20;
BEGIN
  --打开游标
  IF Emp_cursor%ISOPEN THEN
     dbms_output.put_line('游标没打开');
  ELSE
     dbms_output.put_line('游标已打开');
  END IF;
  OPEN Emp_cursor;
   --游标当前是找到了值，还是没找到（即指向原来的位置）                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
  IF Emp_cursor%FOUND THEN
     dbms_output.put_line('游标当前状态');
  END IF;
  
  dbms_output.put_line('****************************');
  --提取游标，每次提取后，游标指针下移，直到最后 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('员工编号：' || V_empno || '  员工姓名：' || V_ename); 
 
  
  
  CLOSE Emp_cursor;
END;


--
SELECT * FROM student;

DECLARE
       CURSOR stu_cursor IS SELECT * FROM student FOR UPDATE;
BEGIN
       FOR s in stu_cursor LOOP
           IF s.id = 4 THEN
             DELETE FROM student WHERE CURRENT OF stu_cursor;
           END IF;
                                                             
       END LOOP;

END;



---SQL语句
SELECT to_date('2017-3-24 15:30:00', 'YYYY-MM-DD HH24:MI:SS') FROM user_objects;
SELECT to_date('2017-3-24 15:30:00', 'YYYY-BB-CC DD24:EE:FF') FROM user_objects;
SELECT to_date('2017-3-24 15:30:00', 'YYYY-MM-DD HH24:mm:ss') FROM user_objects;
DECLARE
       v_sql varchar(1000);
       CURSOR C_cursor IS SELECT object_name FROM user_objects WHERE object_type = 'TABLE' 
       AND created >=
       to_date('2017-3-24 15:30:00', 'YYYY-MM-DD HH24:MI:SS');
/*       CURSOR C_cursor IS SELECT object_name FROM user_objects WHERE object_type = 'TABLE';*/

BEGIN
       /*FOR c IN c_cursor LOOP
          dbms_output.put_line(c.object_name);
       END LOOP;*/
       
       FOR c IN c_cursor LOOP
           v_sql:='DROP TABLE ' || c.object_name;
           dbms_output.put_line(v_sql);
           EXECUTE IMMEDIATE v_sql;
       END LOOP;
END;


DECLARE
       v_sql varchar2(1000);
BEGIN
       FOR i IN 1..10 LOOP
           v_sql:='CREATE TABLE tb' || i || '  as SELECT * FROM emp';
           dbms_output.put_line(v_sql);
           EXECUTE IMMEDIATE v_sql;
       END LOOP;
END;







