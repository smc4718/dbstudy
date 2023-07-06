-- < 오라클 조인 문법 >
-- 내부 조인

-- 1. 사원번호, 사원명, 부서번호, 부서명을 조회하시오. (사원번호-사원명은 사원테이블, 부서번호-부서명은 부서테이블)
-- 보고 싶은 게 두 테이블에 나누어져 있으면 100% 조인
SELECT E.EMPLOYEE_ID        --일반적으로 모두 오너를 적어준다.
     , E.FIRST_NAME
     , E.LAST_NAME
     , D.DEPARTMENT_ID      -- 2개의 테이블에 모두 있는 칼럼(이름이 같은 칼럼)은 반드시 테이블에 오너를 명시해야 한다. 
     , D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E           -- INNER JOIN 대신 콤마(,)를 사용한다.
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID;   -- ON 대신 WHERE를 사용한다. 
--(PK-FK 의 칼럼을 두 개 적어준다.) 테이블 OWNER 명시하는 것이 반드시 중요하다. (테이블 별명)
--SELECT 절에 있는 동일한 칼럼에도 별명을 붙여주어야 한다. (칼럼 이름이 같다면 두 테이블 중 어느 OWNER 명시여도 상관 없다. D든 E든 상관 없음.)

-- 2. 사원번호, 사원명, 직업, 직업별 최대 연봉, 직업별 최소연봉을 조회하시오.
SELECT E.EMPLOYEE_ID
     , E.FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME
     , J.J.JOB_ID
     , E.SALARY
     , J.MAX_SALARY
     , J.MIN_SALARY
  FROM JOBS J,EMPLOYEES E
 WHERE J.JOB_ID = E.JOB_ID;
    
-- 외부 조인

-- 3. 모든 사원번호(부서가 없는 사원도 포함), 사원명, 부서번호, 부서명을 조회하시오.
SELECT EMPLOYEE_ID
     , FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E -- RIGHT : 오른쪽 테이블(EMPLOYEES)의 모든 데이터를 조회하시오.(부서번호가 없는 사원도 조회하시오.라는 뜻)
 WHERE D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID;         -- 왼쪽, 오른쪽 구분해서 적어주면 된다.
                                            --오라클 조인문법은 RIGHT OUTER JOIN은 반대방향(LEFT)에 (+)를 추가한다. 
-- 4. 사원번호, 사원명, 부서번호, 부서명을 조회하시오. 사원이 근무하지 않는 유령 부서도 조회하시오.
SELECT EMPLOYEE_ID
     , FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E -- LEFT : 왼쪽 테이블 - 부서테이블을 조회하면 : (사원이 근무하지 않는 부서도 조회하시오. = 유령부서들이 나옴.)
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID(+);  --LEFT OUTER JOIN 은 반대방향(RIGHT)에 (+)를 추가한다.
    
-- FROM 1 : M    <-- ★일대다관계에서는 FROM절 순서는 1이 앞에 오는 게 좋다. (성능이 좋아짐) , 원래 순서는 상관 없음.


-- 3개 이상 테이블 조인하기

-- 5. 사원번호, 사원명, 부서번호, 부서명, 근무지역을 조회하시오.
SELECT EMPLOYEE_ID
     , FIRST_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID
     , DEPARTMENT_NAME
     , L.LOCATION_ID
     , CITY
  FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E
 WHERE L.LOCATION_ID = D.LOCATION_ID 
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;                   
   
    
-- 6. 부서번호, 부서명, 근무도시, 근무국가를 조회하시오.
SELECT DEPARTMENT_ID
     , DEPARTMENT_NAME
     , CITY
     , C.COUNTRY_NAME
  FROM COUNTRIES C, LOCATIONS L, DEPARTMENTS D
 WHERE C.COUNTRY_ID = L.COUNTRY_ID
   AND L.LOCATION_ID = D.LOCATION_ID;

