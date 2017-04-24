select * from AAA;
insert into aaa values(1,111);
insert into aaa values(2,222);

update aaa set name=1111 where id =1;
update aaa set name=22222 where id =2;

--sql注入
select * from aaa where id = 1 and name ='1111';
'1111' "1' or 1='1"
select * from aaa where id = 1 and name ='11' or 1='1';

--jdbc中prepareCall
create or replace function getCount(
       v_id employees.employee_id%type,
       v_sal out employees.salary%type
)
return varchar
as
       v_sql varchar(200);
       v_name employees.last_name%type;
begin
       SELECT last_name, salary INTO v_name, v_sal FROM employees WHERE employee_id=v_id;
       RETURN v_name;   
end;

SELECT * FROM tabs;
SELECT * FROM user_tables;


insert into student VALUES(11,'chinasofit-1', '男');
insert into student VALUES(12,'chinasofit-2', '男');
insert into student VALUES(13,'chinasofit-3', '男');
insert into student VALUES(14,'chinasofit-4', '男');
insert into student VALUES(15,'chinasofit-5', '男');
insert into student VALUES(16,'chinasofit-6', '男');
insert into student VALUES(17,'chinasofit-7', '男');
insert into student VALUES(18,'chinasofit-8', '男');
insert into student VALUES(15,'chinasofit-9', '男');
insert into student VALUES(16,'chinasofit-10', '男');
insert into student VALUES(17,'chinasofit-11', '男');
insert into student VALUES(18,'chinasofit-12', '男');

SELECT * from student order by name;

--创建表结构
create table studentcopy as select * from student where 2<1;

begin
  for i in 1..100 loop
      insert into studentcopy values(i, 'chinasofit-'||i, '男');
  end loop;
end;

SELECT * from studentcopy order by to_number(substr(name,11));


CREATE OR REPLACE PROCEDURE(
       V_sql varchar, V_cursor CURSOR
)
AS

BEGIN
       EXECUTE IMMEDIATE V_sql into ;        
END;


--测试
UPDATE student SET name='aa' WHERE id=1;
DECLARE
       V_sql varchar(200):= 'UPDATE student SET name=''aa'' WHERE id=2';
       V_rec number(3):=0;
BEGIN
       EXECUTE IMMEDIATE V_sql;
       dbms_output.put_line(V_rec);        
END;



CREATE TABLE aa as SELECT * from student
drop table aa;
delete from aa;
select * from aa;

--删除测试
DECLARE
       V_count number(10);
BEGIN
       DELETE  FROM aa RETURNING count(aa.id) INTO V_count;
       dbms_output.put_line(V_count);
END;

--删除
DECLARE
       V_sql varchar(200):='DELETE  FROM aa RETUTNING count(aa.id) INTO :1';
       V_count number(10);
BEGIN
       EXECUTE IMMEDIATE V_sql RETURNING INTO V_count;
       DBMS_OUTPUT.put_line(V_count);
END;

DECLARE
       V_sql varchar(200):='DELETE  FROM aa RETUTNING count(aa.id) INTO :1';
       V_count number(10);
BEGIN
       EXECUTE IMMEDIATE V_sql RETURNING INTO V_count;
       DBMS_OUTPUT.put_line(V_count);
END;
SELECT name FROM aa WHERE id = 2
--查询
DECLARE
       V_sql varchar(200):='SELECT name FROM aa WHERE id = :1';
       V_id number(10):=2;
       V_name varchar(20);
BEGIN
       EXECUTE IMMEDIATE V_sql  INTO V_name USING V_id;
       --SELECT name into V_name FROM aa WHERE id = 2;
    
       --DBMS_OUTPUT.put_line(V_id);
       DBMS_OUTPUT.put_line(V_name);
END;
create or replace s_i(V_id in out number,v_name out varchar)
as 
begin
  select 

--更新
DECLARE
       V_id number(2):=1;
       V_sql varchar(200):='UPDATE aa  SET name=''bb'' RETURNING name INTO :1';
       V_name varchar(10);
BEGIN
--       EXECUTE IMMEDIATE V_sql RETURNING INTO V_name;
       UPDATE aa  SET name='bb' WHERE id=1 RETURNING name INTO :1
       DBMS_OUTPUT.put_line(V_name);
END;

--按照薪水分级：D 3000以下 C 5000以下 B 8000以下  A 10000以下 O：10000以上

SELECT e.*, 
       CASE  
       WHEN e.sal<3000  then 'D'
       WHEN e.sal<5000  THEN 'C'
       WHEN e.sal<8000  THEN 'B'
       WHEN e.sal<10000  THEN 'A'
       ELSE '0'
       END AS grade
       
FROM emp e;


--我想知道2000以下有多少个员工 2000-5000有多少个员工 5000-10000有多少个员工 10000以上有多少

SELECT count(grade), grade FROM(
SELECT e.salary,
       CASE  
       WHEN e.salary<2000  then 'D'
       WHEN e.salary<5000  THEN 'C'
       WHEN e.salary<10000  THEN 'A'
       ELSE '0'
       END AS grade
FROM employees e)
GROUP BY grade;







