--자바연동 books 테이블
CREATE SEQUENCE books_seq
START WITH 1
INCREMENT BY 1
MINVALUE 0
MAXVALUE 9999
NOCYCLE
CACHE 2;

DROP SEQUENCE books_seq;

SELECT * FROM books;


--자바연동 SUBJECT 테이블
CREATE SEQUENCE subject_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9999
NOCYCLE
CACHE 2;

DROP SEQUENCE subject_seq;
INSERT INTO subject(no, s_num, s_name) VALUES(subject_seq.NEXTVAL, '10', '통계학과');
DELETE FROM subject WHERE no = '10';
SELECT subject_seq.NEXTVAL FROM subject;

SELECT no, s_num, s_name FROM subject WHERE s_name LIKE '%터%';
SELECT no, s_num, s_name FROM subject WHERE s_name LIKE '%&s_name%';

SELECT * FROM subject;
SELECT * FROM subject;