----제어문
--IF ~ THEN ~ END IF
DECLARE
    vemp emp%ROWTYPE;
    annsal NUMBER(7,2);
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 연봉');
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    
    SELECT * INTO vemp FROM emp WHERE ename = 'KING';
    
    IF(vemp.comm IS NULL) THEN
        vemp.comm := 0;
    END IF;
    
    --스칼라 변수에 연봉을 계산할 결과를 저장한다.
    annsal := vemp.sal*12+vemp.comm;
    --레퍼런스 변수와 스칼라 변수에 저장된 값을 출력한다.
    DBMS_OUTPUT.PUT_LINE('사원번호:'||vemp.empno||' / 사원명 :' || vemp.ename ||' / 연봉 : '||TO_CHAR(annsal, '$999,999')); 
END;
/


--IF ~ THEN ~ ELSE ~ END IF
DECLARE
    vemp emp%ROWTYPE;
    annsal NUMBER(7,2);
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 연봉');
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    
    SELECT * INTO vemp FROM emp WHERE ename = 'SMITH';
    
    IF(vemp.comm IS NULL) THEN
        annsal := vemp.sal*12;
    ELSE
        annsal := vemp.sal*12 + vemp.comm;
    END IF;
    
     DBMS_OUTPUT.PUT_LINE('사원번호:'||vemp.empno||' / 사원명 :' || vemp.ename ||' / 연봉 : '||TO_CHAR(annsal, '$999,999')); 
END;
/


--IF ~ THEN ~ ELSEIF ~ ELSE ~ END IF
DECLARE
    vemp emp%ROWTYPE;
    vdname dept.dname%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 연봉');
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    
    SELECT * INTO vemp FROM emp WHERE empno = 7934;
    
    IF(vemp.deptno = 10) THEN
        vdname := 'ACCOUNTING';
    ELSIF(vemp.deptno = 20) THEN
        vdname := 'RESEARCH';
    ELSIF(vemp.deptno = 30) THEN
        vdname := 'SALES';
    ELSIF(vemp.deptno = 40) THEN
        vdname := 'OPERATIONS';
    END IF;
    
     DBMS_OUTPUT.PUT_LINE('사원번호:'||vemp.empno||' / 사원명 :' || vemp.ename ||' / 부서명 : '|| vdname || '(' || vemp.deptno || ')'); 
END;
/
