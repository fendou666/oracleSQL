CREATE TABLE EECMSG(
       MSG_ID number(10) primary key not null,
       EEC_ID number(10)  not null,
       title varchar(50) ,
       msgContent varchar2(2000) not null,
       msgTime date not null,
       constraint FK_EEC_ID foreign key(EEC_ID)
       references EECUSER(EEC_ID) on delete set null
);

CREATE SEQUENCE msgSeq
--��һ��ʼ�� Ĭ��1
START WITH 12
--Ĭ��1��
INCREMENT BY 1
--�������� ��СֵΪ1
MINVALUE 1
--��ѭ��
NOCYCLE
--������
NOCACHE



--����ʱ��
INSERT INTO EECMSG VALUES(msgSeq.nextval, 170000001,'' ,'�����Ǹ���',  
            to_date('2017-05-02 08:22:22','yyyy-mm-dd hh24:mi:ss'));

SELECT MSG_ID, EEC_ID, title, msgContent, msgTime FROM EECMSG WHERE MSG_ID=1;
