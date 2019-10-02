---서브 쿼리 연산자
--예제
--ALL
/*30번 소속 사원들 중에서 급여를 가장 많이 받은 사원보다 더 많은 급여를 받는 사람의 이름, 급여를 출력하는 쿼리문 작성
  (30번 부서 사원 급여들 모두에 대해서 커야 하므로 최대값보다 큰 급여만 해당)*/
SELECT ename, sal FROM emp WHERE sal > ALL(SELECT sal FROM emp WHERE deptno = 30);
--ANY
--부서 번호가 30번인 사원들의 급여 중 가장 작은 값(950)보다 많은 급여를 받는 사원의 이름, 급여를 출력
SELECT ename, sal FROM emp WHERE sal > ANY(SELECT sal FROM emp WHERE deptno = 30);
DROP TABLE dept01;
--테이블 구조만 복사하기
CREATE TABLE dept01 AS SELECT * FROM dept WHERE 1=0;
--서브쿼리로 데이터 복사, 입력
INSERT INTO dept01 SELECT * FROM dept;
--서브쿼리로 이용한 데이터 수정
UPDATE dept01 SET loc = (SELECT loc FROM dept01 WHERE deptno = 40) WHERE deptno = 10;
--서브쿼리를 이용한 데이터 삭제
DELETE FROM dept01 WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES');



--실습
--20번 부서의 부서명과 지역명을 30번 부서의 부서명과 지역명으로 수정 (수정에 사용하는 두가지 방식의 쿼리문)
UPDATE dept01 SET dname = (SELECT dname FROM dept01 WHERE deptno = 30), 
loc = (SELECT loc FROM dept01 WHERE deptno = 30) WHERE deptno =20;
UPDATE dept01 SET (dname, loc) = (SELECT dname, loc FROM dept01 WHERE deptno = 30) WHERE deptno = 20;

--직급이 'SALESMAN'인 사원이 받는 급여들의 최소 급여보다 많이 받는 사원들의 이름과 급여를 출력 (부서번호가 20번인 사원은 제외한다.)
SELECT ename, sal FROM emp WHERE sal > ANY(SELECT sal FROM emp WHERE job = 'SALESMAN' 
AND deptno <> 20);

--EMP 테이블에서 FORD라는 이름을 가진 사원과 업무 및 월급이 같은 사원의 모든 정보를 출력하라.(결과에서 FORD는 제외)
SELECT * FROM emp WHERE (job, sal) IN(SELECT job, sal FROM emp WHERE ename = 'FORD') AND NOT ename = 'FORD';
SELECT * FROM emp WHERE sal = (SELECT sal FROM emp WHERE ename = 'FORD') 
AND job = (SELECT job FROM emp WHERE ename = 'FORD') AND ename <> 'FORD';

--1. EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력하라.
SELECT deptno 부서번호, COUNT(ename) 인원수, SUM(sal) "급여의 합" FROM emp
GROUP BY deptno HAVING COUNT(DECODE(deptno, 10, ename, 20, ename, 30, ename)) > 4 ;
SELECT deptno 부서번호, COUNT(*) 인원수, SUM(sal) "급여의 합" FROM emp
GROUP BY deptno HAVING COUNT(*) > 4 ;
--2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력하라.
--COUNT(*) = DECODE(deptno, 10, COUNT(ename), 20, COUNT(ename), 30, COUNT(ename)) 
SELECT deptno, COUNT(*) FROM emp GROUP BY deptno HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM emp GROUP BY deptno);

--3. EMP 테이블에서 부서번호가 10인 사원수와 부서번호가 20인 사원수, 부서번호가 30인 사원수를 각각 출력하라.
--DECODE는 각각의 행단위로 비교한다.
SELECT 
COUNT(DECODE(deptno, 10, 1)) AS "10번부서인원수", 
COUNT(DECODE(deptno, 20, ename)) AS "20번부서인원수", 
COUNT(DECODE(deptno, 30, ename)) AS "30번부서인원수"
FROM emp;

--4. 각 부서 별 평균 급여가 2000 이상이면 초과, 그렇지 않으면 미만을 출력하라.
SELECT deptno, CASE WHEN AVG(sal) >= 2000 THEN '초과' WHEN AVG(sal) < 2000 THEN '미만' END FROM emp GROUP BY deptno;
--5. 각 부서 별 입사일이 가장 오래된 사원을 한 명씩 선별해 사원번호, 사원명, 부서번호, 입사일을 출력하라.

--6. 1980년 ~ 1982년 사이에 입사된 각 부서별 사원수를 부서번호, 부서명, 1980년입사인원수, 1981년입사인원수, 1982년입사인원수로 출력하라.

