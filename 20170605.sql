CREATE TABLE studentInfoA (
       id number(5),
       stuNum number(6),
       name varchar(20),
       sex varchar(2),
       age number(3),
       gradeFrom varchar(20),
       primary key(id)
)
INSERT INTO studentInfoA VALUES(1, 10001, '刘帅', '男', 20, '西安交通大学');

DECLARE
       v_id number(5):=1;
       v_stuNum number(11):=10001;
       name varchar(20):= 'ls-10000';
       sex varchar(2):='男';
       age number(3):=20;
       gradeFrom  varchar(20):='西安交通大学';
       
BEGIN
       for i in 1..500 loop
           v_id:=1+i;
           v_stuNum:=10001+i;
           name:='ls-'||(10001+i);
           if mod(v_id,2)=0 then
              sex := '男';
           else 
              sex := '女';
           end if;
           age := 20+mod(v_id,10);
           INSERT INTO studentInfoA VALUES(v_id, v_stuNum, name, sex, age, gradeFrom);
       end loop;
END;


SELECT id, stuNum, name, sex, age, gradeFrom FROM studentInfoA WHERE id = 1;

UPDATE studentInfoA SET name='刘亦帅' WHERE id=1;

UPDATE studentInfoA SET  stuNum=10011, name='刘亦菲', sex='女', age=28, gradeFrom='西安交通大学' WHERE id=1
