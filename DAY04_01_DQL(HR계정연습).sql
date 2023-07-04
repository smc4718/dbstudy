-- < SELECT >

-- 1. 사원 테이블에서 FIRST_NAME, LAST_NAME 조회하기
SELECT E.FIRST_NAME AS 이름, E.LAST_NAME AS 성           -- AS : ALIAS = 칼럼에 새로운 이름(별명)을 주겠다.
  FROM EMPLOYEES E;                                      -- 테이블에 별명주기 = 공백 한 칸 + 별명;
--SELECT 문의 조회 결과는 테이블로 나온다.               -- 앞에 E.칼럼이름 = 칼럼의 주인은 E 이다.


-- 2. 사원 테이블에서 DEPARTMENT_ID 의 중복을 제거하고 조회하기
SELECT DISTINCT DEPARTMENT_ID
  FROM EMPLOYEES;

-- 3. 사원 테이블에서 EMPLOYEE_ID 가 150인 사원의 정보 조회하기 
SELECT *         -- 검색하고 싶은 칼럼 이름 적기.  EX) SELECT EMPLOYEE_ID , 여기서는 전체사원 중에 조회니까 * 를 쓴 것.
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = 150;
 
 
 /*
 SELECT *        
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = '150';             ==> 묵시적 타입 변환 : 타입이 문자형이나 오라클이 내부적으로 타입변환을 해서 출력해줌.
 
 SELECT *        
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = TO_NUMBER('150');  ==> 위에 같은 예시를 오라클이 자체적으로 타입변환을 '문자->숫자' 로 변형한 것.
 */
 
 
 --4. 사원 테이블에서 연봉이 10000 이상인 사원의 정보 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= 10000;
 
-- 5. 사원 테이블에서 연봉이 10000 이상, 20000 이하인 사원의 정보 조회하기 (2가지 방법)
SELECT *
  FROM EMPLOYEES
 WHERE SALARY BETWEEN 10000 AND 20000;      --사이값은 '칼럼명 BETWEEN ~ AND ~;'  (추천)
 
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= 10000 AND SALARY <= 20000;

-- 6. 사원 테이블에서 부서번호가 30, 40, 50 인 사원의 정보 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 30 OR DEPARTMENT_ID = 40 OR DEPARTMENT_ID = 50;
 
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN(30, 40, 50);          -- ' IN(); ' 을 추천

-- 7. 사원 테이블에서 부서번호가 없는 사원의 정보 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IS NULL;            --DEPARTMENT_ID = NULL; -> 틀린방식 / 널 값을 구하는 연산자는 따로 있다. 
                                         --널값 구하는 연산자 ' IS NULL  -> 'DEPARTMENT_ID IS NULL;
                                         
-- 8. 사원 테이블에서 커미션을 받는 사원의 정보 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL;       --IS NULL 과 반대로 IS NOT NULL 사용.
 
SELECT * FROM EMPLOYEES;      -- 전체 조회.
 
SELECT PHONE_NUMBER
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '515%';     -- ' % ' 를 쓸 때는 등호가 사용될 수 없다. 대신에 LIKE 사용. ' % ' 는 모든 문자 존재 가능하다는 의미. = 와일드카드
                                           
                                           
SELECT PHONE_NUMBER
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '515' || '%';  -- 쉬프트 + 역슬래시 = ' | '  연결하다 라는 뜻.
                                           -- 515를 %와 연결하다.
 
-- 10. 사원 테이블에서 전화번호가 '515'로 시작하는 전화번호의 중복을 제거하고 조회하기
SELECT DISTINCT PHONE_NUMBER
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '515' || '%';
 

-- 11. 사원 테이블의 사원들을 연봉순으로 조회하기 (높은 연봉을 먼저 조회)
SELECT *
  FROM EMPLOYEES
 ORDER BY SALARY;
 

-- < 정렬 : ORDER BY >

SELECT *
  FROM EMPLOYEES
 ORDER BY SALARY;       -- 정렬방식을 정해주지 않으면 기본 정렬 방식은 '오름차순'이다.
 

SELECT *
  FROM EMPLOYEES
 ORDER BY SALARY ASC;  -- ASC : Ascending(오름차순)
 

SELECT *
  FROM EMPLOYEES
 ORDER BY SALARY DESC; -- DESC : Descending(내림차순)


-- 12. 사원 테이블의 사원들을 입사순으로 조회하기 (먼저 입사한 사원을 먼저 조회)
SELECT *
  FROM EMPLOYEES
 ORDER BY HIRE_DATE;
 
-- 13. 사원 테이블의 사원들을 부서별로 비교할 수 있도록 같은 부서의 사원들을 모아서 조회한 뒤
-- 같은 부서내의 사원들은 연봉순으로 조회하기
-- 1차 정렬 기준 : 부서, 오름차순 
-- 2차 정렬 기준 : 연봉, 내림차순 (높은연봉부터) 
SELECT *
  FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID, SALARY DESC;        --ASC; OR 생략. ORDER BY 에서는 콤마(,)로 두 번째 정렬 기준을 세울 수 있다. *해석도 콤마(,)기준 따로따로 해야 한다.
 
-- 실행해보면 같은 부서끼리 모아지고 , 같은 부서 내에 연봉 높은 순서대로 나옴.

-- PK로 검색을 시킬 수 있다면 자체로 검색 시키는게 속도가 가장 빠르다. / PK값을 특정함수로 감싸서 쓰면 다시 느려짐
 
 















