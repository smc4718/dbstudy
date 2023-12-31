--테이블 지우기 생성
DROP TABLE LOGIN_TBL;
DROP TABLE MEMBER_TBL;


--멤버 테이블 생성
CREATE TABLE MEMBER_TBL (
            MEMBER_NO  NUMBER  	              NOT NULL
         ,  ID	       VARCHAR2(30 BYTE)      NOT NULL
         ,  PW         VARCHAR2(30 BYTE)      NOT NULL
         ,  NAME       VARCHAR2(30 BYTE)
         ,  PHONE      VARCHAR2 (15 BYTE) 
         ,  CONSTRAINT PK_MEMBER PRIMARY KEY(MEMBER_NO)
);

--로그인 테이블 생성
CREATE TABLE LOGIN_TBL (
           MEMBER_NO   NUMBER       NOT NULL
         , LOGIN_DATE  DATE
         , CONSTRAINT FK_MEMBER_LOGIN FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER_TBL(MEMBER_NO) ON DELETE CASCADE
);
