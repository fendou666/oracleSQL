CREATE TABLE  j2eeTest(userName varchar(20), pwd varchar(20));

INSERT INTO j2eeTest VALUES('aaa', 'bbb');

SELECT userName, pwd FROM j2eeTest;

CREATE TABLE  userInfo(id number, userName varchar(20), pwd varchar(20));

INSERT INTO userInfo VALUES(1, '小明', 'aaaa');
INSERT INTO userInfo VALUES(2, '小红', 'bbbb');
INSERT INTO userInfo VALUES(3, '小强', 'cccc');
INSERT INTO userInfo VALUES(4, '小李', 'dddd');
INSERT INTO userInfo VALUES(5, '小军', 'eeee');


SELECT userName, pwd FROM userInfo WHERE id=1;

--通过prepareStatement动态参数实现
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

INSERT INTO studentInfo VALUES(100001, '小明', '男', 22, '西安交大');
UPDATE studentInfo SET pwd='123' WHERE studentid=100001;

select t.studentid, t.name, t.sex, t.age, t.school, t.pwd from STUDENTINFO t WHERE t.studentid=100001 AND t.pwd='123' 

















