select * from STUDENT t

SELECT STUDENT_SEQ.NEXTVAL as id FROM dual;

CREATE TABLE className(
       id number(5) primary key,
       name varchar(10)
)
INSERT INTO className VALUES(1, '����(12)��');
INSERT INTO className VALUES(2, '����(14)��');
INSERT INTO className VALUES(3, '����(15)��');
INSERT INTO className VALUES(4, '����(16)��');

SELECT * FROM className;


SELECT c.id, c.name, s.id stuId, s.name stuName, s.sex, s.likes
FROM className c, student s 
WHERE
c.id=s.classid
AND c.id=1
