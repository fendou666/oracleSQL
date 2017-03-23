--已scott用户登陆
show user
disc
conn system
--创建用户
CREATE USER qiqi IDENTIFIED by a123;
--用户解锁
alter user qiqi account unlock;
--创建连接
GRANT CREATE SESSION  TO qiqi;
--授权数据库管理员权限
GRANT dba  TO qiqi;
--收权
REVOKE dba FROM qiqi;

--进入qiqi用户操作
disc
conn qiqi
show user
--查询用户表
select * from user_tables
--创建数据库
CREATE TABLE test1 (id number(10), name varchar(10));
--插入数据
INSERT INTO test1 VALUES(1,'呵呵');
--查询数据
select * from user_tables; ---查看已经创建的表
select * from test1; --查看刚才插入的数据
--更新数据库
update test1 set id=2 where id=1;
select * from test1;
--删除数据
delete from test1;
select * from test1;
--删除表
drop table test1;
select * from user_tables;
--回收站查询
select * from user_recyclebin;
--回收站还原
FLASHBACK TABLE test1 TO BEFORE DROP;
--查看
select * from test1;
--再删除不进回收站
DROP TABLE test1 PURGE;
SELECT * FROM user_recyclebin;

--被system收权后再进入
disc
conn qiqi
create table qq (id number(10)); --提示权限不够

