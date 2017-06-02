
---ע�⣺PACKAGE������packages

--��
CREATE OR REPLACE PACKAGE sal_upd_pacg
as
       FUNCTION getMinSal(V_deptno emp.deptno%type) return number;
       PROCEDURE getNewSal(V_newSalRs OUT sys_refcursor, errstr OUT varchar2);  

end sal_upd_pacg;

---ע�⣺���ж���ĺ��������̲���ҪCEARTE OR REPLACE�� 
--���ۺ������ǰ���END �������Ӧ�����ƣ� 
--sqlerror�ǲ��Եģ�Ӧ����SQLCODE||SQLERRM
CREATE OR REPLACE PACKAGE BODY sal_upd_pacg
AS
       --���ú�����ȡĳһ���ŵ���͹��ʣ�
      FUNCTION getMinSal(V_deptno emp.deptno%type) return number
	  AS
			 V_newSal number(8);
	  BEGIN
			 SELECT min(emp.sal) INTO V_newSal FROM emp WHERE deptno=V_deptno;
			 RETURN V_newSal;
	  EXCEPTION
			 WHEN OTHERS THEN
			 V_newSal:=0;
			 RETURN V_newSal;
	  END getMinSal;
      
      ---�洢����
      
      PROCEDURE getNewSal(V_newSalRs OUT sys_refcursor, errstr OUT varchar2)

	  AS
             V_tmp number(10);
	  BEGIN
            -- V_tmp:=290/0;
			 OPEN V_newSalRs FOR 
			 SELECT e.deptno, d.dname, e.empno, e.ename, e.sal, 
					 CASE   
					 WHEN e.sal=getMinSal(e.deptno) THEN
						  e.sal+200
					 WHEN e.sal BETWEEN getMinSal(e.deptno)+200 AND getMinSal(e.deptno) + 400 THEN
						  e.sal+100
					 ELSE
						  e.sal
					 END  newSal  
			  FROM emp e, dept d 
			  WHERE d.deptno = e.deptno;
	  EXCEPTION
			  WHEN OTHERS THEN
				   V_newSalRs:=null;
				   errstr:= SQLCODE || ':' || SQLERRM;
	  END getNewSal;

END sal_upd_pacg;

---���Զ����븳ֵ

DECLARE
    V_test number(3):=39;
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_test);
END;
--����������
DECLARE
    V_test number(3);
    V_test:=33;
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_test);
END;

DECLARE
    V_test number(3);
    
BEGIN
    V_test:=33;
    DBMS_OUTPUT.PUT_LINE(V_test);
END;
--��������������AS�¸�ֵ, �����͸�ֵ���ɷֿ�
CREATE OR REPLACE FUNCTION 
testAs(V_num1 number, V_num2 out number, V_num3 in out number) 
RETURN number
AS
       --V_num1:=10;
       --V_num2:=20;
       --V_num3:=30;      
       --v_test number(19):=10;
       v_test number(19);
       --v_test:=10;
BEGIN
       RETURN 2;
END;






--�ڴ洢�����е��ú���ʵ�������߼��� 
--�������͹��ʣ�����͹������200������ǻ�����������͹���200����400����,
--�������������100��Ԥ�����Բ��ű�ţ���������Ա����ţ�Ա��������
--������Ϣһ������ʽ�����ء�Java����JDBC��ɶ�ȡ��
------ע�⣺CASE...when...then...else...end ��ʽ ����end case
SELECT e.deptno, d.dname, e.empno, e.ename, e.sal, 
       CASE   
       WHEN e.sal=getMinSal(e.deptno) THEN
            e.sal+200
       WHEN e.sal BETWEEN getMinSal(e.deptno)+200 AND getMinSal(e.deptno) + 400 THEN
            e.sal+100
       ELSE
            e.sal
       END  newSal  
FROM emp e, dept d 
WHERE d.deptno = e.deptno;

SELECT * FROM emp;

