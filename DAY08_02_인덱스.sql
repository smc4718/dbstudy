/*
    ROWID(로우아이디)
    1. 오라클에서 제공하는 가상 칼럼(PSEUDO COLUMN : 수도 칼럼)이다.
    2. 어떤 행이 어디에 저장되어 있는지 알고 있는 칼럼이다.
    3.실제로 저장된 물리적 저장위치를 확인할 수 있다.
*/

-- ROWID 확인
SELECT ROWID, EMPLOYEE_ID, FIRST_NAME, LAST_NAME
  FROM EMPLOYEES;
  
-- ROWID를 이용한 조회
-- 1. 오라클에서 가장 빠른 조회이다.
-- 2. 실제로 사용하기가 불가능하다. 대신 인덱스를 사용한다. 
-- ('어떤 데이터는 어떤 로우아이디를 가지고 있다.' 를 정리해 두는 것이 인덱스이다.)
SELECT *
  FROM EMPLOYEES
 WHERE ROWID = 'AAAR+IAAHAAAADLAAE';
 
 
 /*
    인덱스
    1. 빠른 조회를 지원하는 데이터베이스 객체이다.
    2. 어떤 데이터가 어떤 ROWID를 가지고 있는지 알고 있다. (인덱스는 로우아이디 사용한 것 만큼 빠른 조회가 가능)
    3. 기본키(PK)와 중복이 없는 칼럼(UNIQUE)은 자동으로 인덱스가 만들어진다.
    4. 인덱스가 많으면 데이터의 삽입/수정/삭제 시 인덱스도 함께 갱신해야 하기 때문에 전체적인 성능이 떨어질 수 있다.
 */
 
 -- 인덱스를 타는 조회
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = 150;

 -- 인덱스를 안 타는 조회 (인덱스 칼럼을 그대로 써야지, TO_CHAR 같은 함수를 적용하면 인덱스를 타지 않는다.)  
SELECT *
  FROM EMPLOYEES
 WHERE TO_CHAR(EMPLOYEE_ID) = '150';
 --* '=' 같은 등호 기준으로 왼쪽은 건드리지 말고, 오른쪽 값 적어주는 곳에 가서 작업해라 : 성능 때문.
 
 
/*
    데이터 사전
    1. 특정 데이터의 정보를 담고 있는 객체이다.
    2. 시스템 카탈로그, 메타 데이터라고도 한다.
    3. 계정, 유형별로 관리한다.
        1_ DBA_
        2_ USER_
        3_ ALL_
*/

-- 인덱스 정보가 저장되어 있는 데이터 사전(이미 만들어진 테이블) = 정보가 정보를 담고 있어서 '메타데이터' 라고 부름 
-- DBA_INDEXES, USER_INDEXES, ALL_INDEXES.
SELECT * FROM USER_INDEXES;

-- 인덱스가 설정된 칼럼 정보가 저장되어 있는 데이터 사전
-- DBA_IND_COLUMNS, USER_IND_COLUMNS, ALL_IND_COLUMNS. 
SELECT * FROM USER_IND_COLUMNS;

-- 사원 테이블의 인덱스만 보고 싶다.
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME = 'EMPLOYEES';

-- 부서 테이블의 부서명(DEPARTMENT_NAME) 칼럼에 인덱스 설정하기
CREATE INDEX DEPT_NAME_IX
    ON DEPARTMENTS(DEPARTMENT_NAME)
    

-- 인덱스 DEPT_NAME_IX 삭제하기
DROP INDEX DEPT_NAME_IX;

