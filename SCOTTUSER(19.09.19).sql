--부서별, 직무별 급여의 합
--(부서코드가 바뀔때마다 부서별 집계가 출력되고 모든 부서가 출력되면 전체 집계정보가 출력된다.
SELECT deptno, job, COUNT(*), SUM(sal) FROM emp GROUP BY ROLLUP (deptno, job); --부서별
SELECT job, deptno, COUNT(*), SUM(sal) FROM emp GROUP BY ROLLUP (job, deptno); --직무별

--집합 연산자
SELECT * FROM exp_goods_asia;
--UNION(합집합) --중복x, 15개 결과
SELECT goods FROM exp_goods_asia WHERE country = '한국'
UNION
SELECT goods FROM exp_goods_asia WHERE country = '일본';
--UNION ALL --중복o, 20개 결과
SELECT goods FROM exp_goods_asia WHERE country = '한국'
UNION ALL
SELECT goods FROM exp_goods_asia WHERE country = '일본';
--INTERSECT --한국과 일본 공통, 5개 결과
SELECT goods FROM exp_goods_asia WHERE country = '한국'
INTERSECT
SELECT goods FROM exp_goods_asia WHERE country = '일본';
--MINUS -- 한국과 일본 이외, 5개 결과
SELECT goods FROM exp_goods_asia WHERE country = '한국'
MINUS
SELECT goods FROM exp_goods_asia WHERE country = '일본';

--EMP 테이블을 사용하여 급여와 보너스를 합친 금액이 가장 많은 경우와 가장 적은경우, 평균 금액을 구하세요. 단 보너스가 없을 경우
--0으로, 출력 금액은 모두 소수점 첫째 자리까지만 나오게 하세요.
SELECT MAX(sal+NVL(comm, 0)) MAX, MIN(sal+NVL(comm, 0)) MIN, ROUND(AVG(sal+NVL(comm, 0)), 1) AVG FROM emp;

--EMP 테이블에서 아래의 결과를 출력하는 SELECT 문장을 작성하여라. (H_YEAR, 사원수, 최소급여, 최대급여, 급여의 평균, 급여의 합)
SELECT 
TO_CHAR(hiredate, 'YYYY') AS H_YEAR,
COUNT(empno) AS 사원수,
MIN(sal) AS 최소급여,
MAX(sal) AS 최대급여,
AVG(sal) AS "급여의 평균",
SUM(sal) AS "급여의 합" FROM emp GROUP BY TO_CHAR(hiredate, 'YYYY') ORDER BY TO_CHAR(hiredate, 'YYYY') ASC;

--EMP 테이블에서 아래의 결과를 출력하는 SELECT 문장을 작성하여라.
--시도
--SELECT
--    COUNT(*) TOTAL,
--    DECODE(TO_CHAR(hiredate, 'YYYY'), 1980, COUNT(TO_CHAR(hiredate, 'YYYY'))) AS "1980년도",
--    DECODE(TO_CHAR(hiredate, 'YYYY'), 1981, COUNT(TO_CHAR(hiredate, 'YYYY'))) AS "1981년도",
--    DECODE(TO_CHAR(hiredate, 'YYYY'), 1982, COUNT(TO_CHAR(hiredate, 'YYYY'))) AS "1982년도",
--    DECODE(TO_CHAR(hiredate, 'YYYY'), 1987, COUNT(TO_CHAR(hiredate, 'YYYY'))) AS "1987년도"
--FROM emp GROUP BY ;
--풀이 --그룹함수는 전체 대상 순차 레코드 적용, 단일 함수는 한가지에 적용
SELECT
    COUNT(*) TOTAL,
    COUNT(CASE WHEN TO_CHAR(hiredate, 'YYYY') = '1980' THEN 1 END) "1980년도",
    COUNT(CASE WHEN TO_CHAR(hiredate, 'YYYY') = '1981' THEN 1 END) "1981년도",
    COUNT(CASE WHEN TO_CHAR(hiredate, 'YYYY') = '1982' THEN 1 END) "1982년도",
    COUNT(CASE WHEN TO_CHAR(hiredate, 'YYYY') = '1987' THEN 1 END) "1987년도"
FROM emp;

--EMP 테이블에서 아래의 결과를 출력하는 SELECT 문장을 작성하여라.
--시도
--SELECT
--    job,
--    CASE WHEN deptno = 10 THEN SUM(sal) END "DEPTNO 10",
--    CASE WHEN deptno = 20 THEN SUM(sal) END "DEPTNO 20",
--    CASE WHEN deptno = 30 THEN SUM(sal) END "DEPTNO 30",
--    SUM(sal) TOTAL
--FROM emp GROUP BY job, deptno;
--풀이
SELECT job,
    NVL(SUM(DECODE(deptno, 10, sal)), 0) "DEPTNO 10",
    NVL(SUM(DECODE(deptno, 20, sal)), 0) "DEPTNO 10",
    NVL(SUM(DECODE(deptno, 30, sal)), 0) "DEPTNO 10",
    SUM(sal) "TOTAL"
FROM emp GROUP BY job;
--EMP 테이블에서 아래의 결과를 출력하는 SELECT 문장을 작성하여라. (부서별로 직급별로 급여 합계 결과)
SELECT
    --분류 중 해당되는 것을 출력
    deptno,
    NVL(SUM(DECODE(job, 'CLERK', sal)), 0) CLERK,
    NVL(SUM(DECODE(job, 'SALESMAN', sal)), 0) SALESMAN,
    NVL(SUM(DECODE(job, 'MANAGER', sal)), 0) MANAGER,
    NVL(SUM(DECODE(job, 'ANALYST', sal)), 0) ANALYST,
    NVL(SUM(DECODE(job, 'PRESIDENT', sal)), 0) PRESIDENT,
    SUM(sal) TOTAL
    --deptno으로 분류 및 집계, deptno으로 오름차순
FROM emp GROUP BY ROLLUP(deptno) ORDER BY deptno ASC;

