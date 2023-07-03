/*
    DML
    1. Data Manipulation Language
    2. 데이터(행, Row)를 조작(삽입, 수정, 삭제)하는 언어이다.
    3. 트랜잭션 대상이다. (작업이 완료되면 COMMIT, 작업을 취소하려면 ROLLBACK 이 필요하다.)
        1) COMMIT   : 작업을 저장한다. COMMIT 이 완료된 작업은 취소할 수 없다. 정확하게는 ROLLBACK 으로 취소할 수 없다.
        2) ROLLBACK : 작업을 취소한다. COMMIT 한 이후에 했던 작업을 취소한다.
    4. 종류
        1) 삽입 : INSERT INTO VALUES
        2) 수정 : UPDATE SET WHERE
        3) 삭제 : DELETE FROM WHERE
*/
--참고.
--자격증에서는 DML의 범주를 INSERT, UPDATE, DELETE + SELECT로 보기도 한다. (자격증 시험에는 SELECT 가 들어가지만 일반적으로는 DML에 SELECT는 안 들어간다.)

-- 테이블 지우기 생성
DROP TABLE EMPLOYEE_T;
DROP TABLE DEPARTMENT_T;


-- 부서 테이블
CREATE TABLE DEPARTMENT_T (
    DEPT_NO   NUMBER             NOT NULL
  , DEPT_NAME VARCHAR2(15 BYTE)  NOT NULL
  , LOCATION  VARCHAR2(15 BYTE)  NOT NULL
  , CONSTRAINT PK_DEPART PRIMARY KEY(DEPT_NO)
);

-- 사원 테이블
CREATE TABLE EMPLOYEE_T (
    EMP_NO    NUMBER            NOT NULL
  , NAME      VARCHAR2(20 BYTE) NOT NULL
  , DEPART    NUMBER
  , POSITION  VARCHAR2(20 BYTE)
  , GENDER    CHAR    (2 BYTE)
  , HIRE_DATE DATE
  , SALARY    NUMBER
  , CONSTRAINT PK_EMPLOYEE    PRIMARY KEY(EMP_NO)
  , CONSTRAINT FK_DEPART_EMP  FOREIGN KEY(DEPART) REFERENCES DEPARTMENT_T(DEPT_NO) ON DELETE SET NULL
);

-- 부서번호를 생성하는 시퀀스만들기
/*
CREATE SEQUENCE DEPT_SEQ
    INCREMENT BY 1 -- 1씩 증가하는 번호를 만든다. (디폴트)
    START WITH 1   -- 1부터 번호를 만든다.  (디폴트)
    NOMAXVALUE     -- 번호에 상한선이 없다. (디폴트)
    NOMINVALUE     -- 번호에 하한선이 없다. (디폴트)
    NOCYCLE        -- 번호 순환이 없다. (디폴트)
    CACHE 20       -- 20개씩 번호를 미리 만들어 둔다.  (디폴트)
    NOORDER        -- 번호를 순서대로 사용하지 않는다. (디폴트) , 번호를 순서대로 사용하는 'ORDER' 옵션으로 바꿔서 시퀀스를 생성한다.
;
*/
DROP SEQUENCE DEPT_SEQ; --시퀀스도 테이블처럼 작업할 때 DROP 부터 적어준다.
CREATE SEQUENCE DEPT_SEQ ORDER;  --번호를 뽑는 기계


INSERT INTO DEPARTMENT_T(DEPT_NO,DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '영업부', '대구'); --기계에서 번호를 빼는 게 NEXTVALUE 의 줄임말 : NEXTVAL.
INSERT INTO DEPARTMENT_T(DEPT_NO,DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '인사부', '서울');
INSERT INTO DEPARTMENT_T(DEPT_NO,DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '총무부', '대구');
INSERT INTO DEPARTMENT_T(DEPT_NO,DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '기획부', '서울');

COMMIT;
--쿼리문은 실행했다고 저장된 게 아니다. 확정상태가 아니다.
--COMMIT; 까지 적어줘야 저장완료.

DROP SEQUENCE EMP_SEQ;
CREATE SEQUENCE EMP_SEQ
    START WITH 1001
    ORDER;

INSERT INTO EMPLOYEE_T VALUES(EMP_SEQ.NEXTVAL, '구창민', 1, '과장', 'M', '95-05-01', '5000000');
INSERT INTO EMPLOYEE_T VALUES(EMP_SEQ.NEXTVAL, '김민서', 1, '사원', 'M', '17-09-01', '2500000'); -- 날짜는 하이픈(-) 또는 슬래시(/)로 구분, 오라클에서는 기본 슬래시(/)로 저장됨.
INSERT INTO EMPLOYEE_T VALUES(EMP_SEQ.NEXTVAL, '이은영', 2, '부장', 'F', '90-09-01', '5500000'); -- 날짜는 하이픈(-) 또는 슬래시(/)로 구분, 오라클에서는 기본 슬래시(/)로 저장됨.
INSERT INTO EMPLOYEE_T VALUES(EMP_SEQ.NEXTVAL, '한성일', 2, '과장', 'M', '93-04-01', '5000000'); -- 날짜는 하이픈(-) 또는 슬래시(/)로 구분, 오라클에서는 기본 슬래시(/)로 저장됨.
 --위에 DEPARTMENT_T 시퀀스는 다 적었는데 EMPLOYEE는 생략한 이유는, 생략해서 해도 칸 수에 맞게 입력하면 가능하나,
 --DB가 많아지면 보기 헷갈리니 처음처럼 생략하지 않고 구문을 전체 다 적어주는 것이 좋다.
COMMIT;

-- 가장 최근 작업을 취소하려면 ROLLBACK; 적으면 됨. (★커밋을 취소하는 것이 아니라 마지막 커밋 이후에 했던 작업들을 취소하는 것이 '롤백'★)
-- 커밋취소(커밋을 했다는 건 성공한 것인데, 예를 들어 회원가입했는데 커밋을 취소하면 회원들이 탈퇴된다.) , 취소할 일이 없음. 






