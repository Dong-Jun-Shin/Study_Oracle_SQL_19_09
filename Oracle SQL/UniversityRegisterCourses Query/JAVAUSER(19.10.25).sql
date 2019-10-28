----Student 테이블

SELECT * FROM student WHERE s_num = '01' order by no;

--학과번호가 01인 사람 기준으로 학번(sd_num)에서  뒷 4자리(SUBSTR)에서 '0'을 빼고(LTRIM) 
--숫자로(TO_NUMBER) 바꾼 후 최대값(MAX)을 뽑아서 1을 더해주고, 그 값을 0으로 채워준다.(LPAD)
--(값이 없을시(null), '0001'을 반환)
SELECT NVL(LPAD(MAX(TO_NUMBER(LTRIM(SUBSTR(sd_num, 5, 4), '0')))+1, 4, '0'), '0001') AS studentCount
FROM student WHERE s_num = '01';

--시퀀스 생성
CREATE SEQUENCE student_seq
START WITH 1
INCREMENT BY 1
MINVALUE 0
MAXVALUE 9999
NOCYCLE
CACHE 2;

SELECT student_seq.NEXTVAL FROM DUAL;
DROP SEQUENCE student_seq;

DELETE FROM student WHERE no=7;
