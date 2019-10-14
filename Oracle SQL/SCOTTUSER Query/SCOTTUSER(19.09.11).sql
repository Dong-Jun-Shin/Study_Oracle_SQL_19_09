--NULL
    --SELECT * FROM emp WHERE comm = NULL; --성립x
SELECT * FROM emp WHERE comm is NULL;
SELECT * FROM emp WHERE comm is NOT NULL;
SELECT * FROM emp WHERE comm is NOT NULL AND comm > 0;
SELECT ename, job, mgr FROM emp WHERE mgr is NULL;

--정렬
SELECT * FROM emp ORDER BY empno ASC;
SELECT * FROM emp ORDER BY empno DESC;
SELECT * FROM emp ORDER BY deptno; --기본은 ASC
SELECT * FROM emp ORDER BY deptno ASC, sal DESC; --앞이 정렬 전,후 동일하다면 다음 기준 정렬을 수행

SELECT empno, ename, sal FROM emp ORDER BY sal DESC;
SELECT empno, ename, hiredate FROM emp ORDER BY hiredate ASC;

--문제
--1. 사원번호가 7369인 사람 중 이름, 입사일, 부서번호를 출력해라.
SELECT ename, hiredate, deptno FROM emp WHERE empno = 7369;

--2. 사원이름이 ALLEN인 사람의 모든 정보를 출력하라.
SELECT * FROM emp WHERE ename = 'ALLEN';

--3. 입사일이 81/11/17인 사원의 이름, 부서번호, 월급을 출력하라.
SELECT ename, deptno, sal FROM emp WHERE hiredate = '81/11/17';

--4. 부서번호로 ASCENDING SORT(asc)한 후 급여가 많은 사람 순으로 출력하라.
SELECT * FROM emp ORDER BY deptno, sal DESC;

--5. 급여가 $800 이상인 사람의 이름, 급여, 부서번호로 출력하라.
SELECT ename, sal, deptno FROM emp WHERE sal >= 800;

--6. 부서번호가 30번 부서이고 급여가 $1,500 이상인 사람의 이름, 부서번호, 급여를 출력하라.
SELECT ename, deptno, sal FROM emp WHERE deptno = 30 AND sal >= 1500;

--7. 사원이름이 s로 시작하는 사원의 사원번호, 이름, 입사일, 부서번호를 출력하라.
SELECT empno, ename, hiredate, deptno FROM emp WHERE ename LIKE 'S%';

--8. 급여가 $1,500 이상이고 부서번호가 30번인 사원 중 직무가 MANAGER인 사람의 정보를 출력하라.
SELECT * FROM emp WHERE sal >= 1500 AND deptno = 30 AND job = 'MANAGER';

--9. 입사일이 81/12/09보다 먼저 입사한 사람들의 모든 정보를 출력
SELECT * FROM emp WHERE hiredate <= '81/12/09';

--10. 입사일이 81년 이외에 입사한 사원의 이름, 부서번호, 급여, 입사일을 출력
SELECT ename, deptno, sal, hiredate FROM emp WHERE NOT(hiredate >= '81/01/01' AND hiredate <= '81/12/31');
SELECT ename, deptno, sal, hiredate FROM emp WHERE NOT hiredate BETWEEN '81/01/01' AND '81/12/31';
SELECT ename, deptno, sal, hiredate FROM emp WHERE NOT SUBSTR(hiredate, 1,2) = '81' ;
SELECT ename, deptno, sal, hiredate FROM emp WHERE SUBSTR(hiredate, 1,2) <> '81';
SELECT ename, deptno, sal, hiredate FROM emp WHERE NOT hiredate LIKE '81%';

--11. EMP 테이블에서 급여가 $600이상인 사원의 이름, 급여, 직무를 출력하도록 SELECT문을 작성하시오.
SELECT ename, sal, job FROM emp WHERE sal >= 600;

--12. EMP 테이블에서 사원명에 A로 시작하는 사원의 사원번호, 사원명, 입사일, 부서번호를 출력
SELECT empno, ename, hiredate, deptno FROM emp WHERE ename LIKE 'A%';
SELECT empno, ename, hiredate, deptno FROM emp WHERE SUBSTR(ename, 1, 1) = 'A'; 

--13. 10번 부서의 모든 사원들에게 급여의 13%를 보너스로 지불하기로 하였다.
    --10번 부서의 사원명, 급여, 보너스 금액, 부서번호를 출력
SELECT ename 사원명, sal 급여, sal*0.13 "보너스 금액", sal*1.13 "급여 + 보너스", deptno 부서번호 FROM emp WHERE deptno = 10;
