--출력
BEGIN
	DBMS_OUTPUT.PUT_LINE('Hello World!');
END;
/

--변수 정의와 대입
DECLARE
	val_num NUMBER;
BEGIN
	val_num := 100;	
    DBMS_OUTPUT.PUT_LINE(val_num);
END;
/

DECLARE
    --identifier := value;
	val_num NUMBER := 24*60*60;
BEGIN
    DBMS_OUTPUT.PUT_LINE('num = '||val_num);
END;
/

--스칼라 변수
DECLARE
	VEMPNO NUMBER(4);
	VENAME VARCHAR2(10);
BEGIN
	VEMPNO := 7788;
	VENAME := 'SCOTT';

	DBMS_OUTPUT.PUT_LINE('사번 / 이름');
	DBMS_OUTPUT.PUT_LINE('----------');	
    DBMS_OUTPUT.PUT_LINE(VEMPNO || '/' || VENAME);
END;
/

--레퍼런스 변수
DECLARE
	vempno emp.empno%TYPE;
	vename emp.ename%TYPE;
    vsal emp.sal%TYPE;
    vhiredate emp.hiredate%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('사번/이름/급여/입사일');
	DBMS_OUTPUT.PUT_LINE('------------------------------');
	SELECT empno, ename, sal, hiredate INTO vempno, vename, vempsal, vehiredate
	FROM emp
	WHERE ename = 'SCOTT';
    DBMS_OUTPUT.PUT_LINE(vempno||'/'||vename||'/'||vempsal||'/'||TO_CHAR(vehiredate, 'YY.MM.DD'));
END;
/

--테이블 타입 정의 및 반복문
DECLARE
    --테이블 타입을 정의
    TYPE ename_table_type IS TABLE OF emp.ename%TYPE
    INDEX BY BINARY_INTEGER;
    TYPE job_table_type IS TABLE OF emp.job%TYPE
    INDEX BY BINARY_INTEGER;
    TYPE empno_table_type IS TABLE OF emp.empno%TYPE
    INDEX BY BINARY_INTEGER;
    
    --테이블 타입으로 변수 선언 (변수명 테이블형)
    ename_table ename_table_type;
    job_table job_table_type;
    empno_table empno_table_type;
    i BINARY_INTEGER := 0;
    
BEGIN
    --emp 테이블로부터 사원 이름과 직급을 얻어온다.
    FOR k IN(SELECT empno, ename, job FROM emp) LOOP
        i := i+1;                                  --인덱스를 증가시켜가며
        ename_table(i) := k.ename;        --테이블에 얻어온 사원 이름과
        job_table(i) := k.job;                  --직급을 배열처럼 저장한다.
        empno_table(i) := k.empno;
    END LOOP;
    --테이블에 저장된 내용을 출력
    DBMS_OUTPUT.PUT_LINE('사번'||'/'||RPAD('이름', 7)||'/'||RPAD('직무', 9));
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    
  
    FOR j IN 1..i LOOP
        DBMS_OUTPUT.PUT_LINE(empno_table(j) || '/' || RPAD(ename_table(j), 7) || '/' || RPAD(job_table(j), 9));
    END LOOP;
END;
/

--전체 레코드를 참조하는 %ROWTYPE
DECLARE
    --레코드로 변수 선언
    emp_record emp%ROWTYPE;
BEGIN
    --JONES 사원의 정보를 레코드 변수에 저장
    SELECT *
    INTO emp_record
    FROM emp
    WHERE ename = 'JONES';
    
    --레코드 변수에 저장된 사원 정보를 출력
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||TO_CHAR(emp_record.empno));
    DBMS_OUTPUT.PUT_LINE('이      름 : '||emp_record.ename);
    DBMS_OUTPUT.PUT_LINE('급      여 : '||emp_record.sal);
    DBMS_OUTPUT.PUT_LINE('입사일자 : '||TO_CHAR(emp_record.hiredate, 'YYYY-MM-DD'));
END;
/

---예제
--EMP 테이블에 등록된 총사원의 수와 급여의 합, 급여의 평균을 변수에 대입하여 출력하여 보자.
DECLARE
    empno_cnt NUMBER;
    sal_sum NUMBER;
    sal_avg NUMBER(8, 2);
BEGIN
    SELECT COUNT(*), SUM(sal), AVG(sal) INTO empno_cnt, sal_sum, sal_avg FROM emp;
    DBMS_OUTPUT.PUT_LINE('총사원 수 :' || empno_cnt);
    DBMS_OUTPUT.PUT_LINE('급여의 합 :' || sal_sum);
    DBMS_OUTPUT.PUT_LINE('급여평균 :' || sal_avg);
END;
/

--WARD 사원의 직무, 급여, 입사일자, 커미션, 부서명을 변수에 대입하여 출력하여 보자.
--방법1
DECLARE
    emp_job emp.job%TYPE;
    emp_sal emp.sal%TYPE;
    emp_hire emp.hiredate%TYPE;
    emp_comm emp.comm%TYPE;
    dept_dname dept.dname%TYPE;
BEGIN
    SELECT E.job, E.sal, E.hiredate, E.comm, D.dname INTO emp_job, emp_sal, emp_hire, emp_comm, dept_dname 
    FROM emp E INNER JOIN dept D ON E.deptno = D.deptno WHERE E.ename = 'WARD';
    
     DBMS_OUTPUT.PUT_LINE('WARD의 직무 / 급여 / 입사일자 / 커미션 / 부서명');
     DBMS_OUTPUT.PUT_LINE(emp_job || ' / ' || emp_sal || ' / ' || emp_hire || ' / ' || emp_comm || ' / ' || dept_dname);
END;
/

--방법2
DECLARE
    vemp emp%rowType;
    vdept dept%rowType;
BEGIN
    SELECT job, sal, hiredate, comm, dname INTO vemp.job, vemp.sal, vemp.hiredate, vemp.comm, vdept.dname
    FROM emp INNER JOIN dept ON emp.deptno = dept.deptno WHERE ename = 'WARD';
    
    DBMS_OUTPUT.PUT_LINE('WARD의 직무 / 급여 / 입사일자 / 커미션 / 부서명');
    DBMS_OUTPUT.PUT_LINE(vemp.job || ' / ' || vemp.sal || ' / ' || vemp.hiredate || ' / ' || vemp.comm || ' / ' || vdept.dname);
END;
/

/*사원 테이블(emp01)에서 사원번호가 제일 큰 사원을 찾아낸 뒤, 이 번호에 +3으로 사원번호를 부여하여 
아래의 사원을 사원테이블에 신규 입력하는 PL/SQL을 만들어 보자.

<사원명> : OLIVIA
<급 여> : 2800
<입사일자> : 현재일자
<상사번호> : 7788
<직 무> : SALESMAN
<부서번호> : 10
*/
DECLARE
    emp_empno emp.empno%TYPE;
BEGIN
    SELECT MAX(empno) INTO emp_empno FROM emp_copy;
    
--    emp_empno := emp_empno + 3;
--    INSERT INTO emp_copy(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES(emp_empno, 'OLIVIA', 'SALESMAN', 7788, SYSDATE, 2800, 0, 10);
    
    INSERT INTO emp_copy(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES(emp_empno+3, 'OLIVIA', 'SALESMAN', 7788, SYSDATE, 2800, 0, 10);
    
    --완료를 위한 커밋
    COMMIT; 
END;
/

SELECT * FROM emp_copy;