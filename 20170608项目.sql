select answer1, answer2, answer3 from QSTVerify WHERE QSTVerify_id=(
SELECT QSTVerify_id FROM EECUSER WHERE eec_id=170000001);

CREATE TABLE EECMSG(
       MSG_ID number(10) primary key not null,
       EEC_ID number(10)  not null,
       title varchar(50) ,
       msgContent varchar2(2000) not null,
       msgTime date not null,
       constraint FK_EEC_ID foreign key(EEC_ID)
       references EECUSER(EEC_ID) on delete set null
)

CREATE SEQUENCE msgSeq
--从一开始， 默认1
START WITH 12
--默认1，
INCREMENT BY 1
--种子数， 最小值为1
MINVALUE 1
--不循环
NOCYCLE
--不缓存
NOCACHE



--插入时间
INSERT INTO EECMSG VALUES(msgSeq.nextval, 170000001,'' ,'神马都是浮云',  
            to_date('2017-05-02 08:22:22','yyyy-mm-dd hh24:mi:ss'));

SELECT MSG_ID, EEC_ID, title, msgContent, msgTime FROM EECMSG WHERE MSG_ID=1;


SELECT * FROM STUDENTINFO WHERE name='小明' AND pwd=123;






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
 where u.role_id = r.role_id
   and u.role_id >= 3004
   AND u.role_id <= 3005
   AND u.role_id = 3004
   AND class_id = 20170207
   AND eec_id = 170000003
   AND eec_name = '谢文兵'

--- 这里考虑做任意查询语句， 参数中一个参数为select, 一个参数为select count(id)
--  一个参数为condition字符串
-- 使用动态sql语句做
create or replace function eecAdminQueryPageRows
( 
  v_maxPageRows in number,
  v_currentPageNumber in number,
  v_condition in varchar2,
  v_count out number
 )
return sys_refcursor 
as 
  myPagecur sys_refcursor;
  begin
       select count(eec_id) into v_count from eecuser u, eecrole r where '' || v_condition;
       Dbms_Output.put_line('v_count:'||v_count);
       open myPagecur for 
            select 
                   sss.class_Id,
				   ss.EEC_Id, 
				   sss.EEC_Name,
				   sss.sex,
				   sss.age,
				   sss.email,
				   sss.telephone,
				   sss.role_name 
              from 
              (
              select 
                   case when mod(ss.Lineno,v_maxPageRows) =0 then ss.Lineno/v_maxPageRows
                        when mod(ss.Lineno,v_maxPageRows)!=0 then trunc(ss.Lineno/v_maxPageRows)+1 end as pageno,
                        ss.class_Id,
                        ss.EEC_Id, 
                        ss.EEC_Name,
                        ss.sex,
                        ss.age,
                        ss.email,
                        ss.telephone,
                        ss.role_name
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
                    from eecuser u, eecrole r where '' || v_condition ss 
                ) sss 
            where sss.pageno=v_currentPageNumber;
       return myPagecur;
    end;







create or replace function eecAdminQueryPageRows
( 
  v_maxPageRows in number,
  v_currentPageNumber in number,
  v_condition in varchar2,
  v_count out number
 )
return sys_refcursor 
as 
  v_getCountSql varchar2(200):= 'select count(eec_id) into v_count from eecuser u, eecrole r where ' || v_condition;
  v_getPageRecord varchar2(1000):= 'select 
                   sss.class_Id,
				   ss.EEC_Id, 
				   sss.EEC_Name,
				   sss.sex,
				   sss.age,
				   sss.email,
				   sss.telephone,
				   sss.role_name 
              from 
              (
              select 
                   case when mod(ss.Lineno,:maxPageRows) =0 then ss.Lineno/:maxPageRows
                        when mod(ss.Lineno,:maxPageRows)!=0 then trunc(ss.Lineno/:maxPageRows)+1 end as pageno,
                        ss.class_Id,
                        ss.EEC_Id, 
                        ss.EEC_Name,
                        ss.sex,
                        ss.age,
                        ss.email,
                        ss.telephone,
                        ss.role_name
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
                    from eecuser u, eecrole r where ' || v_condition || 'ss 
                ) sss 
            where sss.pageno=:currentPageNumbe' ;
  myPagecur sys_refcursor;
  begin
       
       EXECUTE IMMEDIATE v_getCountSql INTO v_count;
       Dbms_Output.put_line('v_count:'||v_count);
       open myPagecur for  v_getPageRecord using v_maxPageRows, v_currentPageNumber;
       return myPagecur;
    end;
select count(eec_id)  from eecuser u, eecrole r where  u.role_id = r.role_id
   and u.role_id >= 3004
   AND u.role_id <= 3005
   AND u.role_id = 3004
   AND class_id = 20170207
   AND eec_id = 170000003
   AND eec_name = '谢文兵'

select 
                   sss.class_Id,
				   sss.EEC_Id, 
				   sss.EEC_Name,
				   sss.sex,
				   sss.age,
				   sss.email,
				   sss.telephone,
				   sss.role_name 
              from 
              (
              select 
                   case when mod(ss.Lineno,5) =0 then ss.Lineno/5
                        when mod(ss.Lineno,5)!=0 then trunc(ss.Lineno/5)+1 end as pageno,
                        ss.class_Id,
                        ss.EEC_Id, 
                        ss.EEC_Name,
                        ss.sex,
                        ss.age,
                        ss.email,
                        ss.telephone,
                        ss.role_name
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
                    from eecuser u, eecrole r where u.role_id = r.role_id
   and u.role_id >= 3004
   AND u.role_id <= 3005
   AND u.role_id = 3004
   AND class_id = 20170207
   AND eec_id = 170000003
   AND eec_name = '谢文兵')  ss 
                ) sss 
            where sss.pageno=1

u.role_id = r.role_id



create or replace function eecAdminQueryTeacherPageRows
( 
  v_maxPageRows in number,
  v_currentPageNumber in number,
  v_condition in TESTVARCHAR.str%TYPE,
  v_count out number
 )
return sys_refcursor 
as 
  v_getCountSql varchar2(200):= 'select count(eec_id) from eecuser u, eecrole r where u.role_id=r.role_id ' || v_condition;
  v_getPageRecord varchar2(2000):= 'select sss.class_Id, sss.EEC_Id, sss.EEC_Name, sss.sex, sss.age, sss.email, sss.telephone, sss.role_name 
              from  (  select 
                   case when mod(ss.Lineno,:maxPageRows) =0 then ss.Lineno/:maxPageRows
                        when mod(ss.Lineno,:maxPageRows)!=0 then trunc(ss.Lineno/:maxPageRows)+1 end as pageno,
                        ss.class_Id,ss.EEC_Id,  ss.EEC_Name, ss.sex, ss.age, ss.email, ss.telephone, ss.role_name
              from  (select row_number() over(order by  u.EEC_Id)  as Lineno,
                         u.class_Id, u.EEC_Id, u.EEC_Name, u.sex,u.age, u.email, u.telephone, r.role_name  
                    from eecuser u, eecrole r where u.role_id=r.role_id ' || v_condition ||' )  ss 
                ) sss 
            where sss.pageno=:currentPageNumbe' ;
  myPagecur sys_refcursor;
  begin
       
       EXECUTE IMMEDIATE v_getCountSql INTO v_count;
       Dbms_Output.put_line('v_count:'||v_count);
       open myPagecur for  v_getPageRecord using v_maxPageRows, v_maxPageRows, v_maxPageRows, v_maxPageRows, v_currentPageNumber;
       return myPagecur;
    end;

declare
    v_condition varchar2(200):='u.role_id = r.role_id
   and u.role_id >= 3004
   AND u.role_id <= 3005
   AND u.role_id = 3004
   AND class_id = 20170207
   AND eec_id = 170000003';
   v_condition2 varchar2(200):='u.role_id = r.role_id';
   v_cursor sys_refcursor;
   v_count number(5);
begin
    v_cursor:=eecAdminQueryPageRows(5,1,v_condition,v_count);
end;




CREATE TABLE TESTVARCHAR( str varchar2(1000));



create or replace function eecAdminQueryPageRows
( 
  v_maxPageRows in number,
  v_currentPageNumber in number,
  v_condition in varchar2,
  v_count out number
 )
return sys_refcursor 
as 
  myPagecur sys_refcursor;
  begin
       select count(eec_id) into v_count from eecuser u, eecrole r 
              where u.role_id = r.role_id and u.role_id >= 3004 AND u.role_id <= 3005;
       Dbms_Output.put_line('v_count:'||v_count);
       open myPagecur for 
            select 
                   sss.class_Id,
                   sss.EEC_Id, 
                   sss.EEC_Name,
                   sss.sex,
                   sss.age,
                   sss.email,
                   sss.telephone,
                   sss.NickName,
                   sss.Password,
                   sss.DateOfBirth,
                   sss.Constellatory,
                   sss.Manager_id,
                   sss.group_id,
                   sss.registrationdate,
                   sss.lastlogintime
              from 
              (
              select 
                   case when mod(ss.Lineno,10) =0 then ss.Lineno/10
                        when mod(ss.Lineno,10)!=0 then trunc(ss.Lineno/10)+1 end as pageno,
                        ss.class_Id,
                        ss.EEC_Id, 
                        ss.EEC_Name,
                        ss.sex,
                        ss.age,
                        ss.email,
                        ss.telephone,
                        ss.NickName,
                        ss.Password,
                        ss.DateOfBirth,
                        ss.Constellatory,
                        ss.Manager_id,
                        ss.group_id,
                        ss.registrationdate,
                        ss.lastlogintime
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
                         u.NickName,
                         u.Password,
                         u.DateOfBirth,
                         u.Constellatory,
                         u.Manager_id,
                         u.group_id,
                         u.registrationdate,
                         u.lastlogintime
                    from eecuser u
                         where  u.role_id >= 3004 AND u.role_id <= 3005) ss 
                ) sss 
            where sss.pageno=1;
       return myPagecur;
    end;

create or replace function eecAdminQueryPageRowsFun1
( 
  v_maxPageRows in number,
  v_currentPageNumber in number,
  v_count out number
 )
return sys_refcursor 
as 
  myPagecur sys_refcursor;
  begin
       select count(eec_id) into v_count from eecuser u, eecrole r 
              where u.role_id = r.role_id and u.role_id >= 3004 AND u.role_id <= 3005;
       Dbms_Output.put_line('v_count:'||v_count);
       open myPagecur for 
            select 
                   sss.class_Id,
				   sss.EEC_Id, 
				   sss.EEC_Name,
				   sss.sex,
				   sss.age,
				   sss.email,
				   sss.telephone,
				   sss.role_name 
              from 
              (
              select 
                   case when mod(ss.Lineno,v_maxPageRows) =0 then ss.Lineno/v_maxPageRows
                        when mod(ss.Lineno,v_maxPageRows)!=0 then trunc(ss.Lineno/v_maxPageRows)+1 end as pageno,
                        ss.class_Id,
                        ss.EEC_Id, 
                        ss.EEC_Name,
                        ss.sex,
                        ss.age,
                        ss.email,
                        ss.telephone,
                        ss.role_name
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
                ) sss 
            where sss.pageno=v_currentPageNumber;
       return myPagecur;
end;


0170207, 170000002, "管理员", "男",
				88,  "4437074544@qq.com", 11593239991L, 3006

BEGIN
        FOR i in 3..100 LOOP
            INSERT INTO eecuser(eec_id,eec_name,sex,age,email, telephone, role_id, class_id) 
                   VALUES(i,'班主任'||i, '男', 20, 'aa@126.com', 11593239991, 3004, 20170207);
       END LOOP;
end;

select * from Eecuser;


SELECT u.EEC_Id,u.EEC_Name from eecuser u WHERE  u.class_id=20170207 AND u.role_id=3001



select 
                   sss.class_Id,
                   sss.EEC_Id, 
                   sss.EEC_Name,
                   sss.sex,
                   sss.age,
                   sss.email,
                   sss.telephone,
                   sss.NickName,
                   sss.Password,
                   sss.DateOfBirth,
                   sss.Constellatory,
                   sss.Manager_id,
                   sss.group_id,
                   sss.registrationdate,
                   sss.lastlogintime
              from 
              (
              select 
                   case when mod(ss.Lineno,10) =0 then ss.Lineno/10
                        when mod(ss.Lineno,10)!=0 then trunc(ss.Lineno/10)+1 end as pageno,
                        ss.class_Id,
                        ss.EEC_Id, 
                        ss.EEC_Name,
                        ss.sex,
                        ss.age,
                        ss.email,
                        ss.telephone,
                        ss.NickName,
                        ss.Password,
                        ss.DateOfBirth,
                        ss.Constellatory,
                        ss.Manager_id,
                        ss.group_id,
                        ss.registrationdate,
                        ss.lastlogintime
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
                         u.NickName,
                         u.Password,
                         u.DateOfBirth,
                         u.Constellatory,
                         u.Manager_id,
                         u.group_id,
                         u.registrationdate,
                         u.lastlogintime
                    from eecuser u
                         where  u.role_id >= 3004 AND u.role_id <= 3005) ss 
                ) sss 
            where sss.pageno=1;







SELECT c.class_id,  
       (SELECT e.eec_name FROM eecuser e WHERE e.eec_id=c.monitor_id) monitor_name,
       (SELECT e.eec_name FROM eecuser e WHERE e.eec_id=c.javateacher_id) javateacher_name,
       (SELECT e.eec_name FROM eecuser e WHERE e.eec_id=c.classteacher_id) classteacher_name,
       c.describe
FROM CLASS c;





select sss.class_Id, sss.EEC_Id, sss.EEC_Name, sss.sex, sss.age, sss.email, sss.telephone,
	                                  sss.NickName,sss.Password,sss.birthday,sss.Constellatory,sss.Manager_id,
                                          sss.group_id,sss.registrationdate,sss.lastlogintime
              from  (  select
		   case when mod(ss.Lineno,10) =0 then ss.Lineno/10
			when mod(ss.Lineno,10)!=0 then trunc(ss.Lineno/10)+1 end as pageno,
			ss.class_Id,ss.EEC_Id,  ss.EEC_Name, ss.sex, ss.age, ss.email, ss.telephone,
                        ss.NickName,ss.Password,ss.birthday, ss.Constellatory,ss.Manager_id,
                        ss.group_id, ss.registrationdate,ss.lastlogintime
	      from  (select row_number() over(order by  u.EEC_Id)  as Lineno,
			 u.class_Id, u.EEC_Id, u.EEC_Name, u.sex,u.age, u.email, u.telephone,
                         u.NickName,u.Password, u.birthday,u.Constellatory,u.Manager_id,
                         u.group_id,u.registrationdate,u.lastlogintime
		    from eecuser u where  u.class_id is null AND u.manager_id is null
					  )  ss
		) sss
	    where sss.pageno=1












select u.class_Id,u.EEC_Id,u.EEC_Name,u.sex,u.age,u.email,u.telephone,r.role_name from eecuser u,eecrole r WHERE 1='1' AND u.role_id = r.role_id AND u.role_id >= 3004  AND u.role_id <= 3005
