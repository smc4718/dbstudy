-- < 형변환 함수 >

--연산결과도 조회이다. SELECT 를 써야함.

      --오라클만의 문제 : 오라클은 FROM 절의 테이블이 필요하다.
-- ' DUAL ' 은 테이블인데, 이름만 가지고 있고 아무것도 가지고 있지 않다. 
--(연산에는 FROM 절이 필요 없지만 오라클은 테이블이 필요하니 임의로 하나 쓰라고 만들어진 빈 테이블이 DUAL 이다. )

SELECT 1+1 FROM DUAL;
CREATE SEQUENCE TEST_SEQ ORDER;
SELECT TEST_SEQ.NEXTVAL FROM DUAL;


/*
    DUAL 테이블
    1. DUMMY 칼럼 1개를 가지고 있는 테이블이다.
    2. 'X' 값을 가지고 있다.
    3. FROM절이 필요 없는 SELECT 문을 사용할 때 DUAL 테이블을 이용한다.
*/

----------------------------------------------

-- 데이터타입 변환 : 숫자, 날짜, 문자 들의 데이터타입을 바꿈

/* 
    1. 문자-> 숫자로 변환하기 
        TO_NUMBER(문자)
*/
SELECT TO_NUMBER('999')
  FROM DUAL;


/*
    2. 숫자 -> 문자로 변환하기
        TO_CHAR(숫자,[형식])        -- ' [형식] ' 은 생략할 수도 있다.
*/
SELECT TO_CHAR(1234)
     , TO_CHAR(1234, '999999')   -- '1234'   = 9가 6개이니 실행시 숫자를 6자리로 나타내라 -> 그래서 결과값에 1234 앞에 공백 2칸이 있다 = 총6칸.
     , TO_CHAR(1234, '000000')   -- '001234' = 9가  6개이니 실행시 숫자를 6자리로 나타내라 -> 결과값 : 001234
     , TO_CHAR(1234, '9,999')    -- 1,234  세자리 쉼표가 붙게 된다. (천 단위 구분 기호)
     , TO_CHAR(12345, '9,999')  -- '######' 숫자는 5자리인데, 형식은 4자리만 지정되었다.
     , TO_CHAR(12345, '99,999')  -- 12,345
  FROM  DUAL;
  
--*함수는 이해만 하고 가자 , 암기X


/*
    3. 날짜 -> 문자로 변환하기
        TO_CHAR(날짜,[형식])
        
        * 날짜/시간 형식
        1) YY       : 년도 2자리
        2) YYYY     : 년도 4자리
        3) MM       : 월 2자리 (01~12)
        4) DD       : 일 2자리 (01~31)
        5) AM       : 오전 / 오후               => 5) , 6) 둘이 셋트다.
        6) HH       : 12시간(01~12)
        7) HH24     : 24시간(00~23)
        8) MI       : 분(00~59)   , MINUTE
        9) SS       : 초(00~59)   , SECOND
*/
SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
  FROM EMPLOYEES;
        
/*
    4. 문자 -> 날짜로 변환하기.
    TO_DATE(문자, [형식])           --'[생략가능] '
*/
        
-- 현재 날짜와 시간
SELECT SYSDATE          --'23/07/04'
     , SYSTIMESTAMP     --'23/07/04 14:46:44.303000000 +09:00'      --TIMESTAMP : 1/1000 초마다 1초씩 증가되게 한 시간프로그램인데, 아직까지 세어지고 있음.
  FROM DUAL;
        
-- 현재 날짜와 시간 - 형식 지정
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH:MI:SS')              --SYSDATE : 날짜뿐만 아니라 시간도 함께 계산되서 나온다. 다만 기본값은 날짜만 나온다.
     , TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')
  FROM DUAL;
  
-- 문자로 된 날짜/시간을 실제 날짜/시간 타입으로 변환하기
SELECT TO_DATE('23/07/04')              -- 오라클 기본 날짜형식은 '년/월/일' 형식으로 해석된다.
     , TO_DATE('23/07/04', 'DD/MM/YY')  -- '일/월/년' 형식으로 해석하라고 해석법을 지정해줄 수 있다.
  FROM DUAL;
  
        
-- 예제 데이터 작성
DROP TABLE EXAMPLE_T;
CREATE TABLE EXAMPLE_T (
    DT1 DATE
  , DT2 TIMESTAMP
);
INSERT INTO EXAMPLE_T(DT1, DT2) VALUES(SYSDATE, SYSTIMESTAMP);
COMMIT;

-- DT1 이 '23/07/04'인 데이터를 조회하기(실행 안 됨)
SELECT * 
  FROM EXAMPLE_T;
 WHERE DT1 = '23/07/04';

-- DT1 이 '23/07/04' 인 데이터를 조회하기(실행 안 됨)
SELECT *
  FROM EXAMPLE_T
 WHERE DT1 = TO_DATE('23/07/04', 'YY/MM/DD');
 
-- DT1 이 '23/07/04'인 데이터를 조회하기(됨)
SELECT *
  FROM EXAMPLE_T
 WHERE TO_DATE(DT1, 'YY/MM/DD') = TO_DATE('23/07/04', 'YY/MM/DD')
 --★날짜 DATE는 비교할 때 'TO_DATE' 를 그냥 다 넣기.
       


        
        
        
        
        
    