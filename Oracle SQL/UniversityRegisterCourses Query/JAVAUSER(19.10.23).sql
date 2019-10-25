----Subject 테이블
--파일 이름만 담아두는 용도의 컬럼(Filename) 생성
ALTER TABLE subject ADD(filename varchar2(100));

----자동으로 학과번호 부여 (표현방식별 쿼리)
--s_num으로부터 0을 제거하고(TRIM) 가장 큰 값(MAX)에서 +1을 해준 후, 
--전체 2자리의 구성 중 빈 자리를 0으로 채운다(LPAD) 만약 값이 없다면 01을 출력한다.
SELECT NVL(LPAD(MAX(TRIM('0' FROM s_num))+1, 2, '0'), '01') AS subjectNum FROM subject;
--시퀀스를 이용하여 4자리 코드번호 부여 (예를 들어 : 0005)
SELECT TRIM(TO_CHAR(subject_seq.NEXTVAL, '0000')) AS codeNumber FROM dual;
--문자와 시퀀스를 이용하여 문자 4자리 코드번호 부여(예를 들어: CODE0005)
SELECT CONCAT('CODE', TRIM(TO_CHAR(subject_seq.NEXTVAL, '0000'))) AS codeNumber FROM dual;

CREATE SEQUENCE subject_seq
START WITH 1
INCREMENT BY 1
MINVALUE 0
MAXVALUE 9999
NOCYCLE
CACHE 2;

SELECT * FROM subject;