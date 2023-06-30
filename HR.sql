CREATE TABLE CUSTOMER_T (
    고객번호 NUMBER NOT NULL PRIMARY KEY, 
    아이디   VARCHAR2(32 BYTE)  NOT NULL UNIQUE,
    고객명   VARCHAR2(32 BYTE)  NOT NULL,
    직업     VARCHAR2(32 BYTE)  NULL,
    핸드폰   VARCHAR2(11 BYTE)  NULL UNIQUE,
    주민번호 VARCHAR2(13 BYTE)  NULL UNIQUE
);
DROP TABLE CUSTOMER_T;





--문장이 끝나면 ; .
--핸드폰은 숫자타입으로 넣으면 안됨(맨 앞에 0이기 때문에 실행하면 0이 지워짐)
--VARCHAR2 는 텍스트타입.
--위처럼 한 줄에 칼럼 하나씩만.
-- 1byte : 숫자,영어 저장가능
-- 2byte : 한글 저장가능
-- UTF-8 (유니코드는 한글이 3byte 들어감)
--들여쓰기 필수
-- 테이블 만드는 명령어 : CREATE TABLE 테이블이름 (PK키의이름 데이터타입 필수여부 중복여부(키타입), 두번째칼럼부터는기본키지정불가)
--필수여부에 NOT NULL 안 적으면 기본값 NULL 로 인식.
--중복이 없으면 UNIQUE