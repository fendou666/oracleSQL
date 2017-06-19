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
--从一开始， 默认1
START WITH 12
--默认1，
INCREMENT BY 1
--种子数， 最小值为1
MINVALUE 1
--不循环
NOCYCLE
--不缓存
NOCACHE



--插入时间
INSERT INTO EECMSG VALUES(msgSeq.nextval, 170000001,'' ,'神马都是浮云',  
            to_date('2017-05-02 08:22:22','yyyy-mm-dd hh24:mi:ss'));

SELECT MSG_ID, EEC_ID, title, msgContent, msgTime FROM EECMSG WHERE MSG_ID=1;
