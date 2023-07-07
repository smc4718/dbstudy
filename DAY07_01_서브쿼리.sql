/*
    서브쿼리(sub query)
    1. 메인 쿼리에 포함되는 하위 쿼리를 서브쿼리라고 한다.
    2. 서브쿼리를 먼저 실행해서 그 결과를 메인쿼리에 전달한다.
    3. 종류
        1) SELECT 절 : 스칼라 서브쿼리
        2)   FROM 절 : 인라인 뷰 (INLINE VIEW)
        3)  WHERE 절 : 단일 행 서브쿼리 (결과가 1개)
                       다중행 서브쿼리  (결과가 N개)
*/

/*
    단일 행 서브쿼리(single row sub query)
    1. 결과가 1행이다. (1개이다.)
    2. 단일 행 서브쿼리인 경우
        1) WHERE 절에서 사용한 칼럼이 PK 또는 UNIQUE 칼럼인 경우
        2) 통계 함수를 사용한 경우.  EX) SELECT COUNT(*) FROM EMPLOYEES = 총 107개라는 행 하나만 나온다.
    3. 단일 행 서브쿼리 연산자
        =, !=, >, >=, <, <=
        
    다중 행 서브쿼리(multiple row sub query)       --★단일행이 아니면, 무조건 다중행이다.
    1. 결과가 N행이다. (결과가 여러 값)
    2. 다중 행 서브쿼리 연산자
        IN, ANY, ALL 등
    
*/
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 50  <-- 단일형 서브쿼리.
 
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN(50, 60);   <-- 값이 2개, 다중행 서브쿼리 연산자를 IN으로 연결한 것.

--우리가 쓰던 연산자 그대로 가져다 씀.


/* WHERE 절의 서브쿼리 */

-- 1. 사원번호가 101인 사원의 직업과 동일한 직업을 가진 사원을 조회하시오.
-- SELECT *
-- FROM EMPLOYEES
-- WHERE JOB_ID = (사원번호가 101인 사원의 직업);

SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = (SELECT JOB_ID 
                   FROM EMPLOYEES 
                  WHERE EMPLOYEE_ID = 101);   -- 단일행 서브쿼리임을 아는 법은 ' = ' 부호와 앞에 테이블을 통해 알 수 있다. (EMPLOYEE_ID는 중복이 없다. PK이기 때문).
 --서브쿼리 괄호는 넣어도 되고 안 넣어도 된다. 기본적으로는 많이들 넣음.
--메인쿼리의 비교대상과 서브쿼리의 비교대상은 같아야 한다. ( ' * '는 불가 )

-- 2. 부서명이 'IT'인 부서에 근무하는 사원 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT');  --틀린 답 , 데이터를 볼 필요X , 칼럼의 속성을 봐야함 : PK나 UNIQUE가 아니면 값이 여러 개일 수 있다.
                                                                                              --값이 여러 개라면 단일행이 아니기 때문에 ' = ' 등호가 아니라 다중행으로 작성해줘야함. (IN 등등)
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME IN('IT')); --옳은 답 , 서브쿼리의 DEPARTMENT_NAME 은 중복이 있을 수 있으므로 다중행 서브쿼리로 한다.

-- 3. 'seattle'에서 근무하는 사원 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                          FROM DEPARTMENTS 
                         WHERE LOCATION_ID IN (SELECT LOCATION_ID
                                                 FROM LOCATIONS
                                                WHERE CITY = 'Seattle'));
-- 서브쿼리에서 값이 여러개라면 메인쿼리도 다 다중행식으로 바꿔주어야 한다.

-- 연봉 가장 높은 사람 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEES);

-- 5. 가장 먼저 입사한 사원 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE)    --날짜도 숫자여서 옛날이면 작은 수의 값 'MIN'
                      FROM EMPLOYEES);
 
-- 6. 평균 연봉 이상을 받는 사원 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= (SELECT AVG(SALARY)
                   FROM EMPLOYEES);


/* (★★) FROM 절의 서브쿼리 */
--원래는 구문이 ' FROM 테이블 인데 '  , ' FROM 뷰(SELECT) ' 로 적는다. 쿼리문만으로 테이블을 만드는 것을 '뷰'라고 부르고, FROM 안에 있다고 해서 '인라인 뷰'라고 한다.
--인라인 뷰를 넣는 주된 이유 중에 하나는 실행순서이다. FROM절은 실행순서가 1번이라서 가장 먼저 실행시키기 위해 인라인 뷰를 쓴다. 
--그래서 정렬을 먼저 하고 싶을 때 인라인 뷰를 쓴다.(ORDER BY는 언제나 실행순서가 꼴등이기 때문에 정렬을 먼저 할 방법이 없어서 인라인 뷰를 씀).
--EX) 페이지 만들 때 각 페이지마다 몇개의 목록을 나타낼 것인가 할 때 = 목록을 만들 때 정렬을 먼저하고 몇 개씩 잘라내서 나타냄.

-- CRUD : CREATE(INSERT) , READ(SELECT) , UPDATE , DELETE  = 학원 최종목표


-- 1. 연봉이 3번째로 높은 사원 조회하기
--    1) 높은 연봉 순으로 정렬한다.           1)과 2가 서브쿼리가 된다. 'ROW_NUMBER()' = 행 번호 붙이기 함수.
--    2) 정렬 결과에 행 번호를 붙인다.
--    3) 행 번호 3을 가져온다.

--실행순서가 안 맞아서 틀린 구문 ↓
SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 행번호, EMPLOYEE_ID  
  FROM EMPLOYEES;
 WHERE 행번호 = 3;
 
SELECT 행번호, EMPLOYEE_ID
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 행번호, EMPLOYEE_ID     --행번호 SELECT 구문을 FROM 절에 미리 갖다 놔서 FROM 절에서 행번호를 먼저 실행했기에 아래 행번호 3이 동작함.  
          FROM EMPLOYEES)
 WHERE 행번호 = 3;
 
 
-- 2. 연봉 11 - 20번째 사원 조회하기  (목록 가지고 오는 쿼리문)
SELECT RN, EMPLOYEE_ID
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS RN, EMPLOYEE_ID
          FROM EMPLOYEES)
 WHERE RN BETWEEN 11 AND 20; 
 
-- 3. 21 ~ 30번째로 입사한 사원 조회하기
SELECT EMPLOYEE_ID
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY HIRE_DATE ASC) AS RN, EMPLOYEE_ID      -- 이와 같이 로우넘버 써주고 뒤에 어떤 칼럼에 로우넘버를 적용할지 칼럼이름을 적어준다.
          FROM EMPLOYEES)
 WHERE RN BETWEEN 21 AND 30;
 

/* SELECT 절의 서브쿼리 */

-- 부서번호가 50인 부서에 근무하는 사원번호, 사원명, 부서명 조회하기
SELECT EMPLOYEE_ID   --(비상관쿼리)
     , FIRST_NAME
     , LAST_NAME
     , (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTS
         WHERE DEPARTMENT_ID = 50) AS DEPT_NAME
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 50;                          -- 메인과 서브쿼리가 상관 없을 때, '비상관쿼리'
 
 
SELECT E.EMPLOYEE_ID  --(상관쿼리)
     , E.FIRST_NAME
     , E.LAST_NAME
     , (SELECT D.DEPARTMENT_NAME
          FROM DEPARTMENTS D
         WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
           AND D.DEPARTMENT_ID = 50)
  FROM EMPLOYEES E;                                 -- 메인과 서브쿼리가 상관 있을 때, '상관쿼리'
                                                    -- 이 방법을 권장하나 서브쿼리중에서 스칼라 서브 쿼리는 성능은 떨어지는 편.
                                                    


























