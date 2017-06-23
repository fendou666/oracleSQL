-- 查询老师数据的函数
create or replace function eecAdminQueryTeacherPageRows(v_maxPageRows       in number,
                            v_currentPageNumber in number,
                            v_condition         in varchar2,
                            v_count             out number)
    return sys_refcursor as
    v_getCountSql   varchar2(200) := 'select count(eec_id) from eecuser u, eecrole r where ' || v_condition;
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



-- 查询老师数据的函数
create or replace function eecAdminQueryTeacherPageRows(v_maxPageRows       in number,
							v_currentPageNumber in number,
							v_condition         in varchar2,
							v_count             out number)
	return sys_refcursor as
	v_getCountSql   varchar2(200) := 'select count(eec_id) from eecuser u, eecrole r where u.role_id=r.role_id  AND isdelete=0 ' || v_condition;
	v_getPageRecord varchar2(2000) := 'select sss.class_Id, sss.EEC_Id, sss.EEC_Name, sss.sex, sss.age, sss.email, sss.telephone, sss.role_name 
	      from  (  select 
		   case when mod(ss.Lineno,:maxPageRows) =0 then ss.Lineno/:maxPageRows
			when mod(ss.Lineno,:maxPageRows)!=0 then trunc(ss.Lineno/:maxPageRows)+1 end as pageno,
			ss.class_Id,ss.EEC_Id,  ss.EEC_Name, ss.sex, ss.age, ss.email, ss.telephone, ss.role_name
	      from  (select row_number() over(order by  u.EEC_Id)  as Lineno,
			 u.class_Id, u.EEC_Id, u.EEC_Name, u.sex,u.age, u.email, u.telephone, r.role_name  
		    from eecuser u, eecrole r where u.role_id=r.role_id   AND isdelete=0 ' ||
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

--查询eecUser所有信息，通过条件字符串限定的数据
create or replace function eecUserInfoPageRows(v_maxPageRows       in number,
                                                v_currentPageNumber in number,
						v_condition         in varchar2,
						v_count             out number)
	return sys_refcursor as
	v_getCountSql   varchar2(200) := 'select count(eec_id) from eecuser u where  AND isdelete=0 ' || v_condition;
	v_getPageRecord varchar2(2000) := 'select sss.class_Id, sss.EEC_Id, sss.EEC_Name, sss.sex, sss.age, sss.email, sss.telephone,
	                                  sss.NickName,sss.Password,sss.birthday,sss.Constellatory,sss.Manager_id,
                                          sss.group_id,sss.registrationdate,sss.lastlogintime
              from  (  select 
		   case when mod(ss.Lineno,:maxPageRows) =0 then ss.Lineno/:maxPageRows
			when mod(ss.Lineno,:maxPageRows)!=0 then trunc(ss.Lineno/:maxPageRows)+1 end as pageno,
			ss.class_Id,ss.EEC_Id,  ss.EEC_Name, ss.sex, ss.age, ss.email, ss.telephone, 
                        ss.NickName,ss.Password,ss.birthday, ss.Constellatory,ss.Manager_id,
                        ss.group_id, ss.registrationdate,ss.lastlogintime
	      from  (select row_number() over(order by  u.EEC_Id)  as Lineno,
			 u.class_Id, u.EEC_Id, u.EEC_Name, u.sex,u.age, u.email, u.telephone, 
                         u.NickName,u.Password, u.birthday,u.Constellatory,u.Manager_id,
                         u.group_id,u.registrationdate,u.lastlogintime 
		    from eecuser u where  AND isdelete=0 ' || v_condition ||
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


--查询班级表信息，通过条件字符串限定数据

create or replace function eecClassInfoPageRows(v_maxPageRows       in number,
							v_currentPageNumber in number,
							v_count             out number)
	return sys_refcursor as
	v_getCountSql   varchar2(200) := 'SELECT count(c.class_id) FROM CLASS c';
	v_getPageRecord varchar2(2000) := 'select sss.class_Id, sss.monitor_name, sss.javateacher_name, sss.classteacher_name, sss.describe
	      from  (  select 
		   case when mod(ss.Lineno,:maxPageRows) =0 then ss.Lineno/:maxPageRows
			when mod(ss.Lineno,:maxPageRows)!=0 then trunc(ss.Lineno/:maxPageRows)+1 end as pageno,
			ss.class_id,ss.monitor_name,  ss.javateacher_name, ss.classteacher_name, ss.describe
	      from  (SELECT row_number() over(order by  c.class_id)  as Lineno, c.class_id,  
                            (SELECT u.eec_name FROM eecuser u WHERE u.eec_id=c.monitor_id) monitor_name,
                            (SELECT u.eec_name FROM eecuser u WHERE u.eec_id=c.javateacher_id) javateacher_name,
                            (SELECT u.eec_name FROM eecuser u WHERE u.eec_id=c.classteacher_id) classteacher_name,
                            c.describe
              FROM CLASS c  )  ss 
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

SELECT row_number() over(order by  c.class_id)  as Lineno, c.class_id,  
       (SELECT u.eec_name FROM eecuser u WHERE u.eec_id=c.monitor_id) monitor_name,
       (SELECT u.eec_name FROM eecuser u WHERE u.eec_id=c.javateacher_id) javateacher_name,
       (SELECT u.eec_name FROM eecuser u WHERE u.eec_id=c.classteacher_id) classteacher_name,
       c.describe
FROM CLASS c WHERE c.class_id=20170207;




select 
           class_Id,
				   EEC_Id, 
				   EEC_Name,
				   sex,
				   age,
				   email,
				   telephone,
				   role_name 
              from 
              (
              select 
                   case when mod(Lineno,10) =0 then Lineno/10
                        when mod(Lineno,10)!=0 then trunc(Lineno/10)+1 end as pageno,
                        class_Id,
                        EEC_Id, 
                        EEC_Name,
                        sex,
                        age,
                        email,
                        telephone,
                        role_name
              from
                (
                  select row_number() over(order by  u.EEC_Id)  as Lineno,
                         u.class_Id,
						 u.EEC_Id,
						 u.EEC_Name,
						 u.sex,
						 u.age,
						 u.email,
						 u.telephone,
						 r.role_name  
                    from eecuser u, eecrole r 
                         where u.role_id = r.role_id and u.role_id >= 3004 AND u.role_id <= 3005) ss 
                ) 
            where pageno=1;







