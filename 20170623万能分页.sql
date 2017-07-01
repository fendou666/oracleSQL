需要表数组
需要每个表对应的字段的数组
需要条件数组
需要count字段

--- v_maxPageRows  10
--- v_currentPageNumber   1 
--- v_sqlCountFild  eec_id
--- v_sqlOrderByFild   eec_id
--- v_condition  u.role_id=r.role_id  AND isdelete=0 AND u.role_id>=3004 AND u.role_id<=3005
--- v_sqlNeedFilds  role_name , class_Id, EEC_Id, EEC_Name, sex, age, email, telephone 
--- v_sqlTableStr   eecuser, eecrole 
--- v_sqlAliasNeedFilds  r.role_name , u.class_Id, u.EEC_Id, u.EEC_Name, u.sex, u.age, u.email, u.telephone 
--- v_sqlAliasTableStr  eecuser u, eecrole r 
--- v_count 按条件查询后返回的所有记录条数

--- v_maxPageRows 页面允许的最大显示条数 
--- v_currentPageNumber 需要获取的页面index   
--- v_sqlCountFild  sql查询count时候需要的字段 
--- v_sqlOrderByFild sql查询分页基础的orderby 字段  
--- v_condition sql查询需要的查询条件语句   
--- v_sqlNeedFilds sql查询需要的字段  
--- v_sqlTableStr sql查询需要的表 拼接的字符串 
--- v_sqlAliasNeedFilds sql查询需要的带表别名的字段，用于分页查询的基础 
--- v_sqlAliasTableStr sql查询需要的表别名 拼接的字符串 ，用于分页查询的基础  
--- v_count 按条件查询后返回的所有记录条数
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
    v_getCountSql   varchar2(200) := 'select count('|| v_sqlCountFild ||') from '|| v_sqlAliasTableStr ||' where 1=1  ' || v_condition;
    v_getPageRecord varchar2(2000) := 'select ' || v_sqlNeedFilds ||' 
          from  (  select 
           case when mod(Lineno,:maxPageRows) =0 then Lineno/:maxPageRows
            when mod(Lineno,:maxPageRows)!=0 then trunc(Lineno/:maxPageRows)+1 end as pageno,
            ' || v_sqlNeedFilds ||'
          from  (select row_number() over(order by  '|| v_sqlOrderByFild ||')  as Lineno,
             '|| v_sqlAliasNeedFilds ||'  
            from ' || v_sqlAliasTableStr ||' where  1=1 ' ||
                      v_condition ||
                      ' )
        )
        where pageno=:currentPageNumbe';
    myPagecur       sys_refcursor;
begin
    --Dbms_Output.put_line('v_getCountSql:' || v_getCountSql);
    --Dbms_Output.put_line('v_getPageRecord:' || v_getPageRecord);
    EXECUTE IMMEDIATE v_getCountSql INTO v_count;
    --Dbms_Output.put_line('v_count:' || v_count);
    open myPagecur for v_getPageRecord
        using v_maxPageRows, v_maxPageRows, v_maxPageRows, v_maxPageRows, v_currentPageNumber;
    return myPagecur;
end;

--- v_maxPageRows 页面允许的最大显示条数
--- v_currentPageNumber 需要获取的页面index
--- v_sqlCountFild  sql查询count时候需要的字段
--- v_condition sql查询需要的查询语句
--- v_sqlNeedFilds sql查询需要的字段
--- v_sqlTableStr sql查询需要的表 拼接的字符串
--- v_count 按条件查询后返回的所有记录条数
create or replace function eecQueryPageRowsOptimize(v_maxPageRows in number,
                            v_currentPageNumber in number,
                            v_sqlCountFild      in varchar2, --eec_id
                            v_condition         in varchar2, -- condition字段
                            v_sqlNeedFilds      in varchar2, --
                            v_sqlTableStr       in varchar2, --eecuser u, eecrole r
                            v_count             out number)
    return sys_refcursor as
    v_getCountSql   varchar2(200) := 'select count('|| v_sqlCountFild ||') from '|| v_sqlTableStr ||' where 1=''1'' ' || v_condition;
    v_getPageRecord varchar2(2000) := 'select ' || v_sqlNeedFilds ||' 
          from  (  select 
           case when mod(Lineno,:maxPageRows) =0 then Lineno/:maxPageRows
            when mod(Lineno,:maxPageRows)!=0 then trunc(Lineno/:maxPageRows)+1 end as pageno,
            ' || v_sqlNeedFilds ||'
          from  (select row_number() over(order by  '|| v_sqlCountFild ||')  as Lineno,
             '|| v_sqlNeedFilds ||'  
            from ' || v_sqlTableStr ||' where  1=''1'' ' ||
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


--- v_maxPageRows 页面允许的最大显示条数
--- v_currentPageNumber 需要获取的页面index
--- v_sqlCountFild  sql查询count时候需要的字段
--- v_condition sql查询需要的查询语句
--- v_sqlNeedFilds sql查询需要的字段
--- v_sqlTableStr sql查询需要的表 拼接的字符串
--- v_count 按条件查询后返回的所有记录条数
create or replace function eecQueryPageRowsOptimize(v_maxPageRows in number,
                            v_currentPageNumber in number,
                            v_sqlCountFild      in varchar2, --eec_id
                            v_condition         in varchar2, -- condition字段
                            v_sqlNeedFilds      in varchar2, --
                            v_sqlTableStr       in varchar2, --eecuser u, eecrole r
                            v_count             out number)
    return sys_refcursor as
    v_getCountSql   varchar2(200) := 'select count('|| v_sqlCountFild ||') from '|| v_sqlTableStr ||' where ' || v_condition;
    v_getPageRecord varchar2(2000) := 'select ' || v_sqlNeedFilds ||' 
          from  (  select 
           case when mod(Lineno,:maxPageRows) =0 then Lineno/:maxPageRows
            when mod(Lineno,:maxPageRows)!=0 then trunc(Lineno/:maxPageRows)+1 end as pageno,
            ' || v_sqlNeedFilds ||'
          from  (select row_number() over(order by  '|| v_sqlCountFild ||')  as Lineno,
             '|| v_sqlNeedFilds ||'  
            from ' || v_sqlTableStr ||' where ' ||
                      v_condition ||
                      ' )
        )
        where pageno=:currentPageNumbe';
    myPagecur       sys_refcursor;
begin
    EXECUTE IMMEDIATE v_getCountSql INTO v_count;
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










