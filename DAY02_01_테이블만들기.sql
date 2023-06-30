/*
   < 테이블(table) >
    1. 데이터베이스에서 데이터를 저장하는 객체
    2. 표 형식을 가진다.
    3. 행(row)과 열(column)의 집합 형태이다.
*/

/*
    데이터 타입
    1. NUMBER (p,s) : p = 정밀도 , s = 스케일 로 표현하는 숫자 형식
        1) 정밀도 p  : 전체 유효 숫자의 갯수 (1, 01, 001 -> 이 중에서 의미 있는 숫자는 1밖에 없기 때문에 유효 숫자 갯수는 1개씩이다. 0.99같은 숫자도 정밀도는 2이다(앞에 0빼고 뒤에 유효 숫자 갯수로 봄, 1이 안넘는 0.99까지 가능)
        2) 스케일 s  : 소수부의 유효 숫자의 갯수 (소수점만 따로 유효 숫자의 갯수를 셈) (0.1  0.01  0.10 -> 1  2  1 개다)
    2. CHAR(size)   : 고정 문자(character) 타입.
        1) 글자 수가 고정된 타입(예시 : 핸드폰번호, 주민번호 등)
        2) size : 최대 2000 byte 까지 저장 가능.
    3. VARCHAR2(size) : 가변 문자
        1) 글자 수가 고정되지 않은 타입(예시 : 이름, 이메일, 주소 등)
        2) size : 최대 4000 byte 까지 저장 가능.
        *CHAR 보다는 주로 VARCHAR2 를 많이 씀.
    4. CLOB : 큰 텍스트 (VARCHAR2 로 크기가 안될 것 같으면 CLOB 으로 함)
    5. DATE : 날짜와 시간을 동시에 표현하는 타입(년, 월, 일, 시, 분, 초)
    6. TIMESTAMP : 날짜와 시간을 동시에 표현하는 타입(년, 월, 일, 시, 분, 초, 마이크로초:백만분의 1초 )
*/

/*
    제약조건 5가지
    1. NOT NULL    : 필수
    2. UNIQUE      : 중복 불가
    3. PRIMARY KEY : 기본키
    4. FOREIGN KEY : 외래키
    5. CHECK       : 값에 제한을 건다.

*/

-- 고객 테이블
DROP TABLE CUSTOMER_T;
CREATE TABLE CUSTOMER_T (
      NO       NUMBER            NOT NULL PRIMARY KEY 
    , ID       VARCHAR2(32 BYTE) NOT NULL UNIQUE
    , NAME     VARCHAR2(32 BYTE) NOT NULL
    , JOB      VARCHAR2(32 BYTE)     NULL
    , PHONE    CHAR(13 BYTE)     NOT NULL UNIQUE      --하이픈 포함
    , JUBUN    CHAR(14 BYTE)         NULL UNIQUE      --하이픈 포함
);
--(각 칼럼마다 ,(콤마)의 위치는 칼럼시작할 때 맨 앞에 적어줘도 된다.)
--글자 수 고정이면 CHAR 로 써주면 메모리 효율 좋음.
--★이전에 만들어 놓은 테이블이 있을 수 있기에, 항상 첫 줄에 DROP TABLE 적어주고 작업 시작.(처음 한 번은 오류나고 생성됨)














