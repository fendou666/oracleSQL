CREATE TABLE testDDL (id number(10), 
                     name varchar(20), 
                     del1 varchar(10), 
                     del2 varchar(10),
                     del3 varchar(10));


ALTER TABLE testDDL DROP COLUMN del1;

ALTER TABLE testDDL DROP COLUMN del1;

COMMENT ON TABLE testDDL is '���һ������ע��';

ALTER TABLE testDDL RENAME (del2 to new2, del3 to new3);

CREATE TABLE testJobCopy as SELECT * FROM jobs;
CREATE TABLE testEmpCopy as SELECT * FROM employees;
SELECT * FROM testEmpCopy;
SELECT * FROM testJobCopy;
DROP TABLE testDepCopy;
--�������Լ��
ALTER TABLE testJobCopy ADD CONSTRAINT PK_JOB_ID PRIMARY KEY(job_id);
--ɾ��Լ��
ALTER TABLE testJobCopy DROP CONSTRAINT PK_DEPARTMENT_ID;
--������
ALTER TABLE testEmpCopy ADD CONSTRAINT fk_job_id FOREIGN KEY(job_id) References testJobCopy(job_id);
--ɾ�������е�һ��ֵ
DELETE FROM testJobCopy WHERE job_id='AD_VP'; --�����Ӽ�¼����ɾ��
--�����������ɾ���ֽ��ӱ�ɾ����ɾ������
DELETE FROM testEmpCopy WHERE job_id='AD_VP'; --�ɹ����б�ɾ��
DELETE FROM testJobCopy WHERE job_id='AD_VP'; --ɾ���Ӻ�ɹ�ɾ��
DELETE FROM testJobCopy WHERE job_id='AD_ASST'; --���Ӽ�¼����ɾ��,ͨ������ɾ��
--����ɾ��
ALTER TABLE testEmpCopy DROP CONSTRAINT fk_job_id;
ALTER TABLE testEmpCopy ADD CONSTRAINT fk_job_id FOREIGN KEY(job_id) References testJobCopy(job_id)
ON DELETE CASCADE;
DELETE FROM  testJobCopy WHERE job_id='AD_ASST';
SELECT * FROM testEmpCopy WHERE job_id='AD_ASST';
SELECT * FROM testEmpCopy WHERE job_id='SA_MAN';
DELETE FROM testEmpCopy WHERE job_id='SA_MAN';
SELECT * FROM testJobCopy WHERE job_id='SA_MAN';




--����ͼд��ѯÿ�����ű�ţ� ���ƣ� Ա�������� Ա�������ܺ�

--������ͼ
CREATE VIEW emp_viw
AS 
SELECT * FROM employees;
--��ֵȨ��
--ͨ���л����û�system��Ȼ��Ȩ�޸�ֵ��scott�û�
DISC scott;
conn system/orcl;
GRANT CREATE VIEW TO scott; ---ע����view�����ҵ�½��system��ʽ����������ѡΪsysdba

--����system�Ǳ߲鲻�����ű�������
--����copyһ�ű�
CREATE TABLE viewTest AS SELECT * FROM employees;
SELECT * FROM viewTest;
CREATE VIEW test_viw
AS 
SELECT * FROM viewTest;
--��ʾȨ�޲��㣬������system�û��´���viewȨ��
SELECT * FROM test_viw;













