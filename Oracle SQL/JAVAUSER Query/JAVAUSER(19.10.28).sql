CREATE TABLE sung(
    hakbun NUMBER NOT NULL,                    --학번
    hakname VARCHAR2(20) NOT NULL,         --이름
    kor NUMBER(4) NOT NULL,                       --국어
    eng NUMBER(4) NOT NULL,                      --영어
    mat NUMBER(4) NOT NULL,                      --수학
    tot NUMBER(4) DEFAULT 0,                       --총합
    avg NUMBER(5, 1) DEFAULT 0,                  --평균
    rank NUMBER(4),                                     --등수
    
    CONSTRAINT sung_hakbun_pk PRIMARY KEY(hakbun)
);

CREATE SEQUENCE sung_seq
START WITH 0
INCREMENT BY 1
MINVALUE 0
MAXVALUE 9999
NOCYCLE
CACHE 2;

--매개변수 선언하여 성적 테이블에 입력처리 프로시저 생성(sung_input)
--입력이 완료된 후에는 [DBMS 출력]영역에 '학생 등록 완료'라는 문자열이 출력되도록 한다.

----프로시저 실행 시 인수를 전달하여 성적 테이블에 입력을 처리하는 프로시저를 생성하여 보자
--테이블에 학번, 이름, 국어, 영어, 수학 점수를 입력하면 총점과 평균이 자동 계산되어 입력
CREATE OR REPLACE PROCEDURE sung_input(
    v_hakname IN sung.hakname%TYPE,
    v_kor IN sung.kor%TYPE,
    v_eng IN sung.eng%TYPE,
    v_mat IN sung.mat%TYPE
)
IS
    v_tot sung.tot%TYPE;
BEGIN
    v_tot := (v_kor + v_eng + v_mat);
    INSERT INTO sung(hakbun, hakname, kor, eng, mat, tot, avg) 
    VALUES(sung_seq.NEXTVAL, v_hakname, v_kor, v_eng, v_mat, v_tot, v_tot/3);
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('학생 등록 완료');
END;
/

EXECUTE sung_input('홍길동', 99, 80, 85);
SELECT * FROM sung;

----프로시저 실행 시 인수를 전달하여 성적 테이블에 입력을 처리하는 트리거를 생성하여 보자
--테이블에 학번, 이름, 국어, 영어, 수학 점수를 입력하면 총점과 평균이 자동 계산되어 입력
--BEFORE로 작성
CREATE OR REPLACE TRIGGER sung_tgr
BEFORE INSERT ON sung
FOR EACH ROW
BEGIN
    :NEW.tot := (:NEW.kor + :NEW.eng + :NEW.mat);
    :NEW.avg := :NEW.tot/3;
    
    DBMS_OUTPUT.PUT_LINE('총점, 평균 계산 완료');
END;
/

--AFTER로 작성
CREATE OR REPLACE TRIGGER sung_tgr
AFTER INSERT ON sung
BEGIN
    UPDATE sung SET tot = kor + eng + mat;
    UPDATE sung SET avg = tot/3;
    
    DBMS_OUTPUT.PUT_LINE('총점, 평균 계산 완료');
END;
/

EXECUTE sung_input('김희진', 95, 84, 79);
EXECUTE sung_input('이현수', 83, 89, 99);
SELECT * FROM sung ORDER BY hakbun;