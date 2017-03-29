--处理备份表
CREATE TABLE dept_copy
as
SELECT * FROM dept;

--创建触发器

CREATE OR REPLACE TRIGGER emp_tri
BEFORE
DELETE
ON dept
DECLARE

BEGIN

END;



--触发器(DML)
CREATE OR REPLACE TRIGGER emp_tri
BEFORE
INSERT OR UPDATE OR DELETE
ON employees
DECLARE

BEGIN
   IF TO_CHAR(sysdate, 'hh24') between 10 and 11 then
      IF INSERTING THEN
         RAISE_APPLICATION_ERROR(-20001, '在10点到11点不允许插入数据');
      ELSIF updating  THEN
         RAISE_APPLICATION_ERROR(-20001, '在10点到11点不允许更新数据');
      ELSE 
         RAISE_APPLICATION_ERROR(-20001, '在10点到11点不允许删除数据');
      END IF;   
   END IF;       
END;

--替代触发器

SELECT  ename ,sal*12 "年工资" FROM  emp;

--删除约束，删除部门编号为90的员工
--因为主键是其他表的外键约束，不可删除，只能通过视图删除
CREATE TABLE departments_copy AS select * from departments;
DELETE  FROM departments where department_id=90;
EMP_DEPT_FK(参考employees的外键约束)


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








