----저장 프로시저
--에러 확인
CREATE OR REPLACE PROCEDURE empproc02 (vdeptno IN emp.deptno%TYPE)
IS 
    CURSOR c1
IS
    SELECT * FROM emp WHERE deptno=vdeptno;
BEGIN
    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원명 / 급여');
    DBMS_OUTPUT.PUT_LINE('------------------------');
    FOR vemp IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE(vemp.empno || ' / ' || vemp.ename || ' / ' ||  vemp.sal);
    END LOOP;
END;
/
SHOW ERROR;

EXECUTE empproc02(10);
EXECUTE empproc02(20);
EXECUTE empproc02(30);

--부서에 따라 급여를 인상시키는 프로시저 (10이면 10%, 20이면 20%)
CREATE OR REPLACE PROCEDURE empproc_inmode(v_deptno IN emp01.deptno%TYPE) 
IS
BEGIN
    UPDATE emp01 SET sal = DECODE(v_deptno, 10, sal*1.1, 20, sal*1.2, sal)
    WHERE deptno = v_deptno;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('수정이 완료되었습니다.');
END empproc_inmode;
/
SHOW ERROR;

EXECUTE empproc_inmode(10);

SELECT * FROM emp WHERE deptno = 10;
SELECT * FROM emp01 WHERE deptno = 10;


----저장 프로시저 (IN 모드)
---DEPT01 생성하고 컬럼 추가, 수정, 로우 입력 해보기
CREATE TABLE dept01(
    deptno NUMBER,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13) NOT NULL,
    
    CONSTRAINT dept01_deptno_pk PRIMARY KEY(deptno)
);

--시퀀스를 활용한 부서번호 부여
CREATE SEQUENCE dept_seq
    INCREMENT BY 10
    MINVALUE 0;

--로우 입력 방법1 (INSERT 하나씩 입력)
INSERT INTO dept01(deptno, dname, loc) VALUES(dept_seq.NEXTVAL, '인사과', '서울');
INSERT INTO dept01(deptno, dname, loc) VALUES(dept_seq.NEXTVAL, '총무과', '대전');
INSERT INTO dept01(deptno, dname, loc) VALUES(dept_seq.NEXTVAL, '교육과', '서울');
INSERT INTO dept01(deptno, dname, loc) VALUES(dept_seq.NEXTVAL, '기술과', '인천');
--방법1 (시퀀스 활용)
INSERT INTO dept01(deptno, dname, loc) VALUES(dept_seq.NEXTVAL, '시설관리팀', '광주');
--방법2 (SELECT문 활용)
INSERT INTO dept01 VALUES ((SELECT MAX(deptno) + 10 FROM dept01), '시설관리팀', '광주');

--로우 방법2 (프로시저 생성 활용)
CREATE OR REPLACE PROCEDURE deptproc_inmode(
    deptno IN dept01.deptno%TYPE,
    dname IN dept01.dname%TYPE,
    loc IN dept01.loc%TYPE)
IS
BEGIN
    INSERT INTO dept01(deptno, dname, loc, credate) VALUES(deptno, dname, loc, SYSDATE);
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명 / 등록일');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    
    --커서를 반복문에서 바로 정의
    FOR vdept IN (SELECT deptno, dname, loc, credate FROM dept01 ORDER BY deptno) LOOP
        DBMS_OUTPUT.PUT_LINE(vdept.deptno || ' / ' || RPAD(vdept.dname, 10) || '/ ' || vdept.loc || ' / ' || TO_CHAR(vdept.credate, 'YYYY-MM-DD'));
    END LOOP;
END;
/
SHOW ERROR;

EXECUTE deptproc_inmode(dept_seq.NEXTVAL, '기획부', '부산');

--날짜 컬럼 추가, 컬럼 이름 변경, 오늘 날짜 입력
ALTER TABLE dept01 ADD (hiredate DATE);
ALTER TABLE dept01 RENAME COLUMN hiredate TO credate;

--WHERE을 명시하지 않을 경우, 모든 행을 수정
UPDATE dept01 SET hiredate=SYSDATE;


----업데이트 프로시저 생성
CREATE OR REPLACE PROCEDURE deptproc_inup(
    pdeptno IN dept01.deptno%TYPE,
    pdname IN dept01.dname%TYPE,
    ploc IN dept01.loc%TYPE)
IS
    cnt NUMBER := 0;
    vdept dept01%ROWTYPE;
BEGIN
    SELECT COUNT(*) INTO cnt FROM dept01 WHERE deptno = pdeptno;
    IF cnt = 0 THEN
        INSERT INTO dept01(deptno, dname, loc, credate) VALUES(pdeptno, pdname, ploc, SYSDATE);
    ELSE
        UPDATE dept01
        SET dname = pdname, loc = ploc, credate = SYSDATE
        WHERE deptno = pdeptno;
    END IF;
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명 / 등록일');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
    
    --출력 방법1(일반 출력)
    SELECT deptno, dname, loc, credate INTO vdept FROM dept01 WHERE deptno = pdeptno;
    DBMS_OUTPUT.PUT_LINE(vdept.deptno || ' / ' || RPAD(vdept.dname, 10) || ' / ' || vdept.loc || ' / ' || TO_CHAR(vdept.credate, 'YYYY-MM-DD'));
    
    --출력 방법2(반복문 활용)
    FOR vdept IN (SELECT deptno, dname, loc, credate FROM dept01 WHERE deptno = pdeptno) LOOP
        DBMS_OUTPUT.PUT_LINE(vdept.deptno || ' / ' || RPAD(vdept.dname, 10) || ' / ' || vdept.loc || ' / ' || TO_CHAR(vdept.credate, 'YYYY-MM-DD'));
    END LOOP;
END deptproc_inup;
/
SHOW ERROR;

EXECUTE deptproc_inup(60, '기획부', '부산');
EXECUTE deptproc_inup(dept_seq.NEXTVAL, '행정부', '서울');
EXECUTE deptproc_inup(70, '영업부', '서울');

----저장 프로시저 (OUT모드)
--정의
CREATE OR REPLACE PROCEDURE empproc_outmode(
    vempno IN emp.empno%TYPE,
    vename OUT emp.ename%TYPE,
    vsal OUT emp.sal%TYPE,
    vjob OUT emp.job%TYPE
)
IS
BEGIN
    SELECT ename, sal, job INTO vename, vsal, vjob FROM emp WHERE empno = vempno;
END;
/
SHOW ERROR;

--실행
DECLARE
    vemp emp%ROWTYPE;
BEGIN
    empproc_outmode(7788, vemp.ename, vemp.sal, vemp.job);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || vemp.ename);
    DBMS_OUTPUT.PUT_LINE('급 여 : ' || vemp.sal);
    DBMS_OUTPUT.PUT_LINE('직 무 : ' || vemp.job);
END;
/

---해당 급여를 초과하는 사원들을 커서로 반환받도록 프로시저를 생성하여 보자.
--정의
CREATE OR REPLACE PROCEDURE emp_sal_data(
    vsal IN emp.sal%TYPE,
    vemp OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN vemp FOR SELECT empno, ename, sal FROM emp WHERE sal > vsal;
END;
/
SHOW ERROR;

--실행
DECLARE
    pemp SYS_REFCURSOR;
    vemp emp%ROWTYPE;
BEGIN
    --프로시저 실행 (해당 결과가 담긴 커서 반환);
    emp_sal_data(2500, pemp);
    LOOP
        --pemp커서에 담긴 결과를 vemp의 컬럼들로 삽입 (FETCH)
        FETCH pemp INTO vemp.empno, vemp.ename, vemp.sal;
        --반복되면서 pemp의 끝을 확인
        EXIT WHEN pemp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vemp.empno || ' . ' || RPAD(vemp.ename, 7) || ' ' || vemp.sal);
    END LOOP;
END;
/