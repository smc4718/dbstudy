/*
    NULL 처리 함수
    1. NVL :NULL VALUE의 약자,  NVL(표현식, 표현식의 결과가 NULL인 경우에 사용할 값)
    2. NVL2(표현식, 표현의 결과가 NULL이 아닌 경우에 사용할 값, 표현식의 결과가 NULL인 경우에 사용할 값)
*/
-- 1. 사원 테이블에서 사원번호와 부서번호를 조회하기
-- 부서번호가 없는 경우에는 0으로 조회하기
SELECT EMPLOYEE_ID, NVL(DEPARTMENT_ID, 0)      --NULL값이 있을시 0으로 조회를 해달라.
  FROM EMPLOYEES;
  
--NULL값으로 되있으면 서비스시 문제가 될 수 있기에 0 으로 값을 바꿔주면 좋다.

-- 2. 사원 테이블에서 모든 사원들의 실제 커미션 조회하기
-- 커미션 = 연봉 * 커미션퍼센트
SELECT EMPLOYEE_ID, SALARY * COMMISSION_PCT AS COMMISSION           --연산자에 NULL 이 포함되면 결과값도 NULL 이 된다.
  FROM EMPLOYEES

-- 커미션을 받지 않는 경우 0으로 조회하기
SELECT EMPLOYEE_ID
     , NVL(SALARY * COMMISSION_PCT, 0) AS COMMISSION1     --첫 번째 방법
     , SALARY * NVL(COMMISSION_PCT, 0) AS COMMISSION2     --두 번째 방법
  FROM EMPLOYEES

