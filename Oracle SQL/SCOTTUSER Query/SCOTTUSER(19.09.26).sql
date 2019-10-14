CREATE TABLE EMP08(
    empno NUMBER(4),
    ename VARCHAR2(10),
    job VARCHAR2(9),
    deptno NUMBER(4)
);

---EMP09 테이블의 EMPNO 칼럼에 기본키를 설정하고 DEPTNO칼럼에 외래키를 설정한다.
--기본키 설정, 오라클 서버가 제약 조건을 준다. (조건명 미지정 - CONSTRAINT emp08_empno_pk)
ALTER TABLE emp08 ADD  PRIMARY KEY(empno);
--외래키 설정, 사용자가 제약 조건을 준다. (조건명 지정)
ALTER TABLE emp08 ADD CONSTRAINT emp08_deptno_fk FOREIGN KEY(deptno) REFERENCES dept01(deptno);

--참조하는 외래키 범위를 벗어나서 오류
INSERT INTO emp08 VALUES(7499, 'ALLEN', 'MANAGER', 50);
--두번 실행하면 기본키 중복으로 오류
INSERT INTO emp08 VALUES(7499, 'ALLEN', 'MANAGER', 10);
--기본키에 대한 제약 조건을 없애준다.
ALTER TABLE emp08 DROP CONSTRAINT emp08_empno_pk;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP08';
SELECT * FROM emp08;