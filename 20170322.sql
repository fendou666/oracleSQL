--��scott�û���½
show user
disc
conn system
--�����û�
CREATE USER qiqi IDENTIFIED by a123;
--�û�����
alter user qiqi account unlock;
--��������
GRANT CREATE SESSION  TO qiqi;
--��Ȩ���ݿ����ԱȨ��
GRANT dba  TO qiqi;
--��Ȩ
REVOKE dba FROM qiqi;

--����qiqi�û�����
disc
conn qiqi
show user
--��ѯ�û���
select * from user_tables
--�������ݿ�
CREATE TABLE test1 (id number(10), name varchar(10));
--��������
INSERT INTO test1 VALUES(1,'�Ǻ�');
--��ѯ����
select * from user_tables; ---�鿴�Ѿ������ı�
select * from test1; --�鿴�ղŲ��������
--�������ݿ�
update test1 set id=2 where id=1;
select * from test1;
--ɾ������
delete from test1;
select * from test1;
--ɾ����
drop table test1;
select * from user_tables;
--����վ��ѯ
select * from user_recyclebin;
--����վ��ԭ
FLASHBACK TABLE test1 TO BEFORE DROP;
--�鿴
select * from test1;
--��ɾ����������վ
DROP TABLE test1 PURGE;
SELECT * FROM user_recyclebin;

--��system��Ȩ���ٽ���
disc
conn qiqi
create table qq (id number(10)); --��ʾȨ�޲���

