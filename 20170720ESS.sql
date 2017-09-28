--�˻���Ϣ-sret-Ф����
create table sales_return(
       sret_id number(9) primary key,
       sret_slo_id number(9),
       sret_description varchar(50),
       sret_sum number(12),
       sret_returnState varchar(20),
       sret_updateTime date,
       sret_updatePerson number(9),
       sret_addTime date,
       sret_addPerson number (9),
       sret_isDelete number(1)
);

--�ͻ���Ʒ�ɽ��۸��¼��-ckr-ţ����
create table CustomerKnockdownRecord (
       ckr_id number(9),
       ckr_slo_id number(9),
       ckr_pr_id number(9),
       ckr_pr_discount Number(3,2),
       ckr_pr_monetary number(12),
       ckr_pr_closingDate Date,
       ckr_update_Time Date,
       ckr_update_Person number(9),
       ckr_addTime Date,
       ckr_addPerson number(9),
       ckr_isdelete number(1) 
);


-- ��ˮ��-����
Create table journal_account (
       jat_id number(9) primary key,
       jat_or_id number(9),
       jat_pt_id number(9),
       jat_pr_id number(9),
       jat_standard varchar(15),
       jat_unit varchar(10),
       jat_num number(9),
       jat_st_price number(9),
       jat_se_price number(9),
       jat_add number(9),
       jat_profit number(9)
);

--���۶�����-��˧
CREATE TABLE sell_orders(
       slo_id        number(9) primary key,
       slo_sdo_id    number(9),
       slo_status    varchar(20),
       slo_em_id     number(9),
       slo_type      number(1),
       slo_lk_id     number(9),
       slo_sret_id   number(9),
       slo_jat_id     number(9),
       slo_pro_totle_price    number(12),
       slo_sell_totle_money  number(12),
       slo_push_money        number(12),
       slo_profit            number(12),
       slo_update_Time      date,
       slo_update_Person    number(9),
       slo_addTime          date,
       slo_addPerson        number(9),
       slo_isdelete          number(1)
);
--������ϸ��-��˧
CREATE TABLE sell_detail_orders(
       sdo_id       number(9) primary key,
       sdo_slo_id   number(9),
       sdo_st_id    number(9),
       sdo_pro_id    number(9),
       sdo_pro_num   number(9),
       sdo_update_Time      date,
       sdo_update_Person    number(9),
       sdo_addTime          date,
       sdo_addPerson        number(9),
       sdo_isdelete number(1)
)



