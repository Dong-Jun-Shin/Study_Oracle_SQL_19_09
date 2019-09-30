--Cross Join
SELECT * FROM emp, dept;

--Equi Join (emp.ename,  dept.dname)
SELECT ename, dname FROM emp, dept WHERE emp.deptno = dept.deptno;

--테이블 별칭 사용하기 (공통되지 않은 열의 테이블 명시 생략 가능)
SELECT E.ename, D.dname, E.deptno, D.deptno FROM emp E, dept D WHERE E.deptno = D.deptno;
SELECT ename, dname, E.deptno, D.deptno FROM emp E, dept D WHERE E.deptno = D.deptno;

--SCOTT인 사람의 정보만을 출력하기 위해서 AND 연산자를 추가한다.
SELECT E.ename, D.dname FROM emp E, dept D WHERE E.deptno = D.deptno AND E.ename = 'SCOTT';

--등급 테이블 조회
SELECT * FROM salgrade;

/*급여 등급을 5개로 나누어 놓은 salgrade 테이블에서 정보를 얻어 와서 각 사원의 급여 등급을 지정한다. 
이를 위해서는 emp 테이블과 salgrade 테이블을 조인해야 한다.*/
SELECT E.ename, E.sal, S.grade FROM emp E, salgrade S WHERE E.sal BETWEEN S.losal AND S.hisal;
SELECT E.ename, E.sal, S.grade FROM emp E, salgrade S WHERE E.sal >= S.losal AND E.sal <= S.hisal;

--Outer Join
--사원 테이블과 부서 테이블을 조인하여 사원 이름과 부서번호와 부서명을 출력한다. (Equi Join 비교)
SELECT E.ename, D.deptno, D.dname FROM emp E, dept D WHERE E.deptno = D.deptno ORDER BY D.deptno;
--사원 테이블과 부서 테이블을 조인하여 사원 이름과 부서번호와 부서명을 출력한다. (Outer Join 확인)
SELECT E.ename, D.deptno, D.dname FROM emp E, dept D WHERE E.deptno(+) = D.deptno ORDER BY D.deptno;

--Self Join
--사원 테이블에서 각 사원의 상사를 출력 (상사의 직원번호를 각 직원번호와 매치
SELECT WORK.ename 사원명, MANAGER.ename 매니저명 FROM emp WORK, emp MANAGER WHERE WORK.MGR = MANAGER.EMPNO;
--문장으로 출력되도록 한 쿼리문 (RPAD - 지정 자리수만큼 지정 문자로 채우기 / 자리수가 낮을 경우 잘린다.)
SELECT RPAD(WORK.ename, 6, ' ') ||'의 매니저는'||MANAGER.ename||'이다.' AS " 그 사원의 매니저" FROM emp WORK, emp MANAGER WHERE WORK.mgr = MANAGER.empno;