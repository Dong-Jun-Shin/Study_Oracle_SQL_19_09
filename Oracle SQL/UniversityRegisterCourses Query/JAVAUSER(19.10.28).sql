/*
ㅇ학과 정보를 삭제할 프로시저(subject_del)를 생성하여 보자.
- 매개변수는 삭제할 대상의 no(vno) /IN, 
  검증할 학과 번호(vs_num) /IN, 
  결과를 반환할 메시지(vmsg) /OUT

- 학과에 소속된 학생이 존재하지 않으면 삭제 후 '학과 정보를 정상적으로 삭제하였습니다.'

- 학과에 소속된 학생이 존재하면 '학과에 소속된 학생이 존재하기 때문에 삭제할 수가 없습니다.'
*/
--예외처리를 활용
CREATE OR REPLACE PROCEDURE subject_del(
    vno subject.no%TYPE, --IN은 기본값이라 생략 가능
    vs_num IN subject.s_num%TYPE,
    vmsg OUT VARCHAR2
)
IS
   cnt NUMBER := 0;
   DATAEXIST EXCEPTION; --예외 정의
BEGIN
        SELECT COUNT(*) INTO cnt FROM student WHERE s_num = vs_num;
        
    IF cnt = 0 THEN
        DELETE FROM subject WHERE no = vno;
        vmsg := '학과 정보를 정상적으로 삭제하였습니다.';
        COMMIT; --변경사항을 작업 단위 저장
    ELSE
        RAISE DATAEXIST; --예외 발생
    END IF;
EXCEPTION 
    WHEN DATAEXIST THEN
        vmsg := '학과에 소속된 학생이 존재하기 때문에 삭제할 수가 없습니다.';
    ROLLBACK; --변경사항을 작업 단위 취소
END subject_del;
/

-- IF 활용
CREATE OR REPLACE PROCEDURE subject_del(
    vno subject.no%TYPE, --IN은 기본값이라 생략 가능
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
        COMMIT; --변경사항을 작업 단위 저장
    ELSE
       vmsg := '학과에 소속된 학생이 존재하기 때문에 삭제할 수가 없습니다.';
    END IF;
END subject_del;
/

DECLARE
    msg VARCHAR2(100);
BEGIN
    subject_del(1, '01', msg); --자료형 맞춰서 대입하기
    DBMS_OUTPUT.PUT_LINE(msg);
END;
/

--월단위 생일자수를 위한 쿼리문.
SELECT COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '01', 1)) Jan,
COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '02', 1)) Feb,
COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '03', 1)) Mar,
COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '04', 1)) Apr,
COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '05', 1)) May,
COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '06', 1)) Jun,
COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '07', 1)) Jul,
COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '08', 1)) Aug,
COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '09', 1)) Sept,
COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '10', 1)) Oct,
COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '11', 1)) Nov,
COUNT(DECODE(TO_CHAR(sd_birth, 'MM'), '12', 1)) Dec
FROM student;