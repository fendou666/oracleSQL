--�����ݱ�
CREATE TABLE dept_copy
as
SELECT * FROM dept;

--����������

CREATE OR REPLACE TRIGGER emp_tri
BEFORE
DELETE
ON dept
DECLARE

BEGIN

END;



--������(DML)
CREATE OR REPLACE TRIGGER emp_tri
BEFORE
INSERT OR UPDATE OR DELETE
ON employees
DECLARE

BEGIN
   IF TO_CHAR(sysdate, 'hh24') between 10 and 11 then
      IF INSERTING THEN
         RAISE_APPLICATION_ERROR(-20001, '��10�㵽11�㲻�����������');
      ELSIF updating  THEN
         RAISE_APPLICATION_ERROR(-20001, '��10�㵽11�㲻�����������');
      ELSE 
         RAISE_APPLICATION_ERROR(-20001, '��10�㵽11�㲻����ɾ������');
      END IF;   
   END IF;       
END;

--���������

SELECT  ename ,sal*12 "�깤��" FROM  emp;

--ɾ��Լ����ɾ�����ű��Ϊ90��Ա��
--��Ϊ����������������Լ��������ɾ����ֻ��ͨ����ͼɾ��
CREATE TABLE departments_copy AS select * from departments;
DELETE  FROM departments where department_id=90;
EMP_DEPT_FK(�ο�employees�����Լ��)


CREATE OR REPLACE VIEW VW_dpmt
AS
       SELECT * FROM departments;
       
       

CREATE OR REPLACE TRIGGER TRG_del_dpmt_vw
INSTEAD OF DELETE ON VW_dpmt
FOR EACH ROW
DECLARE

BEGIN
    DELETE FROM employees WHERE department_id =:new.department_id;
END;

DELETE  FROM VW_dpmt where department_id=90;








