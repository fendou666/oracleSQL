declare
  V_id number(10):=33;
  V_name varchar(20):='小明';
  V_b boolean:=true;
  V_date date:=sysdate;
  V_date1 varchar(20):=to_date('2017-02-03','YYYY-MM-DD');
  V_date2 varchar(20):=to_date(sysdate,'MM DD,YYYY');
  V_test varchar(10); 
begin
  dbms_output.put_line('中文');
  dbms_output.put_line(V_date1);
  dbms_output.put_line(V_date2);
  /*dbms_output_line("adf");*/
  
end;

declare
  V_name varchar(22); --程序变量
  V_id NOT NULL number(10):=33; --程序变量不可为空
  C_pi CONSTANT number(2,10):=3.14159; --程序常量值不可更改
  P_id; --参数
  Emp;--表
  Emp_recode_type; --表类型
  Emp_recode; --记录类型
  Emp_cursor ;--游标变量
  E_to_many_rows; --异常变量
begin
  null;
  
end;




DECLARE 
  V_empno number(10):=7698;
  TYPE Emp_record_type IS RECORD(
       V_ename varchar(20):=22,
       V_salary number(10,2)
  );
  testR1 Emp_record_type;
  testR2 Emp_record_type;
  testR3 Emp_record_type;
  testR4 Emp_record_type;
BEGIN
  SELECT ename,sal INTO testR1 FROM emp WHERE empno=V_empno;
  dbms_output.put('asdfasdf');
  dbms_output.put('----asdfasdf');
  dbms_output.put_line('员工姓名：' || testR1.V_ename || '   员工工资: ' ||testR1.V_salary);
  SELECT ename,sal INTO testR2 FROM emp WHERE empno=V_empno;
  dbms_output.put_line('员工姓名：' || testR2.V_ename || '   员工工资: ' ||testR2.V_salary);
  SELECT ename,sal INTO testR3 FROM emp WHERE empno=V_empno;
  dbms_output.put_line('员工姓名：' || testR3.V_ename || '   员工工资: ' ||testR3.V_salary);
  SELECT ename,sal INTO testR4 FROM emp WHERE empno=V_empno;
  dbms_output.put_line('员工姓名：' || testR4.V_ename || '   员工工资: ' ||testR4.V_salary);
  
END;

SELECT * FRoM EMP;


--引用参照类型
DECLARE
       V_ii number(20);
       V_jj V_ii%TYPE := 250;
       
       TYPE Emp_recode_type IS RECORD(
            V_id emp.empno%TYPE:=7654,
            V_name emp.ename%TYPE,
            v_sal emp.sal%TYPE            
       );
       re Emp_recode_type;
BEGIN
       SELECT empno, ename, sal INTO re
       FROM emp
       WHERE empno=re.V_id;
       dbms_output.put_line('姓名：' || re.V_name || '  薪水:'|| re.v_sal);
END;

--引用参照表列


--引用参照表行


--表类型

SELECT * FROM emp;
DECLARE
  TYPE emp_table_type IS TABLE OF emp%ROWTYPE 
  INDEX BY BINARY_INTEGER;
  tb emp_table_type;
  i number:=1;
BEGIN

   SELECT * BULK COLLECT INTO tb FROM emp;
   dbms_output.put_line(tb.count);
   dbms_output.put_line(tb.first);
   dbms_output.put_line(tb.last);
   dbms_output.put_line(tb.next(2));
   dbms_output.put_line(tb.prior(2));
   LOOP   
        dbms_output.put_line(tb(i).);
        dbms_output.put_line('**************');
        i=i+1;  
        EXIT WHEN  tb.count
   END LOOP;
   
END;




--CASE语句

DECLARE
       V_level varchar(20):='&input';
       V_text varchar(20);
BEGIN
       CASE V_level
       WHEN 'A' THEN V_text:='甲等';
       WHEN 'B' THEN V_text:='乙等';
       WHEN 'C' THEN V_text:='丙等';
       ELSE V_text:='没等级';
       END CASE;
       dbms_output.put_line(V_text);
END;

DECLARE
       V_level varchar(20):='&input';
       V_text varchar(20);
BEGIN
       V_text:=CASE V_level
       WHEN 'A' THEN '甲等'
       WHEN 'B' THEN '乙等'
       WHEN 'C' THEN '丙等'
       ELSE '没等级'
       END;
       dbms_output.put_line(V_text);
END;







--用if else 语句判断是否在1-100之间，如果在输出这个数，不在输出FALSE
SELECT
--employees 10-50:营销部   60-90：市场部  大于90：研发部  其他：部门不存在
--用loop，for，while循环递减50-1
--把employees 员工信息遍历出来 取出emp表7369的工资，如果小于1200输出low,小于2000输出middle，其他输出high

















