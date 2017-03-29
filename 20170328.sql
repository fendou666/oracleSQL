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



--1.获取某部门的工资总和（函数），若员工不存在显示‘你要找的数据不存在’；
create or replace function get_add(p_did number) return number
is
v_sum number;
v_sql varchar2(1000);
begin
  v_sql:='select sum(salary) from employees where department_id='||p_did;
  execute immediate v_sql into v_sum;
  if(v_sum is null) then
  dbms_output.put_line('你要找的数据不存在');
  end if;
  return v_sum;
  end;
  begin
    dbms_output.put_line(get_add(&input));
    end;
2.把第一个题用三种参数传递格式分别进行实现；
--default默认值
create or replace function get_result8(p_did number default 50) return number
as 
 v_sum number;
 begin
   select sum(salary)
    into v_sum
    from employees
   where department_id = p_did;
  return v_sum;
   end;
   
   begin
     dbms_output.put_line(get_result8());
     end;
-- 名称命名法
create or replace function get_result9(p_did  number,v_resut number) return number
as 
 v_result number;
 begin
   select sum(salary)
    into v_result
    from employees
   where department_id = p_did;
  return v_result;
   end;
   
   declare
   v_result1 number(34);
   begin
     dbms_output.put_line(get_result9(p_did=>50,v_resut=>v_result1));
     end;     
--混合表示法
create or replace function get_result10(p_did  number default 50,v_resut number) return number as
v_result number;
begin
   select sum(salary)
    into v_result
    from employees
   where department_id = p_did;
  return v_result;
end;

declare
  v_result1 number(34);
  begin
    dbms_output.put_line(get_result10(v_resut=>v_result1));
    dbms_output.put_line(v_result1);
  end;   
--3.使用存储过程向departments表中插入数据；
select * from departments;
create or replace procedure procedure_name(p_did departments.department_id%type,p_name departments.department_name%type,
p_manager departments.manager_id%type,d_loc departments.location_id%type)
as 
begin
  insert into departments values(p_did,p_name,p_manager,d_loc);
  end;
begin 
  procedure_name(30,'小明',107,1800);
  end;
--4.计算制定部门的工资总和，并统计其中的职工数量
create or replace function get_result11(p_did departments.department_id%type,v_count out number) return number as
v_sum number;
v_sql varchar(1000);
begin
      select sum(salary),count(*) into v_sum,v_count from employees where department_id= p_did;
      return v_sum;
end;
declare 
      v_sum number;
begin
      dbms_output.put_line(get_result11(50,v_sum));
      dbms_output.put_line('v_coun = ' || v_sum);
end;


























