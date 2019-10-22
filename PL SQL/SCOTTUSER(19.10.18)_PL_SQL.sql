----저장 프로시저(IN OUT 모드)
--정의
CREATE OR REPLACE PROCEDURE proc_inoutmode(
    v_sal IN OUT VARCHAR2
)
IS
BEGIN
    v_sal := '$' || SUBSTR(v_sal, -9, 3) || ',' || SUBSTR(v_sal, -6, 3) || ',' || SUBSTR(v_sal, -3, 3);
END proc_inoutmode;
/
SHOW ERROR;

--실행
DECLARE
   strnum VARCHAR2(20) := '123456789';
BEGIN
    proc_inoutmode(strnum);
    DBMS_OUTPUT.PUT_LINE('strnum = ' || strnum);
END;
/


----패키지
--정의 (선언부)
CREATE OR REPLACE PACKAGE EMPPACK
IS
    PROCEDURE empproc;
    PROCEDURE empproc02(vdeptno IN emp.deptno%TYPE);
END;
/

--정의(몸체부)
CREATE OR REPLACE PACKAGE BODY emppack
IS
    PROCEDURE empproc
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

    PROCEDURE empproc02 (vdeptno IN emp.deptno%TYPE)
    IS 
        CURSOR c1 IS SELECT * FROM emp WHERE deptno=vdeptno;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('사원번호 / 사원명 / 급여');
        DBMS_OUTPUT.PUT_LINE('------------------------');
        FOR vemp IN c1 LOOP
            DBMS_OUTPUT.PUT_LINE(vemp.empno || ' / ' || vemp.ename || ' / ' ||  vemp.sal);
        END LOOP;
    END;
END;
/

--패키지 실행
EXECUTE emppack.empproc;

---예제
--예제 전 준비
DROP TABLE emp02;

CREATE TABLE emp02
AS
SELECT empno, ename, hiredate FROM emp;

ALTER TABLE emp02 ADD(retiredate date);

SELECT empno, ename, hiredate, retiredate FROM emp02;

--선언부
CREATE OR REPLACE PACKAGE emp02_pkg
IS
    --사번을 받아 이름을 반환하는 함수
    FUNCTION fn_get_emp02_name(vempno IN NUMBER)
    RETURN VARCHAR2;
    
--    --신규 사원 입력
    PROCEDURE new_emp02_proc
    (vename IN emp02.ename%TYPE, vhiredate emp02.hiredate%TYPE);
    
--    --퇴사 사원 처리
    PROCEDURE retire_emp02_proc(vempno IN emp02.empno%TYPE);
END;
/

--몸체부
CREATE OR REPLACE PACKAGE BODY emp02_pkg
IS
    --사원 조회
    FUNCTION fn_get_emp02_name(vempno IN NUMBER)
    RETURN VARCHAR2
    IS
        vename emp02.ename%TYPE;
    BEGIN
        -- 사원명을 가져온다.
        SELECT ename INTO vename FROM emp02 WHERE empno = vempno;
        --사원명 반환
        RETURN NVL(vename, '해당사원없음');
    END fn_get_emp02_name;
    
    ---신규사원 처리
    PROCEDURE new_emp02_proc
      (vename IN emp02.ename%TYPE, vhiredate emp02.hiredate%TYPE)
    IS
        vempno emp02.empno%TYPE;
    BEGIN
        --신규사원의 사번 = 최대 사번+1
        SELECT NVL(MAX(empno),0) + 1 INTO vempno FROM emp;
        
        INSERT INTO emp02(empno, ename, hiredate) VALUES(vempno, vename, NVL(vhiredate, SYSDATE));
        COMMIT;
        
        EXCEPTION WHEN OTHERS THEN
            --SQLERRorMessage
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            ROLLBACK;
    END new_emp02_proc;
    
    ---퇴사사원 처리
    PROCEDURE retire_emp02_proc(vempno IN emp02.empno%TYPE)
    IS
        cnt NUMBER := 0;
        --예외를 갖는 변수 선언
        e_no_data EXCEPTION;
    BEGIN
        --퇴사한 사원은 사원테이블에서 삭제하지 않고 일단 퇴사일자 (retiredate)를 NULL에서 갱신한다.
        UPDATE emp02 SET retiredate = SYSDATE WHERE empno = vempno AND retiredate IS NULL;
        
        --UPDATE된 건수를 가져온다. SQL : 직전에 실행된 쿼리의 결과가 담겨있음
        cnt := SQL%ROWCOUNT;
        
        --갱신된 건수가 없으면 사용자 예외처리
        IF cnt = 0 THEN
            --e_no_data의 예외를 발생시킨다.
            RAISE e_no_data;
        END IF;
        COMMIT;
        
        EXCEPTION 
            WHEN e_no_data THEN
                DBMS_OUTPUT.PUT_LINE(vempno || '에 해당되는 퇴사처리할 사원이 없습니다!');
                ROLLBACK;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
                ROLLBACK;
    END  retire_emp02_proc;
END emp02_pkg;
/

--번호를 이용한 조회
SELECT EMP02_PIKG.FN_GET_EMP02_NAME(7369) FROM DUAL;
--신규사원 추가
EXECUTE EMP02_PKG.NEW_EMP02_PROC('Roberts', SYSDATE);
--퇴사사원 추가
EXECUTE EMP02_PKG.RETIRE_EMP02_PROC(7950);

SELECT * FROM emp02;