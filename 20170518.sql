CREATE TABLE  j2eeTest(userName varchar(20), pwd varchar(20));

INSERT INTO j2eeTest VALUES('aaa', 'bbb');

SELECT userName, pwd FROM j2eeTest;

CREATE TABLE  userInfo(id number, userName varchar(20), pwd varchar(20));

INSERT INTO userInfo VALUES(1, 'С��', 'aaaa');
INSERT INTO userInfo VALUES(2, 'С��', 'bbbb');
INSERT INTO userInfo VALUES(3, 'Сǿ', 'cccc');
INSERT INTO userInfo VALUES(4, 'С��', 'dddd');
INSERT INTO userInfo VALUES(5, 'С��', 'eeee');


SELECT userName, pwd FROM userInfo WHERE id=1;

--ͨ��prepareStatement��̬����ʵ��
CREATE OR REPLACE FUNCTION getUser(userName varchar, userPwd varchar)
RETURNING number
AS

BEGIN
          

END;

CREATE TABLE studentInfo(
studentId number(10),
name varchar(5),
sex varchar(2),
age number(3),
school varchar(20)
);

INSERT INTO studentInfo VALUES(100001, 'С��', '��', 22, '��������');
UPDATE studentInfo SET pwd='123' WHERE studentid=100001;

select t.studentid, t.name, t.sex, t.age, t.school, t.pwd from STUDENTINFO t WHERE t.studentid=100001 AND t.pwd='123' 

















