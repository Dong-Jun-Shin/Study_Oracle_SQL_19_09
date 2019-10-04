--상호 연관 쿼리
--EMP 테이블에서 월급이 자신이 속한 부서의 평균 월급보다 높은 사원의 부서번호, 이름, 급여를 출력
--E.deptno에 필요한 데이터를 Main에서 Sub로 던져준다. 연산 후 Sub를 끝내고 Main을 연산한다.
SELECT E.deptno, E.ename, E.sal FROM emp E WHERE E.sal > (SELECT AVG(sal) FROM emp D WHERE D.deptno = E.deptno) ORDER BY E.deptno, E.sal desc;

--스칼라 서브 쿼리
SELECT ename, (SELECT dname FROM dept D WHERE D.deptno = E.deptno) dname FROM emp E;

--View
--뷰를 생성할 권한부여와 실습할 테이블 복사
GRANT CREATE VIEW TO scott;
CREATE TABLE emp_copy AS SELECT * FROM emp;
SELECT * FROM emp_copy;

--생성
CREATE VIEW view_emp AS SELECT empno, ename, sal, deptno FROM emp_copy WHERE deptno = 10;
CREATE OR REPLACE VIEW view_emp10 AS SELECT empno, ename, sal, deptno FROM emp_copy WHERE deptno = 30;
SELECT * FROM view_emp10;
              
--생성된 뷰 목록(?) 조회
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

--뷰에 대한 데이터 추가
INSERT INTO view_emp10 VALUES(8000, 'ANGEL', 7000, 10);

--뷰에 별칭 주기
CREATE OR REPLACE VIEW view_emp(사원번호, 사원명, 급여, 부서번호)
AS
SELECT empno, ename, sal, deptno FROM emp_copy;

SELECT * FROM emp_copy;
SELECT * FROM view_emp;