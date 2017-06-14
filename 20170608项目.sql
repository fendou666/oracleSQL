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


