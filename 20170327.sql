--单行查询
SELECT * FROM employees;
DECLARE
  e employees%ROWTYPE;
  V_sql varchar(2000);

BEGIN
  V_sql := 'SELECT * FROM employees WHERE employee_id=: empid';
  EXECUTE IMMEDIATE V_sql INTO e USING 205;
  dbms_output.put_line('员工姓名：' || e.last_name);

END;


--多行查询
DECLARE
  e employees%ROWTYPE;
  V_sql varchar(2000);
  Emp_cursor sys_refcursor;

BEGIN
  V_sql := 'SELECT * FROM employees WHERE department_id=: empid';
  OPEN Emp_cursor FOR V_sql USING 50;
  LOOP
       FETCH Emp_cursor INTO e;
       EXIT WHEN Emp_cursor%NOTFOUND;
       dbms_output.put_line('员工ID：' || e.employee_id || '员工姓名：' || e.last_name);
  
  END LOOP;

END;

--多行查询使用FOR游标

DECLARE
  e employees%ROWTYPE;
  V_sql varchar(2000);
  Emp_cursor sys_refcursor;

BEGIN
  V_sql := 'SELECT * FROM employees WHERE department_id=: empid';
  FOR e IN (OPEN Emp_cursor FOR V_sql USING 50) LOOP
     dbms_output.put_line('员工ID：' || e.employee_id || '员工姓名：' || e.last_name);
  
  END LOOP;
  
  
  
/*  OPEN Emp_cursor FOR V_sql USING 50;
  LOOP
       FETCH Emp_cursor INTO e;
       EXIT WHEN Emp_cursor%NOTFOUND;
       dbms_output.put_line('员工ID：' || e.employee_id || '员工姓名：' || e.last_name);
  
  END LOOP;*/

END;

--使用bulk collect into
--查询部门编号为90的员工信息
SELECT * FROM employees WHERE department_id=90;
DECLARE
         V_id number:=90;
         V_sql varchar(1000):='SELECT * FROM employees WHERE department_id=:v_id';
         TYPE Emp_table_type IS TABLE OF employees%ROWTYPE;
         Emp_table Emp_table_type;
BEGIN
         EXECUTE IMMEDIATE V_sql BULK COLLECT INTO Emp_table USING V_id;
         
         dbms_output.put_line(Emp_table.count);
         FOR i IN 1..Emp_table.count LOOP
             dbms_output.put_line(Emp_table(i).employee_id || Emp_table(i).last_name);
         END LOOP;
END;
--更新对部门为90号的员工工资加加
DECLARE
         V_salAdd employees.salary%TYPE:=50;
         V_did employees.department_id%TYPE:=90;
         
         TYPE Emp_table_type IS TABLE OF employees%ROWTYPE;
         Emp_table Emp_table_type;
         V_sql varchar(2000):='update employees set salary = salary + :V_salAdd 
         WHERE department_id=:V_did RETURNING * INTO :Emp_table';
         
         
         
BEGIN
         EXECUTE IMMEDIATE V_sql USING V_salAdd, V_did RETURNING BULK COLLECT INTO Emp_table;
         dbms_output.put_line(Emp_table.count);
END;





--使用动态执行PLSQL

DECLARE 

         V_sql varchar(1000):='
         declare
               V_id number:=:v_id;
         begin
               dbms_output.put_line(V_id);
         end;
         
         ';

BEGIN
         EXECUTE IMMEDIATE V_sql USING 22;
         
END;



--可否实现呢
DECLARE
         V_sqlMain varchar(2000):='
         declare 
                 V_id number:=:v_id; 
                 TYPE Emp_table_type IS TABLE OF employees%ROWTYPE;
                 Emp_table Emp_table_type;
                 V_sql varchar(1000):=''SELECT * FROM employees WHERE department_id=:v_id'';
         begin
                 EXECUTE IMMEDIATE V_sql BULK COLLECT INTO Emp_table USING V_id;
         
                 dbms_output.put_line(Emp_table.count);
                 FOR i IN 1..Emp_table.count LOOP
                     dbms_output.put_line(Emp_table(i).employee_id || Emp_table(i).last_name);
                 END LOOP;
         end;
         ';
         
         
         /*V_sqlMain varchar(1000):='SELECT * FROM employees WHERE department_id=:v_id';*/
         
BEGIN
         EXECUTE IMMEDIATE V_sql USING V_id; 
END;

--dbms_sql包
DROP TABLE AAA;
DECLARE
         c Integer;
         V_sql varchar(2000):='CREATE TABLE AAA(id number(20), name varchar(20))';

BEGIN
  
         c:=dbms_sql.open_cursor;
         ---必须是=>不可以为>=
         dbms_sql.parse(c=>c,statement=>V_sql,language_flag=>dbms_sql.native);
         dbms_sql.close_cursor(c=>c);

END;
---测试=>与>=
DECLARE
         c Integer;
         V_sql varchar(2000):='CREATE TABLE AAA(id number(20), name varchar(20))';

BEGIN
  
         c:=dbms_sql.open_cursor;
         dbms_sql.parse(c>=c,statement>=V_sql,language_flag>=dbms_sql.native);
         dbms_sql.close_cursor(c>=c);

END;

--测试only  c  是因为只有单行数据吗，所以执行成功
DECLARE
         c Integer;
         V_sql varchar(2000):='CREATE TABLE AAA(id number(20), name varchar(20))';

BEGIN
  
         c:=dbms_sql.open_cursor;
         dbms_sql.parse(c,V_sql,dbms_sql.native);
         dbms_sql.close_cursor(c);
END;



--更新数据
DECLARE
         c INTEGER;
         V_sql varchar(2000):='UPDATE employees SET salary=salary+500 WHERE department_id=50';
         r INTEGER;
BEGIN
         c:=dbms_sql.open_cursor;
         dbms_sql.parse(c=>c, statement=>V_sql,language_flag=>dbms_sql.native);
         r:=dbms_sql.execute(c=>c);
         dbms_sql.close_cursor(c=>c);
         dbms_output.put_line('更新了' || r || '行数据');
END;

SELECT * FROM employees WHERE department_id=50;


select * from employees where employee_id = 100;
---异常
DECLARE
       --预定义异常NO_DATA_FOUND
       --非预定义异常
       my_e EXCEPTION;
       PRAGMA EXCEPTION_INIT(my_e,-2292);
       --自定义异常
       myexp EXCEPTION;
       
       
       V_vlue employees%ROWTYPE;
       V_sal employees.salary%TYPE;
BEGIN
       /*SELECT * INTO V_vlue FROM employees WHERE employee_id=1;*/
       /*DELETE FROM employees WHERE employee_id=100;*/
       SELECT salary INTO V_sal FROM employees WHERE employee_id=100;
       IF V_sal>10000 THEN
          RAISE myexp;
          RAISE_APPLICATION_ERROR(-20001, '自定义异常信息包含错误号的异常');
       END IF;

EXCEPTION
       WHEN NO_DATA_FOUND THEN
            dbms_output.put_line(sqlcode || sqlerrm);
            dbms_output.put_line('触发预定义异常，员工没有编号为1的员工');
       WHEN my_e THEN
            dbms_output.put_line(sqlcode || sqlerrm);
            dbms_output.put_line('触发非预定义异常，触发表完整性异常');
       WHEN myexp THEN
            /*dbms_output.put_line(sqlcode || sqlerrm);
            dbms_output.put_line('触发自定义异常，工资超过10000触发异常');*/
       WHEN OTHERS THEN
            dbms_output.put_line(sqlcode || sqlerrm);
            dbms_output.put_line('others 异常(一般自定义带错误号的在这里处理，只需要打出错误号和错误信息)，如果需要处理，看以上3种进行选择');

END;

--异常块覆盖
DECLARE
  
BEGIN
       RAISE_APPLICATION_ERROR(-20001, '外部异常');
EXCEPTION
       WHEN OTHERS THEN
            BEGIN
                   RAISE_APPLICATION_ERROR(-20002, '中部异常');
            EXCEPTION
                   WHEN OTHERS THEN
                       BEGIN
                               RAISE_APPLICATION_ERROR(-20003, '内部异常');
                       EXCEPTION
                               WHEN OTHERS THEN
                                    dbms_output.put_line(sqlerrm);  
                       END;
            
            END;

END;

DECLARE
  
BEGIN
       RAISE_APPLICATION_ERROR(-20001, '外部异常');
EXCEPTION
       WHEN OTHERS THEN
            BEGIN
                   RAISE_APPLICATION_ERROR(-20002, '中部异常');
            EXCEPTION
                   WHEN OTHERS THEN
                       BEGIN
                               RAISE_APPLICATION_ERROR(-20003, '内部异常', true);
                       EXCEPTION
                               WHEN OTHERS THEN
                                    dbms_output.put_line(sqlerrm);  
                       END;
            
            END;

END;

DECLARE
  
BEGIN
       RAISE_APPLICATION_ERROR(-20001, '外部异常');
EXCEPTION
       WHEN OTHERS THEN
            BEGIN
                   RAISE_APPLICATION_ERROR(-20002, '中部异常', TRUE);
            EXCEPTION
                   WHEN OTHERS THEN
                       BEGIN
                               RAISE_APPLICATION_ERROR(-20003, '内部异常', true);
                       EXCEPTION
                               WHEN OTHERS THEN
                                    dbms_output.put_line(sqlerrm);  
                       END;
            
            END;

END;


--异常传播

--学生信息为10
CREATE OR REPLACE FUNCTION get_stu_info1(p_stuid number, info out sys_refcursor)
RETURN number
AS
       
BEGIN
       open info for SELECT * FROM student WHERE id=p_stuid; 
       return -1;
END;

DECLARE
       v_num number(10);
       info sys_refcursor;
BEGIN
       dbms_output.put_line(get_stu_info1(10,info));
       dbms_output.put_line();
       CLOSE info;
END;





--1.获取某部门的工资总和（函数），若员工不存在显示‘你要找的数据不存在’；


CREATE OR REPLACE FUNCTION get_sal(p_dpid  number)
RETURN varchar2
AS
       V_sum_sal employees.salary%TYPE;
BEGIN
       SELECT sum(salary) INTO V_sum_sal FROM employees WHERE department_id = p_dpid;
       /*IF V_sum_sal==null THEN
          RAISE_APPLICATION_ERROR(-20001, '你要找的数据不存在');
       END IF;*/
       IF V_sum_sal>0 THEN
          RETURN V_sum_sal;
       ELSE
          RAISE_APPLICATION_ERROR(-20001, '你要找的数据不存在');
       END IF;
       
       
EXCEPTION
       WHEN OTHERS THEN
            RETURN sqlerrm;  
END;

BEGIN
  
      dbms_output.put_line(get_sal(50));  
      dbms_output.put_line(get_sal(1000));          
END;



--2.把第一个题用三种参数传递格式分别进行实现；

CREATE OR REPLACE PROCEDURE get_sal2(p_dpid  number, p_sal out varchar2)
AS
       V_sum_sal employees.salary%TYPE;
BEGIN
       SELECT sum(salary) INTO V_sum_sal FROM employees WHERE department_id = p_dpid;
       IF V_sum_sal>0 THEN
          p_sal:= V_sum_sal;
       ELSE
          RAISE_APPLICATION_ERROR(-20001, '你要找的数据不存在');
       END IF;
EXCEPTION
       WHEN OTHERS THEN
            p_sal:= sqlerrm;
END;


DECLARE
       V_sal varchar2(200);
       p_dpid employees.department_id%TYPE;
BEGIN 
       get_sal2(50,V_sal);
       dbms_output.put_line(V_sal);
       get_sal2(p_dpid=>1000, p_sal=>V_sal);
       dbms_output.put_line(V_sal);
       get_sal2(50, p_sal=>V_sal);
       dbms_output.put_line(V_sal);
END;
/*50,V_sal
p_dpid=>50, p_sal=>V_sal
50, p_sal=>V_sal
p_dpid=>50, V_sal*/

--3.使用存储过程向departments表中插入数据；
select * from departments;
CREATE OR REPLACE PROCEDURE de_insert(p_did departments.department_id%TYPE,
                                      p_name departments.department_name%TYPE,
                                      p_mngid departments.manager_id%TYPE,
                                      p_lctid departments.location_id%TYPE
                                      )
AS

BEGIN
      INSERT INTO departments(department_id, department_name, manager_id, location_id) 
      VALUES(p_did, p_name, p_mngid, p_lctid);
      commit;  
END;

BEGIN
  ---关于location不对的话如何做
      de_insert(111,'测试部门',222,1400);
END;
INSERT INTO departments VALUES(111,'测试部门',222,333);

--4.计算制定部门的工资总和，并统计其中的职工数量

CREATE OR REPLACE FUNCTION get_emp_count_sal(p_did number, p_count out number)
RETURN number
AS

       V_sumsal employees.salary%TYPE;
BEGIN
       SELECT SUM(salary), count(*) INTO V_sumsal, p_count FROM employees 
       WHERE department_id=p_did;
       RETURN V_sumsal;
END;

DECLARE
       V_sumsal employees.salary%TYPE;
       V_count number(10);

BEGIN
       dbms_output.put_line('总工资为' || get_emp_count_sal(50,V_count));
       dbms_output.put_line('员工总数为'||V_count);
END;







