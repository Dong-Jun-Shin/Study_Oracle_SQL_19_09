---서브 쿼리
--예제
--SCOTT이 어떤 부서에 소속되어 있는지 소속 부서명을 알아내기(JOIN 사용x)
SELECT deptno, dname FROM dept WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SCOTT');

--EMP테이블에서 BLAKE와 같은 부서에 있는 모든 사원의 이름과 입사일자(형식: 1981-11-17)를 출력하는 SELECT문을 작성하시오.
  --1.서브 쿼리에 쓰일 부서번호 가져오는 쿼리
SELECT deptno FROM emp WHERE ename='BLAKE';
  --2.메인 쿼리에 쓰일 쿼리
SELECT ename, TO_CHAR(hiredate, 'YYYY-MM-DD') AS hiredate FROM emp WHERE deptno = 30;
  --1+2.서브 쿼리를 활용해서 작성한 쿼리문
SELECT ename, TO_CHAR(hiredate, 'YYYY-MM-DD') AS hiredate FROM emp 
WHERE deptno = (SELECT deptno FROM emp WHERE ename='BLAKE');

--실습
--EMP 테이블에서 King에게 보고하는 모든 사원의 이름과 급여를 출력하는 SELECT문을 작성하시오.
SELECT ename, sal FROM emp WHERE mgr = (SELECT empno FROM emp WHERE ename = 'KING');

--SMITH와 같은 부서에서 근무하는 사원의 정보를 출력하는 예 (COMM이 null이면 0으로 출력)
SELECT empno, ename, job, sal, NVL(comm, 0) COMM, TO_CHAR(hiredate, 'YYYY.MM.DD') hiredate FROM emp 
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH');

--평균 급여보다 더 많은 급여를 받는 사원을 검색하는 쿼리 (단일행 서브 쿼리에서 그룹함수 사용하기)
SELECT ename, sal FROM emp WHERE sal > (SELECT AVG(sal) FROM emp);

--급여를 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원을 출력하라. (중복 제거)
SELECT ename, sal, deptno FROM emp WHERE deptno 
IN (SELECT DISTINCT deptno FROM emp WHERE sal >= 3000) ORDER BY deptno;

/*EMP 테이블에서 이름에 "T"가 있는 사원이 근무하는 부서에서 근무하는 모든 사원에 대해 사원번호, 이름, 급여를 출력하는 
SELECT문을 작성하시오. 단 사원번호 순으로 출력하여라.*/
SELECT empno, ename, deptno, sal FROM emp WHERE deptno 
IN ( SELECT DISTINCT deptno FROM emp WHERE ename LIKE '%T%') ORDER BY empno;

--EMP 테이블에서 SCOTT 또는 WARD와 월급이 같은 사원의 이름, 업무, 급여를 출력하는 SELECT문을 작성하시오.(SCOTT, WARD는 제외)
-- IN( ) AND 조건2
SELECT ename, job, sal FROM emp WHERE sal IN ( SELECT sal FROM emp WHERE ename IN ('SCOTT', 'WARD')) 
AND (ename <> 'SCOTT'AND ename<>'WARD');

/*EMP 테이블에서 적어도 한 명 이상으로부터 보고를 받을 수 있는 사원의 사원번호, 이름, 업무, 부서번호를 출력하는
SELECT문을 작성하시오.(다른 사원을 관리하는 사원)*/
SELECT empno, ename, job, deptno FROM emp WHERE empno IN (SELECT DISTINCT mgr FROM emp);

--EMP 테이블에서 CHICAGO에서 근무하는 사원과 같은 업무를 하는 사원의 이름, 업무를 출력하는 SELECT문을 작성하시오.
SELECT ename, job, deptno FROM emp WHERE job IN (SELECT DISTINCT job FROM emp 
WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'CHICAGO')) AND (deptno <> 30) ORDER BY job DESC; 