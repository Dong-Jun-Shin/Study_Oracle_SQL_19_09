--emp를 이용해서 emp01로 복사 테이블을 만들어준다.
CREATE TABLE emp01 AS SELECT * FROM emp;

--emp01의 모든 부서번호를 30번으로 수정한다.
UPDATE emp01 SET deptno = 30;
--emp01의 모든 사원의 급여를 10% 인상
UPDATE emp01 SET sal = sal*1.1;
--emp01의 모든 입사입을 오늘 날짜로 바꾼다.
UPDATE emp01 SET hiredate = SYSDATE;

--사원 테이블을 다시 생성한다.
DROP TABLE emp01;
CREATE TABLE emp01 AS SELECT * FROM emp;

--부서번호가 10번인 사원의 부서번호를 30번으로 수정한다.
UPDATE emp01 SET deptno = 30 WHERE deptno = 10;

--1987년에 입사한 사원의 입사일이 오늘로 수정
UPDATE emp01 SET hiredate = SYSDATE WHERE SUBSTR(hiredate, 1, 2) = '87';

--SCOTT의 부서번호는 20번으로, 직급은 MANAGER
UPDATE emp01 SET deptno = 20, job ='MANAGER' WHERE ename = 'SCOTT';

SELECT * FROM emp01 WHERE ename = 'SCOTT';

-----------------------------------------------------------------------------------------
--가상 컬럼을 가지는 temp01 테이블을 생성합니다.
CREATE TABLE temp01(
    no1 NUMBER,
    no2 NUMBER,
    no3 NUMBER GENERATED ALWAYS AS (no1 + no2) VIRTUAL
);

ALTER TABLE temp01 ADD(no4 NUMBER GENERATED ALWAYS AS (no1*12 + no2) VIRTUAL);

--temp01 테이블에 데이터를 입력합니다. (이 명령은 DML에서 배웁니다.) (가상 컬럼은 입력을 허용하지 않는다.)
INSERT INTO temp01(no1, no2) VALUES(1,2);

--기존 값을 변경 한 후 가상 컬럼에 반영되는 지 확인합니다.
UPDATE temp01 SET no1 = 10;

SELECT * FROM temp01;

--테이블 속성 조회
SELECT column_name, data_type, data_default
FROM user_tab_columns
WHERE table_name = 'TEMP01'
ORDER By column_id;

