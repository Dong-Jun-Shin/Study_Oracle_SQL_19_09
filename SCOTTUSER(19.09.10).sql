--SELECT FROM
SELECT * FROM dept; --SELECT deptno, dname, loc FROM dept;
SELECT deptno, dname FROM dept; --특정 칼럼 조회

SELECT * FROM emp;
SELECT sal, hiredate FROM emp;

--AS (두가지 방법)
SELECT deptno AS departmentNo, dname AS departmentName FROM DEPT; --별칭 주기
SELECT deptno "department No", dname "department Nmae" FROM DEPT;  --AS 생략, 공백에 따른 ""사용

--Concatenation
SELECT ename || '의 직급은 ' || job || '입니다.' AS 직급 FROM emp; -- '||'으로 이어주기

--DISTINCT
SELECT DISTINCT job FROM emp;
SELECT DISTINCT deptno FROM emp;

--WHERE
SELECT empno, ename, sal FROM emp WHERE ename='SMITH'; --데이터는 대소문자를 구분한다.
SELECT empno, ename, sal FROM emp WHERE sal>=3000; 
SELECT empno, ename, job FROM emp WHERE sal<3000;
SELECT * FROM emp WHERE deptno = 10;
SELECT empno, ename, sal FROM emp WHERE sal < 2000;
SELECT empno, ename, job FROM emp WHERE ename = 'MILLER';

--날짜 데이터 조회
SELECT * FROM emp WHERE hiredate >= '85/01/01'; --날짜형식이 년/월/일로 되있어서, 형식을 맞춰준다.
SELECT * FROM emp WHERE hiredate >= '1985/01/01'; --날짜형식이 년/월/일로 되있어서, 형식을 맞춰준다.

--논리 연산자
--AND
SELECT * FROM emp WHERE deptno = 10 AND job = 'MANAGER';
SELECT * FROM emp WHERE sal >= 1000 AND sal <= 3000;

--OR
SELECT * FROM emp WHERE deptno = 10 OR job = 'MANAGER';
SELECT * FROM emp WHERE empno = 7844 OR empno = 7654 OR empno = 7521;

--NOT
SELECT * FROM emp WHERE NOT deptno = 10;

--BETWEEN AND
SELECT * FROM emp WHERE sal BETWEEN 1000 AND 3000;
SELECT empno, ename, sal FROM emp WHERE sal >= 1500 AND sal <= 2500;
SELECT empno, ename, sal FROM emp WHERE sal BETWEEN 1500 AND 2500;
SELECT * FROM emp WHERE hiredate BETWEEN '1987/01/01' AND '1987/12/31';

--IN
SELECT * FROM emp WHERE empno = 7844 OR empno = 7654 OR empno = 7521;
SELECT * FROM emp WHERE empno IN(7844, 7654, 7521);

SELECT ename, sal, comm FROM emp WHERE comm = 300 OR comm = 500 OR comm = 1400;
SELECT ename, sal, comm FROM emp WHERE comm IN(300, 500, 1400);

--LIKE
SELECT * FROM emp WHERE ename LIKE 'K%';
SELECT * FROM emp WHERE ename LIKE '%K%';
SELECT * FROM emp WHERE ename LIKE '%K';

SELECT * FROM emp WHERE ename LIKE '_A%'; --'a'로 끝나는 두글자로 시작하는 내용
SELECT * FROM emp WHERE NOT ename LIKE '%A%'; --'A'가 이름에 없는 사람들