-----------------------------------------------------------------------------------------------------
---제약조건 확인
DROP TABLE emp01;

--사원 번호, 사원명, 직급, 부서번호 4개의 칼럼으로 구성하되 사원번호와 사원명에 NOT NULL 조건을 지정하여 emp01 테이블 생성
CREATE TABLE emp01(
    empno NUMBER(4) NOT NULL,
    ename VARCHAR2(10) NOT NULL,
    job VARCHAR2(9),
    deptno NUMBER(4)
);

--INSERT INTO emp01 VALUES(NULL, NULL, 'SALESMAN', 30);
--ALTER TABLE emp01 MODIFY(empno NUMBER(4) NOT NULL);
INSERT INTO emp01 VALUES(10, 'JANE', 'SALESMAN', 30);
DELETE FROM emp01 WHERE empno = 10;
INSERT INTO emp01 VALUES(7499, 'ALLEN', 'SALESMAN', 30);

SELECT * FROM emp01;

-----------------------------------------------
DROP TABLE emp02;

/*사원 번호, 사원명, 직급, 부서번호 4개의 칼럼으로 구성하되 사원번호는 중복되지 않게, 
  사원명에 NOT NULL 조건을 지정하여 emp01 테이블 생성*/
CREATE TABLE emp02(
    empno NUMBER(4) UNIQUE,
    ename VARCHAR2(10) NOT NULL,
    job VARCHAR2(9),
    deptno NUMBER(4)
);

INSERT INTO emp02(empno, ename, job, deptno) VALUES(7499, 'ALLEN', 'SALESMAN', 30);
--중복값 확인
INSERT INTO emp02(empno, ename, job, deptno) VALUES(7499, 'ALLEN', 'SALESMAN', 30);
--NULL값 확인 (UNIQUE에 NULL | NOT NULL에 NULL)
INSERT INTO emp02(empno, ename, job, deptno) VALUES(NULL, 'ALLEN', 'SALESMAN', 30);
INSERT INTO emp02(empno, ename, job, deptno) VALUES(7499, NULL, 'SALESMAN', 30);

SELECT * FROM emp02;

-----------------------------------------------------------------------------------------------------
---딕셔너리 뷰
-- 접속한 유저가 가지고 있는 테이블 목록을 반환한다.
SELECT TABLE_NAME, TABLESPACE_NAME FROM USER_TABLES ORDER BY TABLE_NAME ASC;
-- 제약조건(CONSTRAINTS) 확인하기
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP02';
-- USER_CONS_COLUMNS 데이터 딕셔너리는 제약조건이 지정된 칼럼명도 저장한다.

-----------------------------------------------------------------------------------------------------
---기본키 지정
DROP TABLE emp03;

CREATE TABLE emp03(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10) NOT NULL,
    job VARCHAR2(9),
    deptno NUMBER(4)
);

--NULL값을 넣을 수 없다.
--INSERT INTO emp03 VALUES(NULL, 'JONES', 'MANAGER', 20);
INSERT INTO emp03 VALUES(7499, 'JONES', 'MANAGER', 20);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME= 'EMP03';

SELECT * FROM emp03;

-----------------------------------------------------------------------------------------------------
--범위 외 설정 오류
--외래 키 제약 조건에 지정하지 않은 EMP03 테이블에 부서 테이블에 존재하지 않은 50번 부서번호를 저장해 보도록 하자.
INSERT INTO emp03 VALUES(7566, 'JONES', 'MANAGER', 50);

SELECT * FROM emp03;
--위와 같이 했을 때, 없는 부서번호로 저장이 된다. 아래와 같이 해서 해결하자.

------------------------------------------------------------------테이블 두 개를 활용해서, 외래키 지정하기
--dept로 dept01을 만든다. (제약 조건은 가져올 수 없다.)
CREATE TABLE dept01 AS SELECT * FROM dept;
--제약조건을 지정해준다.
ALTER TABLE dept01 ADD CONSTRAINTS dept01_deptno PRIMARY KEY(deptno);

DROP TABLE emp04;
/*외래키 제약 조건은 EMP04 테이블을 생성시 칼럼명과 자료형을 기술한 후에 REFERENCES를 기술하면 된다. 
DEPTNO 칼럼을 참조하게 외래키 제약 조건을 설정한다.*/
CREATE TABLE emp04(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10) NOT NULL,
    job VARCHAR2(9),
    deptno NUMBER(4) REFERENCES dept01(deptno)
);
--ORA-02291: 무결성 제약조건(SCOTT.SYS_C0011088)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO emp04 VALUES(7566, 'JONES', 'MANAGER', 50);

INSERT INTO emp04 VALUES(7566, 'JONES', 'MANAGER', 10);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP04';

SELECT * FROM emp04;

-------------------------------------------------------------------------------------------------------
CREATE TABLE emp05(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10) NOT NULL,
    gender VARCHAR2(1) CHECK (gender IN('M', 'F'))    
);

--ORA-02290: 체크 제약조건(SCOTT.SYS_C0011094)이 위배되었습니다.
INSERT INTO emp05(empno, ename, gender) VALUES(7566, 'JONES', 'A');

INSERT INTO emp05(empno, ename, gender) VALUES(7566, 'JONES', 'M');

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME= 'EMP05'; 

SELECT * FROM emp05;

----------------------------------------------------------------------------------------------------
DROP TABLE emp06;
--칼럼 레벨 정의 형식
CREATE TABLE emp06(
    empno NUMBER(4) CONSTRAINT emp06_empno_pk PRIMARY KEY,
    ename VARCHAR2(10) CONSTRAINT emp06_ename_nn NOT NULL,
    job VARCHAR2(9) CONSTRAINT emp06_job_uk UNIQUE,
    deptno NUMBER(4) CONSTRAINT emp06_deptno_fk REFERENCES dept(deptno)
);

--두번 실행 시, ORA-00001: 무결성 제약 조건(SCOTT.EMP06_EMPNO_PK)에 위배됩니다
INSERT INTO emp06 VALUES(7499, 'ALLEN', 'SALESMAN', 30);
--ORA-01400: NULL을 ("SCOTT"."EMP06"."ENAME") 안에 삽입할 수 없습니다
INSERT INTO emp06 VALUES(7499, NULL, 'SALESMAN', 50);
--ORA-00001: 무결성 제약 조건(SCOTT.EMP06_JOB_UK)에 위배됩니다
INSERT INTO emp06 VALUES(7500, 'ALLEN', 'SALESMAN', 50);

SELECT * FROM emp06;
------------------------------------------------------------------------------------------------------
--테이블 레벨 정의 형식
CREATE TABLE emp07(
    empno NUMBER(4) ,
    ename VARCHAR2(10) NOT NULL, --CONSTRAINT emp07_ename_nn NOT NULL(ename)
    job VARCHAR2(9) ,
    deptno NUMBER(4) ,
    
    CONSTRAINT emp07_empno_pk PRIMARY KEY(empno),
    CONSTRAINT emp07_job_uk UNIQUE(job),
    CONSTRAINT emp07_deptno_fk FOREIGN KEY(deptno) REFERENCES dept(deptno)
);

INSERT 

SELECT * FROM emp07;

--------------------------------------------------------------------------------------------------------------
--제약조건 확인 (R = Relation)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP07';