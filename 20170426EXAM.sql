CREATE TABLE menu (订单号 number(10), 
                    菜品名 varchar(20), 
                    菜品单价 number(6,2), 菜品数量 number(5));
INSERT INTO menu VALUES(1,'鱼香肉丝',25.5,3);
INSERT INTO menu VALUES(1,'宫保鸡丁',30,2);
INSERT INTO menu VALUES(1,'水煮肉片',32.5,1);
INSERT INTO menu VALUES(2,'回锅肉',18,1);
INSERT INTO menu VALUES(2,'沸腾鱼',36.5,2);

SELECT SUM(菜品单价*菜品数量) FROM menu WHERE 订单号=1;


--如果是最低工资，将最低工资提高200；
--如果是基本工资在最低工资200以上400以内,将基本工资提高100
--的预算结果以部门编号，部门名，员工编号，员工姓名，工资信息一栏的形式做返回

SELECT e.department_id, d.department_name, e.employee_id, e.salary , 'ss'
FROM employees e, departments d
WHERE  e.department_id=d.department_id AND e.department_id=50;

SELECT e.department_id, d.department_name, e.employee_id, e.salary, minsal.mins    
FROM employees e, departments d, (SELECT MIN(salary) mins FROM  employees  WHERE department_id=50) minsal
WHERE  e.department_id=d.department_id AND e.department_id=50;


SELECT e.department_id, d.department_name, e.employee_id, e.salary, 
       CASE 
       WHEN e.salary = minsal.mins THEN
            e.salary +200
       WHEN e.salary > (minsal.mins +200) AND e.salary < (minsal.mins +400) THEN
            e.salary +100
       ELSE e.salary
       END AS newsal
  
FROM employees e, departments d, (SELECT MIN(salary) mins FROM  employees  WHERE department_id=50) minsal
WHERE  e.department_id=d.department_id AND e.department_id=50;


/*CASE 
       WHEN e.sal = MIN(e.sal) THEN
            e.sal +200
       WHEN e.sal > (MIN(e.sal) +200) AND e.sal < (MIN(e.sal) +400) THEN
            e.sal +100
       ELSE e.sal
       END AS newsal*/

CREATE OR REPLACE PACKAGE saladdp





CREATE OR REPLACE FUNCTION salAdd(dptno employees.department_id%TYPE, errStr OUT varchar)
RETURN sys_refcursor
AS
       rec sys_refcursor;
       aa number(10);
BEGIN
       errStr:='';
       aa:=11/0;
       OPEN rec FOR SELECT e.department_id, d.department_name, e.employee_id, e.salary, 
       CASE 
       WHEN e.salary = minsal.mins THEN
            e.salary +200
       WHEN e.salary > (minsal.mins +200) AND e.salary < (minsal.mins +400) THEN
            e.salary +100
       ELSE e.salary
       END AS newsal
  
       FROM employees e, departments d, (SELECT MIN(salary) mins FROM  employees  WHERE department_id=dptno) minsal
       WHERE  e.department_id=d.department_id AND e.department_id=dptno;       

       return rec;
EXCEPTION
       WHEN others THEN
              errStr:=sqlerrm;
              return null;       
END;

CREATE OR REPLACE procedure addSalp(rec out sys_refcursor, 
                                        dptno employees.department_id%TYPE, 
                                        errStr OUT varchar)
AS
BEGIN
       rec := salAdd(dptno, errStr);
EXCEPTION 
       WHEN others THEN 
              errStr :=sqlerrm;
              rec :=null;
END;









