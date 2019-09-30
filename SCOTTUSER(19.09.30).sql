---ANSI Join
--예제
--ANSI CROSS JOIN
SELECT * FROM emp CROSS JOIN dept;
--ANSI INNER JOIN
SELECT emp.ename, dept.dname FROM emp INNER JOIN dept ON emp.deptno = dept.deptno WHERE ename = 'SCOTT';
--ANSI INNER JOIN, USING
SELECT emp.ename, dept.dname FROM emp INNER JOIN dept USING (deptno) WHERE ename = 'SCOTT';
--ANSI NATURAL Join
SELECT ename, dname FROM emp NATURAL JOIN dept WHERE ename = 'SCOTT';
--ANSI Outer Join
SELECT E.ename, D.deptno, D.dname FROM emp E LEFT OUTER JOIN dept D ON E.deptno = D.deptno;
SELECT E.ename, D.deptno, D.dname FROM emp E RIGHT OUTER JOIN dept D ON E.deptno = D.deptno;
SELECT E.ename, D.deptno, D.dname FROM emp E FULL OUTER JOIN dept D ON E.deptno = D.deptno;



---실습
--1. ACCOUNTING 부서 소속 사원의 이름과 입사일을 출력하라. (날짜형식 지정 to_char)
SELECT E.ename, E.hiredate FROM emp E, dept D WHERE E.deptno = D.deptno AND dname = 'ACCOUNTING';
SELECT E.ename, to_char(E.hiredate, 'YYYY-MM-DD') FROM emp E INNER JOIN dept D ON E.deptno = D.deptno WHERE D.dname = 'ACCOUNTING';
SELECT E.ename, E.hiredate FROM emp E INNER JOIN dept D USING(deptno) WHERE D.dname = 'ACCOUNTING';

--2. 커미션을 받는 사원의 이름과 그가 속한 부서명을 출력하라.
SELECT E.ename, D.dname, E.comm FROM emp E INNER JOIN dept D ON E.deptno = D.deptno WHERE E.comm IS NOT NULL AND E.comm > 0;
SELECT E.ename, D.dname FROM emp E INNER JOIN dept D USING(deptno) WHERE E.comm IS NOT NULL AND E.comm > 0;

--3. 뉴욕에서 근무하는 사원의 이름과 급여를 출력하라.
SELECT E.ename, E.sal FROM emp E, dept D WHERE E.deptno = D.deptno AND D.loc = 'NEW YORK';
SELECT E.ename, E.sal FROM emp E INNER JOIN dept D ON E.deptno = D.deptno WHERE D.loc = 'NEW YORK';
SELECT E.ename, E.sal FROM emp E INNER JOIN dept D USING(deptno) WHERE D.loc = 'NEW YORK';

--4. SCOTT과 동일한 근무지에서 근무하는 사원의 이름을 출력하라.
  --지역을 같이 출력 ( 서브 쿼리 활용)
SELECT E.ename, D.loc FROM emp E INNER JOIN dept D USING(deptno) WHERE D.loc 
IN(SELECT D.loc FROM emp E INNER JOIN dept D USING(deptno) WHERE E.ename = 'SCOTT');
  --이름만 출력, 같은 테이블 deptno을 비교해서 제외시키기 (<> '같지않다' 활용)
SELECT F.ename AS "SCOTT 동료" FROM emp W, emp F WHERE W.deptno = F.deptno AND W.ename = 'SCOTT' AND F.ename<>'SCOTT';
SELECT F.ename AS "SCOTT 동료" FROM emp W INNER JOIN emp F ON W.deptno = F.deptno WHERE W.ename  = 'SCOTT' AND F.ename<>'SCOTT';

--5. 다음의 결과를 얻을 수 있도록 쿼리문 작성해 주세요. (INNER는 null을 출력하지 않는다. OUTER는 null을 출력한다.
SELECT D.deptno 부서번호, D.dname 부서명, COUNT(E.deptno) 사원수  FROM emp E INNER JOIN dept D 
ON E.deptno = D.deptno GROUP BY D.deptno, D.dname;
SELECT D.deptno 부서번호, D.dname 부서명, COUNT(E.deptno) 사원수  FROM emp E RIGHT OUTER JOIN dept D 
ON E.deptno = D.deptno GROUP BY D.deptno, D.dname HAVING COUNT(E.deptno) > 0;
  --그룹화를 deptno으로 했으니, 그 안에서 알맹이들인 ename으로 집계를 해준다.
SELECT D.deptno 부서번호, D.dname 부서명, COUNT(ename) 사원수 FROM emp E INNER JOIN dept D 
ON E.deptno = D.deptno GROUP BY D.deptno, D.dname ORDER BY 부서번호;

--6. 다음의 결과를 얻을 수 있도록 쿼리문 작성해 주세요.
SELECT D.deptno 부서번호, D.dname 부서명, COUNT(E.deptno) 사원수 FROM emp E RIGHT OUTER JOIN dept D
ON E.deptno = D.deptno GROUP BY D.deptno, D.dname ORDER BY D.deptno; --deptno, 부서번호, 1 (다 사용가능)