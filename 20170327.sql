--���в�ѯ
SELECT * FROM employees;
DECLARE
  e employees%ROWTYPE;
  V_sql varchar(2000);

BEGIN
  V_sql := 'SELECT * FROM employees WHERE employee_id=: empid';
  EXECUTE IMMEDIATE V_sql INTO e USING 205;
  dbms_output.put_line('Ա��������' || e.last_name);

END;


--���в�ѯ
DECLARE
  e employees%ROWTYPE;
  V_sql varchar(2000);
  Emp_cursor sys_refcursor;

BEGIN
  V_sql := 'SELECT * FROM employees WHERE department_id=: empid';
  OPEN Emp_cursor FOR V_sql USING 50;
  LOOP
       FETCH Emp_cursor INTO e;
       EXIT WHEN Emp_cursor%NOTFOUND;
       dbms_output.put_line('Ա��ID��' || e.employee_id || 'Ա��������' || e.last_name);
  
  END LOOP;

END;

--���в�ѯʹ��FOR�α�

DECLARE
  e employees%ROWTYPE;
  V_sql varchar(2000);
  Emp_cursor sys_refcursor;

BEGIN
  V_sql := 'SELECT * FROM employees WHERE department_id=: empid';
  FOR e IN (OPEN Emp_cursor FOR V_sql USING 50) LOOP
     dbms_output.put_line('Ա��ID��' || e.employee_id || 'Ա��������' || e.last_name);
  
  END LOOP;
  
  
  
/*  OPEN Emp_cursor FOR V_sql USING 50;
  LOOP
       FETCH Emp_cursor INTO e;
       EXIT WHEN Emp_cursor%NOTFOUND;
       dbms_output.put_line('Ա��ID��' || e.employee_id || 'Ա��������' || e.last_name);
  
  END LOOP;*/

END;

--ʹ��bulk collect into
--��ѯ���ű��Ϊ90��Ա����Ϣ
SELECT * FROM employees WHERE department_id=90;
DECLARE
         V_id number:=90;
         V_sql varchar(1000):='SELECT * FROM employees WHERE department_id=:v_id';
         TYPE Emp_table_type IS TABLE OF employees%ROWTYPE;
         Emp_table Emp_table_type;
BEGIN
         EXECUTE IMMEDIATE V_sql BULK COLLECT INTO Emp_table USING V_id;
         
         dbms_output.put_line(Emp_table.count);
         FOR i IN 1..Emp_table.count LOOP
             dbms_output.put_line(Emp_table(i).employee_id || Emp_table(i).last_name);
         END LOOP;
END;
--���¶Բ���Ϊ90�ŵ�Ա�����ʼӼ�
DECLARE
         V_salAdd employees.salary%TYPE:=50;
         V_did employees.department_id%TYPE:=90;
         
         TYPE Emp_table_type IS TABLE OF employees%ROWTYPE;
         Emp_table Emp_table_type;
         V_sql varchar(2000):='update employees set salary = salary + :V_salAdd 
         WHERE department_id=:V_did RETURNING * INTO :Emp_table';
         
         
         
BEGIN
         EXECUTE IMMEDIATE V_sql USING V_salAdd, V_did RETURNING BULK COLLECT INTO Emp_table;
         dbms_output.put_line(Emp_table.count);
END;





--ʹ�ö�ִ̬��PLSQL

DECLARE 

         V_sql varchar(1000):='
         declare
               V_id number:=:v_id;
         begin
               dbms_output.put_line(V_id);
         end;
         
         ';

BEGIN
         EXECUTE IMMEDIATE V_sql USING 22;
         
END;



--�ɷ�ʵ����
DECLARE
         V_sqlMain varchar(2000):='
         declare 
                 V_id number:=:v_id; 
                 TYPE Emp_table_type IS TABLE OF employees%ROWTYPE;
                 Emp_table Emp_table_type;
                 V_sql varchar(1000):=''SELECT * FROM employees WHERE department_id=:v_id'';
         begin
                 EXECUTE IMMEDIATE V_sql BULK COLLECT INTO Emp_table USING V_id;
         
                 dbms_output.put_line(Emp_table.count);
                 FOR i IN 1..Emp_table.count LOOP
                     dbms_output.put_line(Emp_table(i).employee_id || Emp_table(i).last_name);
                 END LOOP;
         end;
         ';
         
         
         /*V_sqlMain varchar(1000):='SELECT * FROM employees WHERE department_id=:v_id';*/
         
BEGIN
         EXECUTE IMMEDIATE V_sql USING V_id; 
END;

--dbms_sql��
DROP TABLE AAA;
DECLARE
         c Integer;
         V_sql varchar(2000):='CREATE TABLE AAA(id number(20), name varchar(20))';

BEGIN
  
         c:=dbms_sql.open_cursor;
         ---������=>������Ϊ>=
         dbms_sql.parse(c=>c,statement=>V_sql,language_flag=>dbms_sql.native);
         dbms_sql.close_cursor(c=>c);

END;
---����=>��>=
DECLARE
         c Integer;
         V_sql varchar(2000):='CREATE TABLE AAA(id number(20), name varchar(20))';

BEGIN
  
         c:=dbms_sql.open_cursor;
         dbms_sql.parse(c>=c,statement>=V_sql,language_flag>=dbms_sql.native);
         dbms_sql.close_cursor(c>=c);

END;

--����only  c  ����Ϊֻ�е�������������ִ�гɹ�
DECLARE
         c Integer;
         V_sql varchar(2000):='CREATE TABLE AAA(id number(20), name varchar(20))';

BEGIN
  
         c:=dbms_sql.open_cursor;
         dbms_sql.parse(c,V_sql,dbms_sql.native);
         dbms_sql.close_cursor(c);
END;



--��������
DECLARE
         c INTEGER;
         V_sql varchar(2000):='UPDATE employees SET salary=salary+500 WHERE department_id=50';
         r INTEGER;
BEGIN
         c:=dbms_sql.open_cursor;
         dbms_sql.parse(c=>c, statement=>V_sql,language_flag=>dbms_sql.native);
         r:=dbms_sql.execute(c=>c);
         dbms_sql.close_cursor(c=>c);
         dbms_output.put_line('������' || r || '������');
END;

SELECT * FROM employees WHERE department_id=50;


select * from employees where employee_id = 100;
---�쳣
DECLARE
       --Ԥ�����쳣NO_DATA_FOUND
       --��Ԥ�����쳣
       my_e EXCEPTION;
       PRAGMA EXCEPTION_INIT(my_e,-2292);
       --�Զ����쳣
       myexp EXCEPTION;
       
       
       V_vlue employees%ROWTYPE;
       V_sal employees.salary%TYPE;
BEGIN
       /*SELECT * INTO V_vlue FROM employees WHERE employee_id=1;*/
       /*DELETE FROM employees WHERE employee_id=100;*/
       SELECT salary INTO V_sal FROM employees WHERE employee_id=100;
       IF V_sal>10000 THEN
          RAISE myexp;
          RAISE_APPLICATION_ERROR(-20001, '�Զ����쳣��Ϣ��������ŵ��쳣');
       END IF;

EXCEPTION
       WHEN NO_DATA_FOUND THEN
            dbms_output.put_line(sqlcode || sqlerrm);
            dbms_output.put_line('����Ԥ�����쳣��Ա��û�б��Ϊ1��Ա��');
       WHEN my_e THEN
            dbms_output.put_line(sqlcode || sqlerrm);
            dbms_output.put_line('������Ԥ�����쳣���������������쳣');
       WHEN myexp THEN
            /*dbms_output.put_line(sqlcode || sqlerrm);
            dbms_output.put_line('�����Զ����쳣�����ʳ���10000�����쳣');*/
       WHEN OTHERS THEN
            dbms_output.put_line(sqlcode || sqlerrm);
            dbms_output.put_line('others �쳣(һ���Զ��������ŵ������ﴦ��ֻ��Ҫ�������źʹ�����Ϣ)�������Ҫ����������3�ֽ���ѡ��');

END;

--�쳣�鸲��
DECLARE
  
BEGIN
       RAISE_APPLICATION_ERROR(-20001, '�ⲿ�쳣');
EXCEPTION
       WHEN OTHERS THEN
            BEGIN
                   RAISE_APPLICATION_ERROR(-20002, '�в��쳣');
            EXCEPTION
                   WHEN OTHERS THEN
                       BEGIN
                               RAISE_APPLICATION_ERROR(-20003, '�ڲ��쳣');
                       EXCEPTION
                               WHEN OTHERS THEN
                                    dbms_output.put_line(sqlerrm);  
                       END;
            
            END;

END;

DECLARE
  
BEGIN
       RAISE_APPLICATION_ERROR(-20001, '�ⲿ�쳣');
EXCEPTION
       WHEN OTHERS THEN
            BEGIN
                   RAISE_APPLICATION_ERROR(-20002, '�в��쳣');
            EXCEPTION
                   WHEN OTHERS THEN
                       BEGIN
                               RAISE_APPLICATION_ERROR(-20003, '�ڲ��쳣', true);
                       EXCEPTION
                               WHEN OTHERS THEN
                                    dbms_output.put_line(sqlerrm);  
                       END;
            
            END;

END;

DECLARE
  
BEGIN
       RAISE_APPLICATION_ERROR(-20001, '�ⲿ�쳣');
EXCEPTION
       WHEN OTHERS THEN
            BEGIN
                   RAISE_APPLICATION_ERROR(-20002, '�в��쳣', TRUE);
            EXCEPTION
                   WHEN OTHERS THEN
                       BEGIN
                               RAISE_APPLICATION_ERROR(-20003, '�ڲ��쳣', true);
                       EXCEPTION
                               WHEN OTHERS THEN
                                    dbms_output.put_line(sqlerrm);  
                       END;
            
            END;

END;


--�쳣����

--1.��ȡĳ���ŵĹ����ܺͣ�����������Ա����������ʾ����Ҫ�ҵ����ݲ����ڡ���


CREATE OR REPLACE FUNCTION get_sal(p_dpid  number�� p_sal out number)
RETURN varchar2
AS
       V_sum_sal employees.salary%TYPE;
BEGIN
       SELECT sum(salary) INTO V_sum_sal FROM employees WHERE department_id = p_dpid;
       IF V_sum_sal==null THEN
          RAISE_APPLICATION_ERROR(-20001, '��Ҫ�ҵ����ݲ�����');
       END IF;
       RETURN V_sum_sal;
EXCEPTION
       WHEN OTHERS THEN
            RETURN sqlerrm;  
END;



--2.�ѵ�һ���������ֲ������ݸ�ʽ�ֱ����ʵ�֣�
DECLARE
       V_sum_sal employees.salary%TYPE;
       p_dpid employees.department_id%TYPE;
BEGIN 
       dbms_output.put_line(get_sal(p_dpid));
END;
50,V_sal
p_dpid=>50, p_sal=>V_sal
50, p_sal=>V_sal
p_dpid=>50, V_sal

--3.ʹ�ô洢������departments���в������ݣ�
select * from departments;
CREATE OR REPLACE PROCEDURE de_insert(p_did departments.department_id%TYPE,
                                      p_name departments.department_name%TYPE,
                                      p_mngid departments.manager_id%TYPE,
                                      p_lctid departments.location_id%TYPE,
                                      )
AS

BEGIN
      INSERT INTO departments VALUES(p_did, p_name, p_mngid, p_lctid);
      commit;  
END;

BEGIN
      de_insert(111,'���Բ���',222,333);

END;


--4.�����ƶ����ŵĹ����ܺͣ���ͳ�����е�ְ������








