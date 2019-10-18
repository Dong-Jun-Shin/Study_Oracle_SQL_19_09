----랜덤값 가져오기
--1부터 5 중에서 임의 숫자 1개
SELECT DBMS_RANDOM.VALUE(1, 5) FROM DUAL;
--1개의 임의문자
SELECT DBMS_RANDOM.STRING('U', 1) FROM DUAL;
--대소문자 관계없이 임의문자 2개
SELECT DBMS_RANDOM.STRING('A', 2) FROM DUAL; 

DECLARE
    vsal NUMBER := 0;
    vdeptno NUMBER := 0;
BEGIN
    --정수 일의자리에서 반올림
    vdeptno := ROUND(DBMS_RANDOM.VALUE(10, 50), -1);
    
    SELECT sal INTO vsal FROM emp WHERE deptno = vdeptno AND ROWNUM = 1;
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || vdeptno || ', 급여 : ' || vsal);
    
    IF vsal BETWEEN 1 AND 1500 THEN 
        DBMS_OUTPUT.PUT_LINE('낮음');
    ELSIF vsal BETWEEN 1501 AND 5000 THEN 
        DBMS_OUTPUT.PUT_LINE('중간');
    ELSIF vsal BETWEEN 5001 AND 8000 THEN 
        DBMS_OUTPUT.PUT_LINE('높음');
    ELSE
        DBMS_OUTPUT.PUT_LINE('최상위');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(vdeptno||' 부서에 해당 사원이 없습니다.');
END;
/


----반복문
--Basic Loop문
DECLARE
    vn_base_num NUMBER := 3;
    vn_cnt           NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('****구구단 3단****');
    LOOP
        DBMS_OUTPUT.PUT_LINE(vn_base_num || '*' || vn_cnt || '=' || vn_base_num * vn_cnt);
        vn_cnt := vn_cnt+1;
        EXIT WHEN vn_cnt >9;
--        IF vn_cnt >9 THEN
--            EXIT;
--        END IF;
    END LOOP;
END;
/

--FOR LOOP문
DECLARE
    vdept dept%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------');
    --변수 CND는 1부터 1씩 증가하다가 4에 도달하면 반복문에서 벗어난다.
    FOR cnt IN REVERSE 1..4 LOOP
        SELECT * INTO vdept FROM dept WHERE deptno = 10 * cnt;
        DBMS_OUTPUT.PUT_LINE(vdept.deptno || '/' || vdept.dname || '/' || vdept.loc);
    END LOOP;
END;
/

--WHILE LOOP문
DECLARE
    i NUMBER := 1;
    vdept dept%ROWTYPE;
BEGIN
    WHILE i <= 4 LOOP
        IF i MOD 2 = 0 THEN
            SELECT * INTO vdept FROM dept WHERE deptno = 10 * i;
            DBMS_OUTPUT.PUT_LINE(vdept.deptno || '/' || vdept.dname || '/' || vdept.loc);
        END IF;
        i := i + 1;
    END LOOP;
END;
/