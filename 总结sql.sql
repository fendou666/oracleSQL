---½á¹¹
DECLARE

BEGIN

EXCEPTION

END;


select 
                   sss.class_Id,
                   sss.EEC_Id, 
                   sss.EEC_Name,
                   sss.sex,
                   sss.age,
                   sss.email,
                   sss.telephone,
                   sss.role_name 
              from 
              (
              select 
                   case when mod(ss.Lineno,10) =0 then ss.Lineno/10
                        when mod(ss.Lineno,10)!=0 then trunc(ss.Lineno/10)+1 end as pageno,
                        ss.class_Id,
                        ss.EEC_Id, 
                        ss.EEC_Name,
                        ss.sex,
                        ss.age,
                        ss.email,
                        ss.telephone,
                        ss.role_name
              from
                (
                  select row_number() over(order by  u.EEC_Id)  as Lineno,
                         u.class_Id,   
                         u.EEC_Id,
                         u.EEC_Name,
                         u.sex,
                         u.age,
                         u.email,
                         u.telephone,
                         r.role_name  
                    from eecuser u, eecrole r 
                         where u.role_id = r.role_id and u.role_id >= 3004 AND u.role_id <= 3005) ss 
                ) sss 
            where sss.pageno=1;
