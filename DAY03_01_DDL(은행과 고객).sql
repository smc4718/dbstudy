/*
    DDL
    1. Data Definition Language
    2. 데이터베이스 객체를 다루는 언어
    3. 트랜잭션 대상이 아니다. (= 작업을 취소할 수 없다.) = 반드시 한 번에 수행을 다 해줘야 하는 작업.
       ㄴ ex) 은행 이체작업(입출금은 동시에 이루어져야 함, 하나라도 안되면 전체 취소되게 하는 작업이 트랜잭션 처리해줌)
    4. 종류
        1) CREATE   : 생성
        2) ALTER    : 수정
        3) DROP     : 삭제 (테이블과 행,열 모두 삭제)
        4) TRUMCATE : 삭제(내용만 삭제, 테이블과 열은 안 지우고 행만 모두 지워짐)
*/


--테이블 삭제 생성
DROP TABLE CUSTOMER_TBL;
DROP TABLE BANK_TBL;

--뱅크 테이블 생성
CREATE TABLE BANK_TBL (
    BANK_CODE VARCHAR2(20 BYTE) NOT NULL
  , BANK_NAME VARCHAR2(30 BYTE)
  , CONSTRAINT PK_BANK PRIMARY KEY(BANK_CODE)
);

--고객 테이블 생성
CREATE TABLE CUSTOMER_TBL (
    NO        NUMBER               NOT NULL
  , NAME      VARCHAR2(30 BYTE)    NOT NULL
  , PHONE     VARCHAR2(30 BYTE)             UNIQUE
  , AGE       NUMBER                        CHECK(AGE BETWEEN 0 AND 100)
  , BANK_CODE VARCHAR2(20 BYTE)     NOT NULL
  , CONSTRAINT PK_NO        PRIMARY KEY(NO)
  , CONSTRAINT FK_BANK_CUST FOREIGN KEY(BANK_CODE) REFERENCES BANK_TBL(BANK_CODE)
);

--숫자와 숫자 사이, 날짜를 표시할 때 '칼럼이름 BETWEEN ? AND ?' 구문으로 가능

/*
    테이블 수정하기
    1. 칼럼 추가   :  ALTER TABLE 테이블명 ADD    칼럼명 데이터타입 [제약조건]
    2. 칼럼 수정   :  ALTER TABLE 테이블명 MODIFY 칼럼명 데이터타입 [제약조건]
    3. 칼럼 삭제   :  ALTER TABLE 테이블명 DROP COLUMN 칼럼명
    4. 칼럼 이름   :  ALTER TABLE 테이블명 RENAME COLUMN 기존칼럼명 TO 신규칼럼명
    5. 테이블 이름 :  ALTER TABLE 테이블명 RENAME TO 신규테이블명
    6. PK/FK 제약조건
        1) PK 
            (1) 추가
                ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 PRIMARY KEY(칼럼)
                *ADD까지만 새롭고 뒤에는 원래 쓰던 CONSTRAINT 문법.
            (2) 삭제
                ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명
                ALTER TABLE 테이블명 DROP PRIMARY KEY
                *PK에만 삭제방법이 2가지다. PK는 칼럼당 1개이기 떄문.
        2) FK
            (1) 추가
                ALTER TABLE 자식테이블명 ADD CONSTRAINT 제약조건명 FOREIGN KEY(칼럼) REFERENCES 부모테이블(참조할칼럼)
            (2) 삭제
                ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명
            (3) 일시중지
                ALTER TABLE 테이블명 DISABLE CONSTRAINT 제약조건명
            (4) 활성화
                ALTER TABLE 테이블명 ENABLE CONSTRAINT 제약조건명
                *영어단어가 하나씩만 바뀐다. (ADD, DROP, DISABLE, ENABLE)
                
                *제약조건명은 해당 기능이 적용될 칼럼명.
*/

-- 실습.

-- 1.은행 테이블에 연락처(BANK_TBL) 칼럼을 추가하시오.
ALTER TABLE BANK_TBL ADD BANK_TEL VARCHAR2(15 BYTE) NOT NULL;

-- 2. 은행 테이블의 은행명(BANK_NAME) 칼럼의 데이터타입을 VARCHAR2(15 BYTE)로 변경하시오.
ALTER TABLE BANK_TBL MODIFY BANK_NAME VARCHAR2(15 BYTE);

-- 3. 고객 테이블의 나이(AGE) 칼럼을 삭제하시오.
ALTER TABLE CUSTOMER_TBL DROP COLUMN AGE;

-- 4. 고객 테이블의 고객번호(NO) 칼럼명을 CUST_NO로 변경하시오.
ALTER TABLE CUSTOMER_TBL RENAME COLUMN NO TO CUST_NO;

-- *개발자가 테이블의 구조를 바꿀 일은 거의~~~없다. (ALTER 쓸 일 없음. 있다는 정도만 알아두기)


-- 5. 고객 테이블에 GRADE 칼럼을 추가하시오. (VIP , GOLD , SILVER , BRONZE 중 하나의 값을 가지도록 한다.) - CHECK 제약조건
ALTER TABLE CUSTOMER_TBL ADD GRADE VARCHAR2(6 BYTE) CHECK(GRADE = 'VIP' OR GRADE = 'GOLD' OR GRADE = 'SILVER' OR GRADE = BRONZE);
                                                            *작은따옴표 필수
ALTER TABLE CUSTOMER_TBL ADD GRADE VARCHAR2(6 BYTE) CHECK(GRADE IN('VIP' , 'GOLD' , 'SILVER' , 'BRONZE'));
                                                            *두 가지 방법 다 공부. IN() 구문이 깔끔하니 권장함.
                                                            *둘 중 하나만 실행해야함 (같은 거라서)


-- 6. 고객 테이블의 고객명(NAME)과 연락처(PHONE) 칼럼 이름을 CUST_NAME, CUST_PHONE 으로 변경하시오.
ALTER TABLE CUSTOMER_TBL RENAME COLUMN NAME  TO CUST_NAME;
ALTER TABLE CUSTOMER_TBL RENAME COLUMN PHONE TO CUST_PHONE;

-- 7. 고객 테이블의 연락처(CUST_PHONE) 칼럼을 필수 칼럼으로 변경하시오. (필수 바꾸려면 NOT NULL 주면 된다.)
ALTER TABLE CUSTOMER_TBL MODIFY CUST_PHONE VARCHAR2(30 BYTE) NOT NULL;
-- *문법상 데이터타입과 크기는 꼭 적어주어야 한다.

-- 8. 고객 테이블의 고객명(CUST_NAME) 칼럼의 필수 제약조건을 없애시오.
ALTER TABLE CUSTOMER_TBL MODIFY CUST_NAME VARCHAR2(30 BYTE) NULL;
-- *문법상 데이터타입과 크기는 꼭 적어주어야 한다. (NULL이면 NULL도 반드시 명시해주어야 한다.)
-- *CREATE 에서는 안 적으면 NULL인데, ALTER에서는 안 적으면 안 바꾼다는 뜻이기 때문에 NULL, NOT NULL 중 명시해줘야 한다.

-- 테이블 구조 확인하기
DESCRIBE BANK_TBL;
DESC CUSTOMER_TBL;
-- (DESCRIBE : 설명하다)
-- DESC BANK_TBL; , DESCR BANK_TBL; , DESCRI BANK_TBL; , DESCRIB BANK_TBL;  = 최대 4글자까지 줄여서 사용가능




















