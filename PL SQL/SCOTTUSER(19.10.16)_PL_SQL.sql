----커서
--커서 사용
DECLARE
    vdept dept%ROWTYPE;
    CURSOR c1 IS SELECT * FROM dept;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호/부서명/지역명');
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    
    OPEN c1;
    --오픈한 c1커서가 한 개의 행의 정보를 읽어온다.
    LOOP
        FETCH c1 INTO vdept.deptno, vdept.dname, vdept.loc;
        EXIT WHEN c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vdept.deptno||' '||' '||vdept.dname||' '||vdept.loc);
    END LOOP;
    CLOSE c1;
END;
/

-- 커서와 FOR루프
DECLARE
    vdept dept%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호/부서명/지역명');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    --커서정의 부분을 FOR문에서 직접 사용 / (서브쿼리) 결과가 집합이고 묵시적 커서가 생성되어 있다.
    FOR vdept IN (SELECT * FROM dept) LOOP
        DBMS_OUTPUT.PUT_LINE(vdept.deptno||' '||vdept.dname||' '||vdept.loc);
    END LOOP;
END;
/

----프로시저
--저장 프로시저 생성
CREATE OR REPLACE PROCEDURE empproc
IS
    vword VARCHAR2(1);
    vemp emp%ROWTYPE;
    --vword를 받아왔다면, 그 이름을 포함하는 레코드를 찾아서 커서로 생성
    CURSOR c1(vword VARCHAR2) IS SELECT empno, ename, sal FROM emp WHERE ename LIKE '%'|| vword || '%';
BEGIN
    vword := DBMS_RANDOM.STRING('U',1);
    DBMS_OUTPUT.PUT_LINE('임의의 문자 : ' || vword);
    OPEN c1(vword);
    DBMS_OUTPUT.PUT_LINE('사번 / 사원명 / 급여');
    DBMS_OUTPUT.PUT_LINE('-------------------------------');
    LOOP
        FETCH c1 INTO vemp.empno, vemp.ename, vemp.sal;
        IF c1%ROWCOUNT = 0 THEN
             DBMS_OUTPUT.PUT_LINE('해당 사원이 존재하지 않습니다.');
        END IF;
        EXIT WHEN c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vemp.empno || ' / ' || vemp.ename || ' / ' || vemp.sal);
    END LOOP;
END;
/

--프로시저 실행
EXECUTE empproc;
EXEC empproc;