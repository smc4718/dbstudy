/*
- 게시판 : 게시글들을 저장
- 회원 : 회원들을 저장

공감(좋아요) - DB설계 : 회원테이블 , 공감테이블 , 게시글테이블  = 다대다관계
게시글과 게시글안에 그림도 일대다관계이다.
*/

DROP TABLE STR_R;
DROP TABLE JOAYO_J;
DROP TABLE BLOGER_B;

CREATE TABLE BLOGER_B (
    B_NO NUMBER            NOT NULL
 ,  NAME VARCHAR2(10 BYTE) NOT NULL
 ,  CONSTRAINT PK_B_NO PRIMARY KEY(B_NO)
);

CREATE TABLE JOAYO_J (
    JOAYO_NO NUMBER  NOT NULL
  , H_NO     NUMBER  NOT NULL
  , G_NO     NUMBER  NOT NULL 
  , CONSTRAINT PK_JOAYO PRIMARY KEY(JOAYO_NO)
  , CONSTRAINT FK_H_NO  FOREIGN KEY(H_NO) REFERENCES BLOGER_B(B_NO) ON DELETE CASCADE
);

CREATE TABLE STR_R (
    STR_NO NUMBER NOT NULL
  , STR_ST NUMBER NOT NULL
  , CONSTRAINT PK_STR PRIMARY KEY(STR_NO)
  , CONSTRAINT FK_STR_ST FOREIGN KEY(STR_ST) REFERENCES JOAYO_J(JOAYO_NO) ON DELETE CASCADE
);

--★★FK 는 오직 PK가 있는 칼럼이랑만 연결 가능. EX)외래키 지정할 칼럼 정하고, 받아올 부모키 테이블은 무조건 PK적힌 칼럼이름으로 넣어야 함.
