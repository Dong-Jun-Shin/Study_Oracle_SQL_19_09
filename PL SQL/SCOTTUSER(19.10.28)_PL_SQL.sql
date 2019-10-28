--부서 번호로 부서 이름을 반환하는 함수를 생성하자. (첫번째 방법)
CREATE OR REPLACE FUNCTION 
    getdname(v_deptno IN emp.deptno%TYPE)
RETURN VARCHAR2
IS
    v_dname VARCHAR2(50);
    v_cnt NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_cnt FROM dept 
    WHERE deptno = v_deptno;

    IF v_cnt = 0 THEN
        v_dname := '해당 부서 없음';
    ELSE
        SELECT dname INTO v_dname FROM dept
        WHERE deptno = v_deptno;
    END IF;
    RETURN v_dname;
END getdname;
/

--GETDNAME()함수 사용
SELECT ename, job, NVL(comm, 0), sal, GETDNAME(deptno) dname FROM emp WHERE ename = 'KING';

--GETDNAME()함수 사용 없는 부서 검색
SELECT GETDNAME(80) FROM dual;


--부서 번호로 부서 이름을 반환하는 함수를 생성하자. (두번째 방법)
CREATE OR REPLACE FUNCTION 
    getdname(v_deptno IN emp.deptno%TYPE)
RETURN VARCHAR2
IS
    v_dname VARCHAR2(50);
BEGIN
    SELECT dname INTO v_dname FROM dept 
    WHERE deptno = v_deptno;
    
    RETURN v_dname;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    v_dname := '해당 부서 없음';
    RETURN v_dname;
END getdname;
/

--GETDNAME()함수 사용
SELECT empno, ename, TO_CHAR(hiredate, 'YYYY-MM-DD') hiredate,
    GETDNAME(deptno) dept_name
FROM emp;

--부서번호를 매개변수로 해당 부서의 평균 급여를 반환하는 함수를 생성하자.(GETAVGDEPT)
--숫자로 할 때
CREATE OR REPLACE FUNCTION getavgdept(v_deptno emp.deptno%TYPE)
RETURN NUMBER
IS
    v_avgsal NUMBER(8, 2);
BEGIN
    SELECT AVG(sal) INTO a_sal FROM emp WHERE deptno = v_deptno;
    RETURN a_sal;
END getavgdept;
/

--GETAVGDEPT 함수 사용
SELECT GETAVGDEPT(20) FROM dual;

--부서번호를 매개변수로 해당 부서의 평균 급여를 반환하는 함수를 생성하자.(GETAVGDEPT)
--문자로 할 때
CREATE OR REPLACE FUNCTION getavgdept(v_deptno IN emp.deptno%TYPE)
RETURN VARCHAR2
IS
    v_avgsal VARCHAR2(50);
BEGIN
    SELECT TO_CHAR(ROUND(AVG(sal)),'99999999') INTO v_avgsal FROM emp 
    WHERE deptno = v_deptno;
    
    RETURN v_avgsal;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    v_avgsal := '해당 부서 없음';
    RETURN v_avgsal;
END;
/

--사원번호를 조건으로 사원의 이름, 급여, 부서명 및 부서 평균 급여를 출력
SELECT ename, sal, GETDNAME(deptno) dname, GETAVGDEPT(deptno) AVGSAL FROM emp WHERE empno = 7369;