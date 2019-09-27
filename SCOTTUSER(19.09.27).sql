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


---실습
--Equi Join
