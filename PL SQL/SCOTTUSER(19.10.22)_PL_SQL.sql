----트리거
--emp01 생성과 삭제
DROP TABLE emp01;

CREATE TABLE emp01(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(20),
    job VARCHAR2(50)
);

--사원 테이블에 로우가 추가되면 자동 수행할 트리거를 생성한다.
CREATE OR REPLACE TRIGGER emp_trg01
AFTER INSERT
ON emp01
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다.');
END;
/

--사원 테이블에 새로운 데이터 즉 신입 사원이 들어오면 급여 테이블에 새로운 데이터를 자동으로 
--생성하고 싶을 경우, 사원 테이블에 트리거를 설정하여 구현할 수 있다.
--사원과 관련된 테이블 생성
CREATE TABLE sal01(
    salno NUMBER(4),
    sal NUMBER,
    empno NUMBER(4),
    CONSTRAINT sal01_pk PRIMARY KEY(salno),
    CONSTRAINT sal01_fk FOREIGN KEY(empno) REFERENCES emp01(empno)
);

--급여 번호가 PRIMARY KEY이므로 중복된 데이터를 저장할 수 없다. 그래서 급여번호를 
--자동 생성하는 시퀀스를 정의하고 이 시퀀스로부터 일련번호를 얻어 급여번호에 부여한다.
CREATE SEQUENCE sal01_seq
START WITH 1
INCREMENT BY 1
MINVALUE 0 
MAXVALUE 100000
NOCYCLE
CACHE 2;

----사원의 정보가 추가될 때 급여 정보도 함께 추가하는 트리거
CREATE OR REPLACE TRIGGER emp_trg02
AFTER INSERT
ON emp01
FOR EACH ROW --관련 받는 행이 있을 때마다 실행
BEGIN
    INSERT INTO sal01(salno, sal, empno) VALUES(sal01_seq.NEXTVAL, 2000000, :NEW.empno);
END;
/

--사원의 정보가 제거될 때 급여 정보도 함께 삭제하는 트리거
CREATE OR REPLACE TRIGGER emp_trg03
AFTER DELETE ON emp01
FOR EACH ROW
BEGIN
    DELETE FROM sal01 WHERE empno =:OLD.empno;
END;
/

DELETE FROM emp01 WHERE empno = 1;
INSERT INTO emp01(empno, ename, job) VALUES(2, '가나다', '가가');
SELECT * FROM emp01;
SELECT * FROM sal01;

DROP TABLE sal01;
DROP TABLE emp01;
DROP SEQUENCE sal01_seq;