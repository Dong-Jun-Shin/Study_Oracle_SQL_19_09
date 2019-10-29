CREATE OR REPLACE PROCEDURE subject_del(
    vno IN subject.no%TYPE,
    vs_num IN subject.s_num%TYPE,
    vmsg OUT VARCHAR2
)
IS
   cnt NUMBER := 0;
BEGIN
        SELECT COUNT(*) INTO cnt FROM student WHERE s_num = vs_num;
        
    IF cnt = 0 THEN
        DELETE FROM subject WHERE no = vno;
        vmsg := '학과 정보를 정상적으로 삭제하였습니다.';
    ELSE
        vmsg := '학과에 소속된 학생이 존재하기 때문에 삭제할 수가 없습니다.';
    END IF;
END;
/

DECLARE
    msg VARCHAR2(100);
BEGIN
    subject_del(1, 01, msg);
    DBMS_OUTPUT.PUT_LINE(msg);
END;
/