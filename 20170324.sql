
SELECT * FROM emp;
DECLARE 
/*TYPE Emp_table_type IS TABLE OF emp%ROWTYPE INDEX BY BINARY_INTEGER;
EmpDate Emp_table_type;*/

CURSOR Emp_cursor IS SELECT * FROM emp WHERE empno=;
BEGIN
  null;
  if Emp_cursor%ISOPEN THEN
     dbms_output.put_line('�α�״̬�Ǵ򿪵�');
  ELSE
     dbms_output.put_line('�α�״̬��δ��');
  END IF;
  
  if Emp_cursor%FOUND THEN
     dbms_output.put_line('�α�״̬�Ѿ�ָ������');
  ELSE
     dbms_output.put_line('�α�״̬δָ������');
  END IF;
  
  OPEN Emp_cursor;
  
  FETCH Emp_cursor BULK COLLECT INTO EmpDate;
  dbms_output.put_line(Emp_cursor%ROWCOUNT);
 
END;

--�α�
--ֱ�ӱ���
--�����������ͣ�������У�
--�������ñ���
--�����������ͱ����У�
--�α�����
--��ͨfor
--�α����
--��ͨfor
--�α�for

DECLARE
  V_ename emp.ename%TYPE:=7396;
  V_empno emp.empno%TYPE;
  --�����α�
  CURSOR Emp_cursor IS SELECT empno,ename FROM emp WHERE deptno=20;
BEGIN
  --���α�
  OPEN Emp_cursor;
  dbms_output.put_line('****************************');
  --��ȡ�α꣬ÿ����ȡ���α�ָ�����ƣ�ֱ����� 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('Ա����ţ�' || V_empno || '  Ա��������' || V_ename); 
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('Ա����ţ�' || V_empno || '  Ա��������' || V_ename);
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('Ա����ţ�' || V_empno || '  Ա��������' || V_ename);
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('Ա����ţ�' || V_empno || '  Ա��������' || V_ename);
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('Ա����ţ�' || V_empno || '  Ա��������' || V_ename);
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('Ա����ţ�' || V_empno || '  Ա��������' || V_ename);
  dbms_output.put_line('****************************'); 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('Ա����ţ�' || V_empno || '  Ա��������' || V_ename);
  
  CLOSE Emp_cursor;
END;

--�����α�����

--%ISOPEN, %NOTFOUND, %FOUND, %ROWCOUNT
DECLARE
  V_ename emp.ename%TYPE:=7396;
  V_empno emp.empno%TYPE;
  --�����α�
  CURSOR Emp_cursor IS SELECT empno,ename FROM emp WHERE deptno=20;
BEGIN
  --���α�
  IF Emp_cursor%ISOPEN THEN
     dbms_output.put_line('�α�û��');
  ELSE
     dbms_output.put_line('�α��Ѵ�');
  END IF;
  OPEN Emp_cursor;
   --�α굱ǰ���ҵ���ֵ������û�ҵ�����ָ��ԭ����λ�ã�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
  IF Emp_cursor%FOUND THEN
     dbms_output.put_line('�α굱ǰ״̬');
  END IF;
  
  dbms_output.put_line('****************************');
  --��ȡ�α꣬ÿ����ȡ���α�ָ�����ƣ�ֱ����� 
  FETCH Emp_cursor INTO V_empno,V_ename;
  dbms_output.put_line('Ա����ţ�' || V_empno || '  Ա��������' || V_ename); 
 
  
  
  CLOSE Emp_cursor;
END;


--
SELECT * FROM student;

DECLARE
       CURSOR stu_cursor IS SELECT * FROM student FOR UPDATE;
BEGIN
       FOR s in stu_cursor LOOP
           IF s.id = 4 THEN
             DELETE FROM student WHERE CURRENT OF stu_cursor;
           END IF;
                                                             
       END LOOP;

END;



---SQL���
SELECT to_date('2017-3-24 15:30:00', 'YYYY-MM-DD HH24:MI:SS') FROM user_objects;
SELECT to_date('2017-3-24 15:30:00', 'YYYY-BB-CC DD24:EE:FF') FROM user_objects;
SELECT to_date('2017-3-24 15:30:00', 'YYYY-MM-DD HH24:mm:ss') FROM user_objects;
DECLARE
       v_sql varchar(1000);
       CURSOR C_cursor IS SELECT object_name FROM user_objects WHERE object_type = 'TABLE' 
       AND created >=
       to_date('2017-3-24 15:30:00', 'YYYY-MM-DD HH24:MI:SS');
/*       CURSOR C_cursor IS SELECT object_name FROM user_objects WHERE object_type = 'TABLE';*/

BEGIN
       /*FOR c IN c_cursor LOOP
          dbms_output.put_line(c.object_name);
       END LOOP;*/
       
       FOR c IN c_cursor LOOP
           v_sql:='DROP TABLE ' || c.object_name;
           dbms_output.put_line(v_sql);
           EXECUTE IMMEDIATE v_sql;
       END LOOP;
END;


DECLARE
       v_sql varchar2(1000);
BEGIN
       FOR i IN 1..10 LOOP
           v_sql:='CREATE TABLE tb' || i || '  as SELECT * FROM emp';
           dbms_output.put_line(v_sql);
           EXECUTE IMMEDIATE v_sql;
       END LOOP;
END;







