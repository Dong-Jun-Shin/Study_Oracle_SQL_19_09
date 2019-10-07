--단순 뷰
--부서별 급여 총액과 평균을 구하는 작업
CREATE OR REPLACE VIEW view_sal AS 
SELECT deptno, SUM(sal) AS "SalSum", ROUND(AVG(sal), 1) AS "SalAvg" 
FROM emp_copy GROUP BY deptno;

SELECT * FROM view_sal;

--복합 뷰
CREATE OR REPLACE VIEW view_emp_dept (사원번호, 사원명, 급여, 부서번호, 부서명, 지역)
AS SELECT E.empno, E.ename, E.sal, E.deptno, D.dname, D.loc 
FROM emp E INNER JOIN dept D ON E.deptno = D.deptno ORDER BY E.empno DESC;

SELECT * FROM view_emp_dept;

--뷰 삭제
DROP VIEW view_emp_dept;
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

--뷰 수정 및 생성
CREATE OR REPLACE VIEW view_emp10 AS SELECT empno, ename, sal, comm, deptno FROM emp_copy WHERE deptno =  10;
SELECT * FROM view_emp10;
DROP VIEW view_emp10;

--뷰 FORCE옵션(중복 여부)
CREATE OR REPLACE FORCE VIEW view_notable
AS SELECT empno, ename, deptno 
FROM emp15 WHERE deptno =  10;

SELECT * FROM view_notable;

SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

--WITH CHECK OPTION (조건 변경 금지)
CREATE OR REPLACE VIEW view_chk AS
SELECT empno, ename, sal, comm, deptno FROM emp_copy
WHERE deptno = 20 WITH CHECK OPTION;

UPDATE view_chk 
SET deptno = 10
WHERE sal>=2000;

SELECT * FROM view_chk;

--WITH READ ONLY (읽기 전용)
CREATE OR REPLACE VIEW view_read
AS
SELECT empno, ename, sal, comm, deptno 
FROM emp_copy WHERE deptno = 30 WITH READ ONLY;

UPDATE view_read SET comm=1000;

--ROWNUM
SELECT ROWNUM, empno, ename, hiredate FROM emp;

CREATE OR REPLACE VIEW view_hire AS SELECT empno, ename, hiredate FROM emp ORDER BY hiredate;

SELECT ROWNUM, empno, ename, hiredate FROM view_hire WHERE ROWNUM <= 5;

--인라인 뷰
SELECT ROWNUM, empno, ename, hiredate 
FROM (SELECT empno, ename, hiredate FROM emp 
ORDER BY HIREDATE) WHERE ROWNUM <= 5;

--emp테이블과 dept테이블을 조회하여 부서번호와 부서별 최대 급여 및 부서명을 출력하세요.
SELECT E.deptno, D.dname, E.sal FROM (SELECT deptno, MAX(sal) SAL FROM emp GROUP BY deptno) E, DEPT D WHERE E.deptno = D.deptno;

--1. 사원 번호와 사원명과 부서명과 부서의 위치를 출력하는 뷰(VIEW_LOC)를 작성하라.
CREATE OR REPLACE VIEW view_loc AS SELECT E.empno, E.ename, D.dname, D.loc FROM emp E INNER JOIN dept D ON E.deptno = D.deptno;
SELECT * FROM view_loc;

--2. 30번 부서 소속 사원의 이름과 입사일과 부서명을 출력하는 뷰(VIEW_DEPT30)를 작성하라.
CREATE OR REPLACE VIEW view_dept30 AS SELECT E.ename, TO_CHAR(E.hiredate, 'YYYY-MM-DD') hiredate, D.dname FROM emp E INNER JOIN dept D ON E.deptno = D.deptno WHERE E.deptno = 30;
SELECT * FROM view_dept30;

--3. 부서별 최대 급여 정보를 가지는 뷰(VIEW_DEPT_MAXSAL)를 생성하라.
CREATE OR REPLACE VIEW view_dept_maxsal AS SELECT deptno, MAX(sal) SAL FROM emp GROUP BY deptno;
SELECT * FROM view_dept_maxsal;

--4. 급여를 많이 받는 순서대로 3명만 출력하는 뷰(VIEW_SAL_TOP3)와 인라인 뷰로 작성하라.
--뷰
CREATE OR REPLACE VIEW view_sal_top3 AS SELECT ename, sal FROM emp ORDER BY sal DESC;
SELECT ename, sal FROM view_sal_top3 WHERE ROWNUM <= 3;
--인라인 뷰
SELECT ename, sal FROM (SELECT ename, sal SAL FROM emp ORDER BY sal DESC) WHERE ROWNUM <= 3;


--Mview
--수동으로 동기화를 하고 데이터 전체가 원본테이블과 동기화되는 Mview(m_emp)를 즉시(IMMEDIATE) 생성
CREATE MATERIALIZED VIEW m_emp 
BUILD IMMEDIATE 
REFRESH 
ON DEMAND 
COMPLETE 
ENABLE QUERY REWRITE 
AS SELECT empno, ename, sal FROM emp_copy;

SELECT * FROM m_emp;

---수동으로 원본 테이블과 Mview 데이터 동기화하기
--원본 테이블 로우 삭제
DELETE FROM emp_copy WHERE empno = 7788;

--동기화 전에 원본 테이블과 Mview의 데이터 건수 비교해보기
SELECT COUNT(*) FROM emp_copy; --Table 14
SELECT COUNT(*) FROM view_emp; --View 14
SELECT COUNT(*) FROM m_emp; --Mview 15

--Mview 동기화 (PL/SQL 프로시저)
BEGIN
    DBMS_MVIEW.REFRESH('m_emp');
END;

--동기화 후 
SELECT COUNT(*) FROM emp_copy; --Table 14
SELECT COUNT(*) FROM view_emp; --View 14
SELECT COUNT(*) FROM m_emp; --Mview 14

--조회하기
SELECT MVIEW_NAME, QUERY FROM USER_MVIEWS
WHERE MVIEW_NAME = 'M_EMP';

--삭제하기
DROP MATERIALIZED VIEW m_emp;