create or replace function testJT1(v_inparam in number)
return sys_refcursor 
as
    myCursor  sys_refcursor;
begin
    Dbms_Output.put_line('in params'  || v_inparam);
    open myCursor for SELECT empno, ename FROM emp WHERE empno=7369;
    return myCursor;
end;


create or replace function testJT(v_inparam in number,
                            v_count     out number,
                            v_str in out varchar2)
return sys_refcursor 
as
    myCursor  sys_refcursor;
begin
    Dbms_Output.put_line('in params'  || v_inparam);
    Dbms_Output.put_line('inout params'  || v_str);
    v_count:=11;
    v_str:='我是sql inout的赋值';
    open myCursor for SELECT empno, ename FROM emp WHERE empno=7369;
    return myCursor;
end;
