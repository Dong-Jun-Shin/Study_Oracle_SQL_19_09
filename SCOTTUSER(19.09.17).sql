--문자함수
--예제
SELECT LPAD('DataBase', 20, '$') FROM dual;
SELECT RPAD('DataBase', 20, '$') FROM dual;
--TRIM 기본 제겋할 문자는 공백
SELECT TRIM('    ABCD    ') BOTHT, LENGTH(TRIM('    ABCD    ')) BOTHLEN FROM dual;

--실습

--이름의 세 번째 자리가 R인 직원을 검색 (LIKE 연산자와 _와일드 카드, SUBSTR함수)
SELECT * FROM emp WHERE ename LIKE '__R%';
SELECT * FROM emp WHERE SUBSTR(ename, 3, 1) = 'R';
--이름의 두 번째 자리에 A가 있는 사원의 사번, 이름, 직급을 출력하라 (INSTR함수)
SELECT empno, ename, job FROM emp WHERE INSTR(ename, 'A') = 2;
--LTRIM, RTRIM 값
SELECT ename, LTRIM(LPAD(ename, 10, '*'), 'M'), RPAD(ename, 10, '*') FROM emp;
--SMITH란 사람의 이름에서 S와 H를 잘라내자.
SELECT ename, TRIM('S' FROM ename), TRIM('H' FROM ename) FROM emp WHERE ename = 'SMITH';
--문자를 대체한다. 마스킹처리
SELECT ename, REPLACE(ename, SUBSTR(ename, 2, 3), '***') FROM emp;


--숫자함수
--예제
SELECT CEIL(10.123), FLOOR(34.5678) FROM dual;
SELECT ROUND(35.12, 1), ROUND(21.125, 2), ROUND(34.567, 0), ROUND(56.789), ROUND(78.901, -1), ROUND(653.54, -2) FROM dual;
SELECT TRUNC(12.345, 2), TRUNC(34.567, 0), TRUNC(56.789), TRUNC(78.901, -1) FROM dual;

--실습
--사번이 짝수인 사원들의 사번과 이름과 직급을 출력하라
SELECT empno, ename, job FROM emp WHERE MOD(empno, 2) = 0;


--날짜 함수
--예제
SELECT SYSDATE FROM dual;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '수요일') FROM dual;

SELECT SYSDATE, LAST_DAY(SYSDATE) FROM dual;



--실습
--날짜 사이의 개월 수 구하기, TO_CHAR(대상, 포맷) - 해당 포맷의 문자로 반환한다.
SELECT ename, SYSDATE 오늘, TO_CHAR(hiredate, 'yyyy/mm/dd') 입사일, TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) 근무달수 FROM emp WHERE deptno = 10;
--입사일에서 3개월이 지난 날짜를 구하라
SELECT ename, hiredate, ADD_MONTHS(hiredate, 3) FROM emp WHERE deptno = 10;
--입사일을 기준으로 반올림한 예 (포맷 : 월)
SELECT hiredate, ROUND(hiredate, 'MONTH') FROM emp WHERE deptno = 10;
--입사일을 월 기준으로 잘라내기
SELECT hiredate, TRUNC(hiredate, 'YEAR') FROM emp WHERE deptno = 10;
SELECT hiredate, TRUNC(hiredate, 'DAY') FROM emp WHERE deptno = 10; --한주가 시작되는 날짜


--변환 함수
--예제
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD, HH24:MI;SS') FROM dual; --많이 사용
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD, AM HH:MI;SS') FROM dual;

--실습
--CHAR
--사원들의 입사일을 출력하되 요일까지 함께 출력하기
SELECT TO_CHAR(hiredate, 'YYYY/MM/DD DAY') FROM emp WHERE deptno = 10;
SELECT TO_CHAR(hiredate, 'YYYY"년" MM"월" DD"일" DAY') FROM emp WHERE deptno = 10;
--급여를 통화기호와 형식에 맞춰 출력
SELECT ename, sal, TO_CHAR(sal, '$999,999') FROM emp WHERE deptno = 10;

--DATE
--1981년 2월 20일에 입사한 사원을 검색
SELECT ename, hiredate FROM emp WHERE hiredate = TO_DATE(19810220, 'YYYYMMDD');
--올해 며칠이 지났는지 날짜 계산
SELECT SYSDATE-'2015/01/01' FROM dual; --(x)(날짜-문자라서)
SELECT TRUNC(SYSDATE-TO_DATE('2015/01/01', 'YYYY/MM/DD')) FROM dual; --(o) (TRUNC 자릿수 생략, 0으로 간주)
--(밀리초단위까지 계산) (지정한 날짜에 대해서는 시간 단위는 지정 안했으니 0으로 초기화)
SELECT SYSDATE-TO_DATE('2015/01/01', 'YYYY/MM/DD') FROM dual; 

--NUMBER
--수치 형태의 문자 값의 차 구하기
SELECT '10,000' + '20,000' FROM dual; --(x) (문자-문자라서)
SELECT '10000' + '20000' FROM dual; --(o) (숫자만 있으면 숫자로 인식한다. 자동 형변환)
SELECT TO_NUMBER('10,000', '999,999') +TO_NUMBER('20,000', '999,999') FROM dual; --(o)


--일반 함수
--예제
--NVL
SELECT ename, sal, comm, NVL(comm, 0), job FROM emp ORDER BY job; --ORDER BY 생략은 올림차순

--실습
--연봉을 계산하기 위해서 급여에 12를 곱한 후 커미션을 더해본다.
SELECT ename, sal, comm, sal * 12, (sal * 12 + NVL(comm, 0)) FROM emp ORDER BY job;
--상관이 없는 사원만 출력하되 MGR 칼럼 값 대신 CEO로 출력해본다.
SELECT ename, sal, hiredate, REPLACE(NVL(mgr, 0), 0, 'CEO') MGR FROM emp WHERE mgr is NULL;
