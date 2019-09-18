--단일함수
--예제
--NVL2
SELECT ename, sal, comm, NVL2(comm, sal+comm, sal) TOTAL_SAL FROM emp ;

CASE 1
--A가 B일 경우 '1'을 출력하는 경우
DECODE (A, B, '1', NULL);  --(단 마지막 NULL은 생략가능)

CASE 2
--A가 B일 경우 '1'을 출력하고 아닐 경우 '2'를 출력하는 경우
DECODE (A, B, '1', '2');

CASE 3
--A가 B일 경우 '1'을 출력하고 A가 C일 경우 '2'를 출력하고 둘 다 아닐 경우 '3'을 출력하는 경우
DECODE(A, B, '1', C, '2', '3')

CASE 4
--A가 B일 경우 중에서 C가 D를 만족하면 '1'을 출력하고 C가 D가 아닐 경우 NULL을 출력
DECODE(A, B, DECODE(C, D, '1', NULL)) --NULL은 생략가능

CASE 5
--A가 B일 경우 중에서 C가 D를 만족하면 '1'을 출력하고 C가 D가 아닐 경우 '2'를 출력하기
DECODE(A, B, DECODE(C, D, '1', '2')) --NULL은 생략가능



--실습
--부서명 구하기 (DECODE)
SELECT deptno, DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS') AS dname FROM emp;
--부서명 구하기 (CASE)
SELECT ename, deptno,
    CASE WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
    END dname
FROM emp;
--직급에 따라 급여를 인상하도록 하자. (사원번호, 사원명, 직급, 급여)
--직급이 'ANAIYST'인 사원은 5%, 'SALESMAN'인 사원은 10%, 'MANAGER'인 사원은 15%, 'CLERK'인 사원은 20%인 인상한다. --TRUNC로 소수점 이하 생략
SELECT empno, ename, job, sal, TRUNC(DECODE(job, 'ANALYST', sal*1.05, 'SALESMAN', sal*1.10, 'MANAGER', sal*1.15, 'CLERK', sal*1.20, SAL),0) AS upsal FROM emp;

SELECT empno, ename, job, sal, 
    CASE WHEN job = 'ANALYST' THEN sal*1.05
        WHEN job = 'SALESMAN' THEN sal*1.10
        WHEN job = 'MANAGER' THEN sal*1.15
        WHEN job = 'CLERK' THEN sal*1.20
    END AS upsal
FROM emp;
    
--EMP Table에서 이름, 급여, 커미션 금액, 총액 (sal + comm)을 구하여 총액이 많은 순서로 출력하라. 단, 커미션이 NULL인 사람은 제외한다.
SELECT ename, sal, comm, sal+comm AS total FROM emp WHERE comm IS NOT NULL AND comm > 0 ORDER BY total DESC; --ORDER BY 4 DESC;
--EMP Table에서 급여가 $1,500부터 $3,000 사이의 사람은 급여의 15%를 회비로 지불하기로 하였다. 이를 이름, 급여, 회비(소수점이하 반올림)를 출력하라.
SELECT ename, sal, ROUND(sal*0.15, 0) AS fee FROM emp WHERE sal BETWEEN 1500 AND 3000;
--EMP Table에서 모든 사원의 실수령액을 계산하여 출력하라. 단, 급여가 많은 순으로 이름, 급여, 실수령액을 출력하라. (실수령액은 급여에 대해 10%의 세금을 뺀 금액)
SELECT ename, sal, sal*0.90 AS net_pay FROM emp ORDER BY sal DESC;


--그룹함수(해당 컬럼의 전체 레코드 대상)
--SUM
SELECT SUM(sal) FROM emp;
SELECT TO_CHAR(SUM(sal), '$999,999') AS total FROM emp;
--AVG
SELECT AVG(sal) FROM emp;
SELECT ROUND(AVG(sal),1) FROM emp;
--MAX & MIN
SELECT TO_CHAR(MAX(hiredate), 'YYYY-MM-DD') AS max, TO_CHAR(MIN(hiredate), 'YYYY-MM-DD') AS min FROM emp;
--사원들의 커미션 총액 출력하기
SELECT SUM(comm) AS "커미션 총액" FROM emp;
--전체 사원의 수와 커미션을 받는 사원의 수
SELECT * FROM emp WHERE comm IS NOT NULL;
SELECT COUNT(*), COUNT(REPLACE(comm, 0, NULL)) AS "0제외 커미션" FROM emp;
SELECT COUNT(*), COUNT(DECODE(comm, 0, NULL, comm)) AS "0제외 커미션" FROM emp;
--직무의 종류가 몇 개인지, 즉, 중복되지 않은 직무의 개수를 카운트 해보자.
SELECT COUNT(DISTINCT(job)) AS "직업 수" FROM emp;
--사원들을 사원번호 기준으로 그룹지어준다.
SELECT deptno FROM emp GROUP BY deptno;
--소속 부서별 최대 급여와 최소 급여 구하기
SELECT deptno, MAX(sal) "최대 급여", MIN(sal) "최소 급여" FROM emp GROUP BY deptno;
--소속 부서별 급여의 합과 급여의 평균 구하기
SELECT deptno, SUM(sal) 합, TRUNC(AVG(sal), 2) AS 평균 FROM emp GROUP BY deptno;
--부서별로 사원의 수와 커미션을 받는 사원의 수를 카운트
SELECT deptno, COUNT(empno), COUNT(REPLACE(comm, 0, NULL)) FROM emp GROUP BY deptno ORDER BY deptno ASC;
--HAVING 조건
SELECT deptno, ROUND(AVG(sal), 0) FROM emp GROUP BY deptno HAVING AVG(sal) >= 2000;
SELECT deptno, MAX(sal), MIN(sal) FROM emp GROUP BY deptno HAVING MAX(sal) > 2900;
--EMP 테이블에서 아래의 결과를 출력하는 SELECT 문장을 작성하여라. (H_YEAR, 사원수, 최소급여, 최대급여, 급여의 평균, 급여의 합)
SELECT 
TRUNC(hiredate, 'YYYY') AS H_YEAR,
COUNT(empno) AS 사원수,
MIN(sal) AS 최소급여,
MAX(sal) AS 최대급여,
AVG(sal) AS "급여의 평균",
SUM(sal) AS "급여의 합" FROM emp GROUP BY TRUNC(hiredate, 'YYYY') ORDER BY TRUNC(hiredate, 'YYYY') ASC;