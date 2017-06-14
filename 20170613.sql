---老师的代码
--row_number() over(order by Key)
select 
row_number() over(order by ID) as Lineno,
case when mod(row_number() over(order by ID),8)=0 then row_number() over(order by ID)/8
     when mod(row_number() over(order by ID),8)!=0 then trunc(row_number() over(order by ID)/8+1)
     end as pageno,
s.id,
s.name from scott.studentinfo s

select ss.pageno,ss.id,ss.name from (
select case when mod(row_number() over(order by ID),8)=0 then row_number() over(order by ID)/8
     when mod(row_number() over(order by ID),8)!=0 then trunc(row_number() over(order by ID)/8+1)
     end as pageno,
s.id,
s.name from scott.studentinfo s
  ) ss
where ss.pageno=2
--sql 优化:提高性能  简化操作

--选择数据表的列和行
select sss.pageno,sss.id,sss.name 
from 
(
select 
case when mod(ss.Lineno,8)=0 then ss.Lineno/8
     when mod(ss.Lineno,8)!=0 then trunc(ss.Lineno/8)+1 end as pageno,ss.id,ss.name 
from
 (select row_number() over(order by ID) as Lineno,s.id,s.name from scott.studentinfo s where s.name like '%xiewb%') ss
 ) sss where sss.pageno=2 

--创建函数
create or replace function getPageRows
( 
  v_maxPageRows in number,
  v_currentPageNumber in number,
  v_name in varchar2,
  v_count out number
 )
return sys_refcursor 
as 
  myPagecur sys_refcursor;
  begin
       select count(id) into v_count from studentinfo where name like '%'||v_name||'%';
       Dbms_Output.put_line('v_count:'||v_count);
       open myPagecur for 
            select 
                   sss.pageno,
                   sss.id,
                   sss.name,
                   sss.sex,
                   sss.age,
                   sss.gradefrom 
              from 
              (
              select 
                   case when mod(ss.Lineno,v_maxPageRows) =0 then ss.Lineno/v_maxPageRows
                        when mod(ss.Lineno,v_maxPageRows)!=0 then trunc(ss.Lineno/v_maxPageRows)+1 end as pageno,
                        ss.id,ss.name, 
                        ss.sex,
                        ss.age,
                        ss.gradefrom  
              from
                (
                  select row_number() over(order by ID) as Lineno,
                         s.id,
                         s.name,
                         s.sex,
                         s.age,
                         s.gradefrom  
                    from scott.studentinfo s where s.name like '%'||v_name||'%') ss 
                ) sss 
            where sss.pageno=v_currentPageNumber;
       return myPagecur;
    end;










---我自己暂时这样写 

SELECT sss.pageNum, sss.stunum, sss.name, sss.sex, sss.age, sss.gradefrom
  FROM (SELECT CASE
				   WHEN MOD(row_number, 10) = 0 THEN
					row_number / 10
				   WHEN MOD(row_number, 10) != 0 THEN
					trunc(row_number / 10) + 1
			   END as pageNum， ss.id,
			   ss.stunum,
			   ss.name,
			   ss.sex,
			   ss.age,
			   ss.gradefrom
		  FROM (
				
				SELECT ROW_NUMBER() OVER(ORDER BY s.id) row_number,
						s.id,
						s.stunum,
						s.name,
						s.sex,
						s.age,
						s.gradefrom
				  FROM studentinfoa s
				 WHERE name like '%ls%') ss) sss
 WHERE sss.pageNum = 2;

CREATE OR REPLACE FUNCTION getOnePageStuInfo(
v_maxPageRows number,
v_currentPageNumber number,
v_name varchar2,
v_allRecordRows out number
)
RETURN sys_refcursor
AS
       my_cursor sys_refcursor;
BEGIN
       SELECT count(id) INTO v_allRecordRows FROM studentinfoa WHERE name like '%' || v_name || '%' ;
       
       OPEN my_cursor FOR
            SELECT sss.pageNum, sss.id, sss.stunum, sss.name, sss.sex, sss.age, sss.gradefrom
			  FROM (SELECT CASE
							   WHEN MOD(row_number, v_maxPageRows) = 0 THEN
								row_number / v_maxPageRows
							   WHEN MOD(row_number, v_maxPageRows) != 0 THEN
								trunc(row_number / v_maxPageRows) + 1
						   END as pageNum， ss.id,
						   ss.stunum,
						   ss.name,
						   ss.sex,
						   ss.age,
						   ss.gradefrom
					  FROM (
            				
							SELECT ROW_NUMBER() OVER(ORDER BY s.id) row_number,
									s.id,
									s.stunum,
									s.name,
									s.sex,
									s.age,
									s.gradefrom
							  FROM studentinfoa s
							 WHERE name like '%' || v_name || '%') ss) sss
			 WHERE sss.pageNum = v_currentPageNumber;

       RETURN my_cursor;
END;



