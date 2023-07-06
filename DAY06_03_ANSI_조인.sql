/*
    조인
    
    1. 2개 이상의 테이블을 한 번에 조회하는 방식이다.
    2. 각 테이블의 관계(1:M)를 이용해서 조인 조건을 만든다.
    3. 조인의 종류
        1) 내부 조인 : 2개 테이블에 모두 존재하는 데이터만 조회하는 방식
        2) 외부 조인 : 2개 테이블에 모두 존재하지 않더라도 조회하는 방식
        
        회원      구매
        1  a      1 a 새우깡
        2  b      2 a 맛동산
        3  c      3 b 새우깡
           1   :    M
        구매내역을 뽑아보자(내부 조인)    ㅣ  구매내역이 없는 사람도 포함해서 구매내역을 뽑아보자(외부 조인)
        a 새우깡                          ㅣ   a 새우깡 
        a 맛동산                          ㅣ   a 맛동산  
        b 새우깡                          ㅣ   b 새우깡  
                                               c null
                                    *구매를 왜 안했는지 파악하기 위해서 회원 정보를 가져오기 위해 '외부 조인' 이 너무 중요함.
                                             
      *내부,외부 조인중 어떤 걸 써야하는지 판단하는 게 가장 중요하다.                                                                                      
*/

/*
    드라이브(운전하는 테이블 VS 드리븐(운전 당하는) 테이블
    
    1. 드라이브 테이블
        1) 조인 관계를 처리하는 메인 테이블
        2) 1:M 관계에서 1에 해당하는 테이블
        3) 일반적으로 데이터의 갯수가 적다.
        4. PK를 조인 조건으로 사용하기 때문에 인덱스(INDEX) 사용이 가능하다. (빠르다는 의미)
    2. 드리븐 테이블
        1) 1:M관계에서 M에 해당하는 테이블
        2) 일반적으로 데이터의 갯수가 많다.
        3) FK를 조인 조건으로 사용하기 때문에 인덱스(INDEX) 사용이 불가능하다. (느리다는 의미)
    3. 드라이브 테이블을 드리븐 테이블보다 먼저 작성하면 성능에 도움이 된다. (드라이브 테이블 못 찾겠으면 그냥 순서 상관 없이 써라)
    *현실에서는 일이 많아서 최적화 할 시간이 없다.
*/

-- 내부 조인

-- 1. 사원번호, 사원명, 부서번호, 부서명을 조회하시오. (사원번호-사원명은 사원테이블, 부서번호-부서명은 부서테이블)
-- 보고 싶은 게 두 테이블에 나누어져 있으면 100% 조인
SELECT EMPLOYEE_ID
     , FIRST_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID      -- 2개의 테이블에 모두 있는 칼럼(이름이 같은 칼럼)은 반드시 테이블에 오너를 명시해야 한다. 
     , DEPARTMENT_NAME
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;    
--(PK-FK 의 칼럼을 두 개 적어준다.) 테이블 OWNER 명시하는 것이 반드시 중요하다. (테이블 별명)
--SELECT 절에 있는 동일한 칼럼에도 별명을 붙여주어야 한다. (칼럼 이름이 같다면 두 테이블 중 어느 OWNER 명시여도 상관 없다. D든 E든 상관 없음.)

-- 2. 사원번호, 사원명, 직업, 직업별 최대 연봉, 직업별 최소연봉을 조회하시오.
SELECT EMPLOYEE_ID
     , FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME
     , J.JOB_ID
     , SALARY
     , MAX_SALARY
     , MIN_SALARY
  FROM JOBS J INNER JOIN EMPLOYEES E
    ON J.JOB_ID = E.JOB_ID;
    
-- 외부 조인

-- 3. 모든 사원번호(부서가 없는 사원도 포함), 사원명, 부서번호, 부서명을 조회하시오.
SELECT EMPLOYEE_ID
     , FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM DEPARTMENTS D RIGHT OUTER JOIN EMPLOYEES E -- RIGHT : 오른쪽 테이블(EMPLOYEES)의 모든 데이터를 조회하시오.(부서번호가 없는 사원도 조회하시오.라는 뜻)
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;         -- 왼쪽, 오른쪽 구분해서 적어주면 된다.
    
-- 4. 사원번호, 사원명, 부서번호, 부서명을 조회하시오. 사원이 근무하지 않는 유령 부서도 조회하시오.
SELECT EMPLOYEE_ID
     , FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM DEPARTMENTS D LEFT OUTER JOIN EMPLOYEES E -- LEFT : 왼쪽 테이블 - 부서테이블을 조회하면 : (사원이 근무하지 않는 부서도 조회하시오. = 유령부서들이 나옴.)
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;
    
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
  FROM LOCATIONS L INNER JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E     --1차 조인~ON~까지 1차 조인한 하나의 테이블로 보고, 뒤에 INNER JOIN 을 넣어서 이너 조인으로 해준다.
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;
    
-- 6. 부서번호, 부서명, 근무도시, 근무국가를 조회하시오.
SELECT DEPARTMENT_ID
     , DEPARTMENT_NAME
     , CITY
     , COUNTRY_NAME
  FROM COUNTRIES C INNER JOIN LOCATIONS L
    ON C.COUNTRY_ID = L.COUNTRY_ID INNER JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID;
