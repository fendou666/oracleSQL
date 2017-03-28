--简单的函数
CREATE OR REPLACE FUNCTION test1
RETURN number
IS
       --声明变量
       V_num1 number(10):=1;
       V_num2 number(10):=2;
BEGIN
       RETURN V_num1 + V_num2;

END;


DECLARE

BEGIN
       dbms_output.put_line(test1);
END;


--in/out/int out
CREATE OR REPLACE FUNCTION allTest(V_num1 number,V_num2 number, 
                                  V_rst2 in out number, V_rst3 out number)
RETURN number
AS
--声明变量
       V_rst1 number(10);
       V_num3 number(10):=V_rst2;
BEGIN
       V_rst1:=V_num1+V_num2;
       V_rst2:=V_num1+V_num2+V_num3;
       V_rst3:=V_num1+V_num2-V_num3;
       RETURN V_rst1;
END;

DECLARE
       V_result1 number(10);
       V_result2 number(10):=1;
       V_result3 number(10);
BEGIN
       dbms_output.put_line(allTest(3,2,V_result2,V_result3));
       dbms_output.put_line(V_result2);
       dbms_output.put_line(V_result3);
END;


--传参位置

CREATE OR REPLACE FUNCTION test2(V_num1 in number default 10, V_num2 in number default 2)
RETURN number
IS
       --声明变量

       V_rst number(10);
BEGIN
       V_rst:= V_num1 + V_num2;
       RETURN V_rst;

END;
---设为default的值可以不传参
DECLARE

BEGIN
       dbms_output.put_line(test2());
END;

--名称表示法
DECLARE
       V_aa number(10);  
BEGIN
       dbms_output.put_line(test2(V_num1=>V_aa));
END;


--输入一个部门编号，返回部门所有员工的姓名拼接的字符串
CREATE OR REPLACE FUNCTION get_name(V_dpmid employees.department_id%TYPE)
RETURN varchar2
AS
          V_name varchar2(2000);
          CURSOR emp_cursor IS SELECT last_name FROM employees WHERE department_id=V_dpmid;
BEGIN
          FOR e in emp_cursor LOOP
              V_name:=V_name || ',' || e.last_name;   
          END LOOP;  
          return trim(',' FROM V_name);
END;


--测试
BEGIN
          dbms_output.put_line(get_name(50));

END;


---测试number(10)
CREATE OR REPLACE FUNCTION test3(V_num1 number, V_num2 number)
RETURN number
AS
       V_rst number(10);

BEGIN
       V_rst:=V_num1+V_num2;
       RETURN V_rst;
END;

---测试
BEGIN
       dbms_output.put_line(test3(22,33));
END;

--输入一个部门编号，返回所有员工信息，返回游标变量
CREATE OR REPLACE FUNCTION get_emp_info(V_did employees.department_id%TYPE)
RETURN number
AS
       TYPE emp_table_type IS TABLE OF employees%ROWTYPE;
       CURSOR emp_cursor IS SELECT * FROM employees WHERE department_id = V_did;
BEGIN
       FETCH emp_cursor BULK COLLECT INTO emp_table_type;
       RETURN emp_table_type;
END;


DECLARE

       TYPE emp_table_type IS TABLE OF employees%ROWTYPE;
       CURSOR emp_cursor IS SELECT * FROM employees WHERE department_id = ;
BEGIN
       FETCH emp_cursor BULK COLLECT INTO emp_table_type;
       dbms_output.put_line(emp_cursor%ROWCOUNT);
END;


--添加调试授权
GRANT DEBUG CONNECT SESSION TO scott;



























