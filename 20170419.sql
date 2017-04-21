select * from AAA;
insert into aaa values(1,111);
insert into aaa values(2,222);

update aaa set name=1111 where id =1;
update aaa set name=22222 where id =2;

--sql×¢Èë
select * from aaa where id = 1 and name ='1111';
'1111' "1' or 1='1"
select * from aaa where id = 1 and name ='11' or 1='1';

--jdbcÖÐprepareCall
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


insert into student VALUES(11,'chinasofit-1', 'ÄÐ');
insert into student VALUES(12,'chinasofit-2', 'ÄÐ');
insert into student VALUES(13,'chinasofit-3', 'ÄÐ');
insert into student VALUES(14,'chinasofit-4', 'ÄÐ');
insert into student VALUES(15,'chinasofit-5', 'ÄÐ');
insert into student VALUES(16,'chinasofit-6', 'ÄÐ');
insert into student VALUES(17,'chinasofit-7', 'ÄÐ');
insert into student VALUES(18,'chinasofit-8', 'ÄÐ');
insert into student VALUES(15,'chinasofit-9', 'ÄÐ');
insert into student VALUES(16,'chinasofit-10', 'ÄÐ');
insert into student VALUES(17,'chinasofit-11', 'ÄÐ');
insert into student VALUES(18,'chinasofit-12', 'ÄÐ');

SELECT * from student order by name;

--´´½¨±í½á¹¹
create table studentcopy as select * from student where 2<1;

begin
  for i in 1..100 loop
      insert into studentcopy values(i, 'chinasofit-'||i, 'ÄÐ');
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


--²âÊÔ
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

--É¾³ý²âÊÔ
DECLARE
       V_count number(10);
BEGIN
       DELETE  FROM aa RETURNING count(aa.id) INTO V_count;
       dbms_output.put_line(V_count);
END;

--É¾³ý
DECLARE
       V_sql varchar(200):='DELETE  FROM aa RETUTNING count(aa.id) INTO :1';
       V_count number(10);
BEGIN
       EXECUTE IMMEDIATE V_sql RETURNING INTO V_count;
       DBMS_OUTPUT.put_line(V_count);
END;



--Ôö¼Ó
DECLARE
       V_sql varchar(200):='INSERT INTO aa  VALUES(1, ''aa'', ''vv'') RETURNING id, name INTO :1, :2';
       V_id number(10);
       V_name varchar(20);
BEGIN
       EXECUTE IMMEDIATE V_sql RETURNING INTO V_id, V_name;
      -- INSERT INTO aa  VALUES(1, 'aa', 'vv') RETURNING id, name INTO V_id, V_name;
       DBMS_OUTPUT.put_line(V_id);
       DBMS_OUTPUT.put_line(V_name);
END;

--¸üÐÂ
DECLARE
       V_id number(2):=1;
       V_sql varchar(200):='UPDATE aa  SET name=''bb'' RETURNING name INTO :1';
       V_name varchar(10);
BEGIN
--       EXECUTE IMMEDIATE V_sql RETURNING INTO V_name;
       UPDATE aa  SET name='bb' WHERE id=1 RETURNING name INTO :1
       DBMS_OUTPUT.put_line(V_name);
END;









