-- < SELECT 실행 순서와 HAVING >

/*
    SELECT 문의 실행 순서
    SELECT 칼럼        5
      FROM 테이블      1
     WHERE 조건        2
     GROUP BY 그룹     3
    HAVING 그룹조건    4
     ORDER BY 정령     6
*/

-- 사원 테이블에서 부서별 연봉 평균과 사원수를 조회하시오. 부서별 사원수가 2명 이상인 부서만 조회하시오.

SELECT DEPARTMENT_ID
     , ROUND(AVG(SALARY), 2)
     , COUNT(*) AS 부서별사원수
  FROM EMPLOYEES               
 GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 2;
 
 
-------------------------
ex)
SELECT DEPARTMENT_ID
     , ROUND(AVG(SALARY), 2)
     , COUNT(*) AS 부서별사원수
  FROM EMPLOYEES               
 GROUP BY DEPARTMENT_ID
 HAVING 부서별사원수 >= 2;
 -- 부서별 사원수는 마지막 실행 순서이기 때문에 HAVING 에 있는 것은 실행되지 않고 오류가 난다.

ex2)
SELECT DEPARTMENT_ID AS DEPT_ID
     , ROUND(AVG(SALARY), 2)
     , COUNT(*) AS 부서별사원수
  FROM EMPLOYEES               
 GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 2
 ORDER BY DEPT_ID;
-- ORDER BY가 가장 마지막 실행 순서라 이 예시는 실행 가능하다.
 
-------------------------
 
