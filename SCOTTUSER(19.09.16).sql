SELECT 4+3 FROM DEPT;

-- 테이블 구조 확인시 DESC
-- dual은 시스템에 존재하는 dummy라는 값이 한자리 들어가는 기본 테이블이다. --임시 테이블
DESC dual;
DESC dept;

SELECT * FROM DUAL;
SELECT INITCAP('DATA BASE PROGRAM') FROM dual;
SELECT CONCAT('Data', 'Base') FROM dual;
SELECT 'Data' || 'Base' FROM dual;
SELECT LENGTH('DataBase'), LENGTH('데이터베이스') FROM dual; --영: 1개, 한: 1개
SELECT LENGTHB('DataBase'), LENGTHB('데이터베이스') FROM dual;  --영: 1byte, 한: 2byte
SELECT SUBSTR('DataBase', 1, 3) FROM dual; --, 
SELECT SUBSTRB('DataBase', 1, 3) FROM dual;  --영: 1byte, 한: 2byte / 인덱스 1부터
SELECT SUBSTRB('데이터베이스', 2, 4) FROM dual;  --영: 1byte, 한: 2byte / 인덱스 1부터
SELECT INSTR('DataBase', 'a', 1, 1) FROM dual;

-- 30번 부서 소속 사원의 급여를 출력하는 쿼리문
SELECT deptno, sal FROM emp WHERE deptno = 30;
-- 그룹함수를 이용해서 30번 부서 소속 사원의 총 급여를 구하는 쿼리문
SELECT deptno, SUM(sal) FROM EMP GROUP BY deptno HAVING deptno = 30;
--사원 테이블에서 부서번호가 10번인 사원명을 모두 소문자로 변환
SELECT ename, LOWER(ename) FROM emp WHERE deptno = 10;
--직급이 'manager'인 사원을 검색 -- 대문자 입력
SELECT empno, ename, job FROM emp WHERE job = 'MANAGER';
--직급이 'manager'인 사원을 검색 -- 대문자 변환
SELECT empno, ename, job FROM emp WHERE job = UPPER('manager');
--직급이 'manager'인 사원을 검색 -- 테이블을 소문자로 변환 후, 소문자 비교
SELECT empno, ename, job FROM emp WHERE LOWER(job) = 'manager';
--사원 테이블의 10번 부서 소속의 사원이름의 이름의 첫 글자만 대문자로
SELECT empno, INITCAP(ename) FROM emp WHERE deptno = 10;
--'Smith'란 이름을 갖은 사원의 사번과 이름과 급여와 커미션을 출력하라.(INITCAP, UPPER 사용)
SELECT empno, INITCAP(ename) ENAME , sal, comm FROM emp WHERE ename = UPPER('Smith');
SELECT empno, ename, sal, comm FROM emp WHERE INITCAP(ename) = 'Smith';
--부서 번호가 10번인 사원의 이름과 연봉을 출력
SELECT CONCAT(ename, ' ($' || sal || ')') AS "사원 정보" FROM emp WHERE deptno = 10;
--직원 중 이름이 4글자인 직원의 이름을 소문자로 출력
SELECT empno, LOWER(ename) FROM emp WHERE  LENGTH(ename) = 4;
--20번 부서 사원들 중의 입사 년도 알아내기
SELECT ename, hiredate, substr(hiredate, 1, 2) FROM emp WHERE deptno = 20;
--87년도에 입사한 사원 알아내기(비교 연산자와 AND연산자, BETWEEN AND 연산자, SUBSTR함수)
SELECT ename, hiredate FROM emp WHERE hiredate >= '87/01/01' AND hiredate <= '87/12/31';
SELECT ename, hiredate FROM emp WHERE hiredate BETWEEN '87/01/01' AND '87/12/31'; --가장 효율적
SELECT ename, hiredate FROM emp WHERE SUBSTR(hiredate, 1, 2) = 87;
--이름이 K로 끝나는 직원을 검색 (LIKE 연산자와 와일드카드(%), SUBSTR 함수)
SELECT ename FROM emp WHERE ename LIKE '%K';
SELECT ename FROM emp WHERE SUBSTR(ename, -1, 1) = 'K';
--30번 부서 소속 사원이름에 E자가 어디에 위치하는지 알려주는 쿼리문
SELECT deptno, ename, INSTR(ename, 'E') FROM emp WHERE deptno = 30;

