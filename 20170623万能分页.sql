需要表数组
需要每个表对应的字段的数组
需要条件数组
需要count字段

---万能分页函数
create or replace function eecAdminQueryTeacherPageRows(v_maxPageRows in number,
                            v_currentPageNumber in number,
                            v_getCountFild      in varchar2, --eec_id
                            v_fildAll           in varchar2, --
                            v_tableAll          in varchar2, --eecuser u, eecrole r
                            v_condition         in varchar2, -- condition字段
                            v_count             out number)
    return sys_refcursor as
    v_getCountSql   varchar2(200) := 'select count() from  where ' || v_condition;
    v_getPageRecord varchar2(2000) := 'select sss.class_Id, sss.EEC_Id, sss.EEC_Name, sss.sex, sss.age, sss.email, sss.telephone, sss.role_name 
          from  (  select 
           case when mod(ss.Lineno,:maxPageRows) =0 then ss.Lineno/:maxPageRows
            when mod(ss.Lineno,:maxPageRows)!=0 then trunc(ss.Lineno/:maxPageRows)+1 end as pageno,
            ss.class_Id,ss.EEC_Id,  ss.EEC_Name, ss.sex, ss.age, ss.email, ss.telephone, ss.role_name
          from  (select row_number() over(order by  u.EEC_Id)  as Lineno,
             u.class_Id, u.EEC_Id, u.EEC_Name, u.sex,u.age, u.email, u.telephone, r.role_name  
            from eecuser u, eecrole r where ' ||
                      v_condition ||
                      ' )  ss 
        ) sss 
        where sss.pageno=:currentPageNumbe';
    myPagecur       sys_refcursor;
begin
    EXECUTE IMMEDIATE v_getCountSql
        INTO v_count;
    Dbms_Output.put_line('v_count:' || v_count);
    open myPagecur for v_getPageRecord
        using v_maxPageRows, v_maxPageRows, v_maxPageRows, v_maxPageRows, v_currentPageNumber;
    return myPagecur;
end;

