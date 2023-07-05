--  < 문자 함수 >

-- 1. 대소문자 변환하기
SELECT UPPER(EMAIL)     -- 모두 대문자
     , LOWER(EMAIL)     -- 모두 소문자
     , INITCAP(EMAIL)   -- 첫 글자만 대문자, 나머지는 소문자
  FROM EMPLOYEES;   -- 사원 테이블에 이메일 있는 걸로 조회함.

-- 2. 글자 수
SELECT FIRST_NAME
     , LENGTH(FIRST_NAME)
  FROM EMPLOYEES;
  
-- 3. 바이트 수
SELECT FIRST_NAME
     , LENGTHB(FIRST_NAME)          --LENGTHB , B는 BYTE.
  FROM EMPLOYEES;
--*영어는 한 글자당 1 BYTE , 한글은 한 글자당 2 BYTE.

--4. 연결하기
--    1) || 연산자 (오라클 전용 연산자이므로 다른 DB에서는 오류가 난다.)
--    2) CONCAT 함수 ( CONCATENATE )  ★ 호환성이 높은 표준함수
--       CONCAT(A, B) : 인수를 2개만 전달할 수 있다.
--       CONCAT(CONCAT(A, B), C) : 인수 3개 이상은 CONCAT 함수 여러 개로 해결한다.

SELECT *
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE CONCAT('515', '%');    --폰넘버가 515로 시작하는 쿼리.
 
SELECT *
  FROM EMPLOYEES
 WHERE EMAIL LIKE CONCAT(CONCAT('%', 'A'), '%'); -- A를 포함('%' || 'A' || '%")  , EMAIL 에 A 라는 단어가 포함된 것들이 전부 나온다.
 
-- 5. 문자열의 일부만 반환하기
SELECT SUBSTR(PHONE_NUMBER, 1, 3)    --SUBSTRING : 문자열의 일부. 전화번호 1번째 글자부터 3글자를 반환 : 첫 3글자.
     , SUBSTR(PHONE_NUMBER, 5)       -- 전화번호 5번째 글자부터 끝까지 반환.
  FROM EMPLOYEES;
  
-- 6. 특정 문자의 위치 반환하기
--    문자의 위치는 1부터 시작한다.
--    못 찾으면 0을 반환한다.
SELECT EMAIL
     , INSTR(EMAIL, 'A')             --INSTRING, EMAIL에서 찾은 문자의 위치.
  FROM EMPLOYEES;
  
-- 7. 바꾸기
SELECT EMAIL
     , REPLACE(EMAIL, 'A', '$')      -- 모든 A를 찾아서 $로 바꾼다.
  FROM EMPLOYEES;
  
-- 8. 채우기
-- 1) LPAD(표현식, 전체폭, 채울문자)  : 왼쪽 채우기
-- 2) RPAD(표현식, 전체폭, 채울문자)  : 오른쪽 채우기
SELECT DEPARTMENT_ID
     , LPAD(DEPARTMENT_ID, 3, 0)
     , RPAD(SUBSTR(EMAIL, 1, 2), 5, '*')
  FROM EMPLOYEES;
  
-- 9. 공백 제거  (트림 : 잘라내다)
SELECT '[' || LTRIM('     HELLO     WORLD     ') || ']'  -- 왼쪽 공백만 제거   :  LTRIM
     , '[' || RTRIM('     HELLO     WORLD     ') || ']'  -- 오른쪽 공백만 제거 :  RTRIM
     , '[' ||  TRIM('     HELLO     WORLD     ') || ']'  -- 양쪽 다 지움       :  TRIM
 FROM DUAL;
  
  
-- 실습.
-- 1. 사원 테이블의 JOB_ID에서 밑줄(_) 앞/뒷 부분 분리 조회하기
-- 예시) IT_PROG  -> PROG
--       글자수    : 7
--       밑줄위치  : 3
--       밑줄 앞 글자수 : 2(밑줄위치 - 1)
--       밑줄 뒤 글자수 : 4(글자수 - 밑줄위치)
SELECT JOB_ID           -- 나
     , SUBSTR(JOB_ID, 1, 2)
     , SUBSTR(JOB_ID, 4, 10)
  FROM EMPLOYEES;
  
SELECT JOB_ID           -- 강사님
     , SUBSTR(JOB_ID, 1, INSTR(JOB_ID, '_') -1)                                           --INSTR(JOB_ID 에서 밑줄을 찾아주세요), 밑줄에서 -1 하면 밑줄 앞글자이다.
     , SUBSTR(JOB_ID, INSTR(JOB_ID, '_') + 1, LENGTH(JOB_ID) - INSTR(JOB_ID, '_'))     --INSTR(JOB_ID 에서 밑줄을 찾아주세요), 밑줄에서 +1 하면 밑줄 앞글자이다.
     , SUBSTR(JOB_ID, INSTR(JOB_ID, '_') + 1)   -- 이렇게 하는 게 윗줄보다 간편함.
  FROM EMPLOYEES;
  
-- 2. FIRST_NAME 과 LAST_NAME을 연결해서 모두 대문자로 바꾼 FULL_NAME 조회하기
SELECT FIRST_NAME                                          -- 첫 번째 방법 : 나
     , LAST_NAME
     , UPPER(FIRST_NAME || ' ' || LAST_NAME)
  FROM EMPLOYEES;
  
SELECT UPPER(CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME))   -- 두 번째 방법 : 강사님
  FROM EMPLOYEES
 ORDER BY EMPLOYEE_ID;
  
