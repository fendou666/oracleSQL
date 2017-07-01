CREATE OR REPLACE PROCEDURE addSalary
AS

BEGIN
       UPDATE employee e SET e.sal=e.sal*(1.2) WHERE e.sal>=0 AND e.sal <=1000;
END;
select * from emp;

CREATE OR REPLACE FUNCTION getEmpPageDate(
                             pageRows number,
                             currentPage number,
                             allRecordCount out number  
)

RETURN sys_refcursor

AS
       v_cursor sys_refcursor;
BEGIN
       SELECT count(e.sal) INTO allRecordCount FROM emp e;
         OPEN v_cursor FOR  SELECT pageNum, empno, ename, sal
		  FROM (SELECT case
						   WHEN mod(rownumber, pageRows) = 0 THEN
							rownumber / pageRows
						   WHEN mod(rownumber, pageRows) != 0 THEN
							 trunc(rownumber / pageRows) + 1
					   END AS pageNum,
					   
					   
					   empno,
					   ename,
					   sal
				  FROM (SELECT row_number() over(ORDER BY e.empno) as rownumber,
							   e.empno,
							   e.ename,
							   e.sal
						  FROM emp e))
		 WHERE pageNum = currentPage;
         RETURN v_cursor;
END;
