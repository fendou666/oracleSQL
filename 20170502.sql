
---注意：PACKAGE而不是packages

--包
CREATE OR REPLACE PACKAGE sal_upd_pacg
as
       FUNCTION getMinSal(V_deptno emp.deptno%type) return number;
       PROCEDURE getNewSal(V_newSalRs OUT sys_refcursor, errstr OUT varchar2);  

end sal_upd_pacg;

---注意：包中定义的函数，过程不需要CEARTE OR REPLACE， 
--无论函数还是包，END 必须加相应的名称， 
--sqlerror是不对的，应该是SQLCODE||SQLERRM
CREATE OR REPLACE PACKAGE BODY sal_upd_pacg
AS
       --利用函数获取某一部门的最低工资，
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
      
      ---存储过程
      
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

---测试定义与赋值

DECLARE
    V_test number(3):=39;
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_test);
END;
--这样不可以
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
--函数参数不能在AS下赋值, 声明和赋值不可分开
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






--在存储过程中调用函数实现如下逻辑： 
--如果是最低工资，将最低工资提高200；如果是基本工资在最低工资200以上400以内,
--将基本工资提高100的预算结果以部门编号，部门名，员工编号，员工姓名，
--工资信息一栏的形式做返回。Java采用JDBC完成读取并
------注意：CASE...when...then...else...end 形式 不是end case
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

