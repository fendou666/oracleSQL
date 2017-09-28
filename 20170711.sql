select * from STUDENT t

SELECT STUDENT_SEQ.NEXTVAL as id FROM dual;

CREATE TABLE className(
       id number(5) primary key,
       name varchar(10)
)
INSERT INTO className VALUES(1, '高三(12)班');
INSERT INTO className VALUES(2, '高三(14)班');
INSERT INTO className VALUES(3, '高三(15)班');
INSERT INTO className VALUES(4, '高三(16)班');

SELECT * FROM className;


SELECT c.id, c.name, s.id stuId, s.name stuName, s.sex, s.likes
FROM className c, student s 
WHERE
c.id=s.classid
AND c.id=1
