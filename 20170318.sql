CREATE TABLE testDDL (id number(10), 
                     name varchar(20), 
                     del1 varchar(10), 
                     del2 varchar(10),
                     del3 varchar(10));


ALTER TABLE testDDL DROP COLUMN del1;

ALTER TABLE testDDL DROP COLUMN del1;

COMMENT ON TABLE testDDL is '添加一个测试注释';

ALTER TABLE testDDL RENAME (del2 to new2, del3 to new3);

CREATE TABLE testJobCopy as SELECT * FROM jobs;
CREATE TABLE testEmpCopy as SELECT * FROM employees;
SELECT * FROM testEmpCopy;
SELECT * FROM testJobCopy;
DROP TABLE testDepCopy;
--添加主键约束
ALTER TABLE testJobCopy ADD CONSTRAINT PK_JOB_ID PRIMARY KEY(job_id);
--删除约束
ALTER TABLE testJobCopy DROP CONSTRAINT PK_DEPARTMENT_ID;
--添加外键
ALTER TABLE testEmpCopy ADD CONSTRAINT fk_job_id FOREIGN KEY(job_id) References testJobCopy(job_id);
--删除主表中的一个值
DELETE FROM testJobCopy WHERE job_id='AD_VP'; --已有子记录不可删除
--这种情况正常删除现将从表删除再删除主表
DELETE FROM testEmpCopy WHERE job_id='AD_VP'; --成功两行被删除
DELETE FROM testJobCopy WHERE job_id='AD_VP'; --删除子后成功删除
DELETE FROM testJobCopy WHERE job_id='AD_ASST'; --有子记录不可删除,通过级联删除
--级联删除
ALTER TABLE testEmpCopy DROP CONSTRAINT fk_job_id;
ALTER TABLE testEmpCopy ADD CONSTRAINT fk_job_id FOREIGN KEY(job_id) References testJobCopy(job_id)
ON DELETE CASCADE;
DELETE FROM  testJobCopy WHERE job_id='AD_ASST';
SELECT * FROM testEmpCopy WHERE job_id='AD_ASST';
SELECT * FROM testEmpCopy WHERE job_id='SA_MAN';
DELETE FROM testEmpCopy WHERE job_id='SA_MAN';
SELECT * FROM testJobCopy WHERE job_id='SA_MAN';




--用视图写查询每个部门编号， 名称， 员工人数， 员工工资总和

--创建视图
CREATE VIEW emp_viw
AS 
SELECT * FROM employees;
--赋值权限
--通过切换到用户system，然后将权限赋值给scott用户
DISC scott;
conn system/orcl;
GRANT CREATE VIEW TO scott; ---注意是view，并且登陆以system方式而且是连接选为sysdba

--发现system那边查不到这张表。。。。
--重新copy一张表
CREATE TABLE viewTest AS SELECT * FROM employees;
SELECT * FROM viewTest;
CREATE VIEW test_viw
AS 
SELECT * FROM viewTest;
--提示权限不足，重新在system用户下创建view权限
SELECT * FROM test_viw;













