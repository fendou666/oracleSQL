需要表数组
需要每个表对应的字段的数组
需要条件数组
需要count字段

---万能分页函数
create or replace function eecQueryPageRows(v_maxPageRows in number,
                            v_currentPageNumber in number,
                            v_sqlCountFild      in varchar2, --eec_id
                            v_sqlOrderByFild    in varchar2, --eec_id
                            v_condition         in varchar2, -- condition字段
                            v_sqlAliasNeedFilds in varchar2, --
                            v_sqlAliasTableStr  in varchar2, --eecuser u, eecrole r
                            v_sqlNeedFilds      in varchar2, --
                            v_sqlTableStr       in varchar2, --eecuser u, eecrole r
                            v_count             out number)
    return sys_refcursor as
    v_getCountSql   varchar2(200) := 'select count('|| v_sqlCountFild ||') from '|| v_sqlAliasTableStr ||' where ' || v_condition;
    v_getPageRecord varchar2(2000) := 'select ' || v_sqlNeedFilds ||' 
          from  (  select 
           case when mod(Lineno,:maxPageRows) =0 then Lineno/:maxPageRows
            when mod(Lineno,:maxPageRows)!=0 then trunc(Lineno/:maxPageRows)+1 end as pageno,
            ' || v_sqlNeedFilds ||'
          from  (select row_number() over(order by  '|| v_sqlOrderByFild ||')  as Lineno,
             '|| v_sqlAliasNeedFilds ||'  
            from ' || v_sqlAliasTableStr ||' where ' ||
                      v_condition ||
                      ' )
        )
        where pageno=:currentPageNumbe';
    myPagecur       sys_refcursor;
begin
    --Dbms_Output.put_line('v_getCountSql:' || v_getCountSql);
    --Dbms_Output.put_line('v_getPageRecord:' || v_getPageRecord);
    EXECUTE IMMEDIATE v_getCountSql INTO v_count;
    Dbms_Output.put_line('v_count:' || v_count);
    open myPagecur for v_getPageRecord
        using v_maxPageRows, v_maxPageRows, v_maxPageRows, v_maxPageRows, v_currentPageNumber;
    return myPagecur;
end;






create or replace function eecTestCount(
                            v_sqlCountFild      in varchar2, --eec_id
                            v_condition         in varchar2, 
                            v_sqlAliasTableStr  in varchar2, --eecuser u, eecrole r
                            v_count             out number)
    return sys_refcursor as
    v_getCountSql   varchar2(200) := 'select count('|| v_sqlCountFild ||') from '|| v_sqlAliasTableStr ||' where ' || v_condition;
    myPagecur       sys_refcursor;
begin
    Dbms_Output.put_line('v_getCountSql:' || v_getCountSql);
    --Dbms_Output.put_line('v_getPageRecord:' || v_getPageRecord);
    EXECUTE IMMEDIATE v_getCountSql INTO v_count;
    open myPagecur for select * from emp;
    return myPagecur;
end;










