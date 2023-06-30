/*
   < 1:M 관계 (일대다 관계 - PK와 FK를 잡아주는 작업) >
    
    1. 2개의 테이블을 관계 짓는 가장 대표적인 관계
    2.   1    :   M
        PK    :   FK
        부모  :   자식
 (PARENT KEY)    (CHILD KEY)
    3. 만드는 순서 : ★반드시 부모 테이블을 먼저 만들고, 자식 테이블은 나중에 만들어야 한다. (안 그럼 Err)
    4. 삭제 순서   : ★반드시 자식 테이블을 먼저 지우고, 부모 테이블은 나중에 지워야 한다. (부모를 먼저 지우면, 자식 테이블은 참조무결성 위배 데이터가 되어서 Err) 
*/

/*
    삭제 옵션
    1. ON DELETE CASCADE  : 외래키가 참조하는 기본키 값이 삭제되면 외래키도 함께 삭제한다.
    2. ON DELETE SET NULL : 외래키가 참조하는 기본키 값이 삭제되면 외래키를 NULL로 처리한다.
*/

-- 자식 먼저 지우기
DROP TABLE STUDENT_T;
-- 부모 나중에 지우기
DROP TABLE SCHOOL_T;

-- 부모 먼저 만들기
CREATE TABLE SCHOOL_T (
    SCH_CODE NUMBER            NOT NULL       
  , SCH_NAME VARCHAR2(10 BYTE) NOT NULL
  , CONSTRAINT PK_SCH PRIMARY KEY(SCH_CODE) --제약조건의 이름은 PK_SCH(이름변경가능), SCH_CODE에 PRIMARY KEY 지정
);
-- *소문자로 쓰고 대문자로 바꾸는 법 : 드래그하고 상단에 'A <-> a' 아이콘 몇 번 누르면 됨.
--CONSTRAINT : 제약조건 지정 명렁어

-- 자식 나중에 만들기
CREATE TABLE STUDENT_T (
    STU_NO   NUMBER            NOT NULL 
  , SCH_CODE NUMBER                          -- REFERENCES 참조하는테이블이름(참조하는 칼럼이름)
  , STU_NAME VARCHAR2(10 BYTE) NOT NULL                                    -- SCH_CODE는 SCHOOL_T 테이블의 SCH_CODE를 참조한다.
  , CONSTRAINT PK_STU     PRIMARY KEY(STU_NO) --제약조건의 이름은 PK_STU, STU_NO에 PRIMARY KEY 지정
  , CONSTRAINT FK_SCH_STU FOREIGN KEY(SCH_CODE) REFERENCES SCHOOL_T(SCH_CODE) ON DELETE CASCADE --제약조건의 이름은 FK_SCH_STU.
);                                                              
-- REFERENCES : 참조한다.
-- SCH_CODE는 반드시 부모 SCH_CODE 의 데이터 타입과 일치해야 한다. (NUMBER)
-- PK는 반드시 NOT NULL 로 해야 하지만, FK는 NOT NULL - NULL 둘 다 가능하다. (안적어도 NULL)
-- CONSTRAINT 제약조건이름 기본키 OR 왜래키 지정 명령.(제약조건에 저장이 일어날텐데 우리가 제약조건 이름을 저장해서 만드는 것이 보기 편함)
-- 두 번째 CONSTRAINT 방식이 오라클,MYSQL에서도 동일한 문법으로 쓰인다.















