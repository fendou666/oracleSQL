declare
  V_id number(10):=33;
  V_name varchar(20):='С��';
  V_b boolean:=true;
  V_date date:=sysdate;
  V_date1 varchar(20):=to_date('2017-02-03','YYYY-MM-DD');
  V_date2 varchar(20):=to_date(sysdate,'MM DD,YYYY');
  V_test varchar(10); 
begin
  dbms_output.put_line('����');
  dbms_output.put_line(V_date1);
  dbms_output.put_line(V_date2);
  /*dbms_output_line("adf");*/
  
end;

declare
  V_name varchar(22); --�������
  V_id NOT NULL number(10):=33; --�����������Ϊ��
  C_pi CONSTANT number(2,10):=3.14159; --������ֵ���ɸ���
  P_id; --����
  Emp;--��
  Emp_recode_type; --������
  Emp_recode; --��¼����
  Emp_cursor ;--�α����
  E_to_many_rows; --�쳣����
begin
  null;
  
end;




DECLARE 
  V_empno number(10):=7698;
  TYPE Emp_record_type IS RECORD(
       V_ename varchar(20):=22,
       V_salary number(10,2)
  );
  testR1 Emp_record_type;
  testR2 Emp_record_type;
  testR3 Emp_record_type;
  testR4 Emp_record_type;
BEGIN
  SELECT ename,sal INTO testR1 FROM emp WHERE empno=V_empno;
  dbms_output.put('asdfasdf');
  dbms_output.put('----asdfasdf');
  dbms_output.put_line('Ա��������' || testR1.V_ename || '   Ա������: ' ||testR1.V_salary);
  SELECT ename,sal INTO testR2 FROM emp WHERE empno=V_empno;
  dbms_output.put_line('Ա��������' || testR2.V_ename || '   Ա������: ' ||testR2.V_salary);
  SELECT ename,sal INTO testR3 FROM emp WHERE empno=V_empno;
  dbms_output.put_line('Ա��������' || testR3.V_ename || '   Ա������: ' ||testR3.V_salary);
  SELECT ename,sal INTO testR4 FROM emp WHERE empno=V_empno;
  dbms_output.put_line('Ա��������' || testR4.V_ename || '   Ա������: ' ||testR4.V_salary);
  
END;

SELECT * FRoM EMP;


--���ò�������
DECLARE
       V_ii number(20);
       V_jj V_ii%TYPE := 250;
       
       TYPE Emp_recode_type IS RECORD(
            V_id emp.empno%TYPE:=7654,
            V_name emp.ename%TYPE,
            v_sal emp.sal%TYPE            
       );
       re Emp_recode_type;
BEGIN
       SELECT empno, ename, sal INTO re
       FROM emp
       WHERE empno=re.V_id;
       dbms_output.put_line('������' || re.V_name || '  нˮ:'|| re.v_sal);
END;

--���ò��ձ���


--���ò��ձ���


--������

SELECT * FROM emp;
DECLARE
  TYPE emp_table_type IS TABLE OF emp%ROWTYPE 
  INDEX BY BINARY_INTEGER;
  tb emp_table_type;
  i number:=1;
BEGIN

   SELECT * BULK COLLECT INTO tb FROM emp;
   dbms_output.put_line(tb.count);
   dbms_output.put_line(tb.first);
   dbms_output.put_line(tb.last);
   dbms_output.put_line(tb.next(2));
   dbms_output.put_line(tb.prior(2));
   LOOP   
        dbms_output.put_line(tb(i).);
        dbms_output.put_line('**************');
        i=i+1;  
        EXIT WHEN  tb.count
   END LOOP;
   
END;




--CASE���

DECLARE
       V_level varchar(20):='&input';
       V_text varchar(20);
BEGIN
       CASE V_level
       WHEN 'A' THEN V_text:='�׵�';
       WHEN 'B' THEN V_text:='�ҵ�';
       WHEN 'C' THEN V_text:='����';
       ELSE V_text:='û�ȼ�';
       END CASE;
       dbms_output.put_line(V_text);
END;

DECLARE
       V_level varchar(20):='&input';
       V_text varchar(20);
BEGIN
       V_text:=CASE V_level
       WHEN 'A' THEN '�׵�'
       WHEN 'B' THEN '�ҵ�'
       WHEN 'C' THEN '����'
       ELSE 'û�ȼ�'
       END;
       dbms_output.put_line(V_text);
END;







--��if else ����ж��Ƿ���1-100֮�䣬����������������������FALSE
--employees 10-50:Ӫ����   60-90���г���  ����90���з���  ���������Ų�����
--��loop��for��whileѭ���ݼ�50-1
--��employees Ա����Ϣ�������� ȡ��emp��7369�Ĺ��ʣ����С��1200���low,С��2000���middle���������high

















