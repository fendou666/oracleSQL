CREATE OR REPLACE procedure testEmp(V_stuid in student.id%type,  
          V_inoutT in out number, 
          stu_cursor out sys_refcursor)
as

begin
       open stu_cursor for SELECT * FROM student stu;
       dbms_output.put_line('in参数:' ||V_stuid);
       dbms_output.put_line('inout参数:' ||V_inoutT);
       V_inoutT:=1111;
      /*open stu_cursor for SELECT * FROM student stu WHERE stu.id = V_stuid;*/
end;


CREATE OR REPLACE FUNCTION testFunc(V_stuid in student.id%type,  
          V_inoutT in out number, 
          V_outT out number)
return sys_refcursor

AS
          stu_cursor  sys_refcursor;
BEGIN
           open stu_cursor for SELECT * FROM student stu;
           dbms_output.put_line('in参数:' ||V_stuid);
           dbms_output.put_line('inout参数:' ||V_inoutT);
           V_inoutT:=1111;
           V_outT:=2222;
           return stu_cursor;
END;


SELECT * FROM student stu WHERE stu.id = 22
