--books 도서 테이블 생성
CREATE TABLE books (
    book_id NUMBER NOT NULL, --책번호
    title VARCHAR2(50) NOT NULL, --도서명
    publisher VARCHAR2(30) NOT NULL, --출판사
    year VARCHAR2(4) NOT NULL, --출간년도
    price NUMBER , --책가격
    
    CONSTRAINT book_pk PRIMARY KEY(book_id)
);

--books_seq 시퀀스 생성
CREATE SEQUENCE books_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9999
NOCYCLE
CACHE 2;

--데이터 삽입
INSERT INTO books VALUES(books_seq.NEXTVAL, '책책 책', '책책출판', '2020', 33333);
INSERT INTO books VALUES(books_seq.NEXTVAL, '책 책책', '책출판', '2021', 22222);
INSERT INTO books VALUES(books_seq.NEXTVAL, '책 책 책', '책 책출판', '2022', 11111);

DELETE FROM books WHERE book_id > 0 AND book_id < 20;
DROP SEQUENCE books_seq;

--현재 시퀀스 값 확인
SELECT books_seq.CURRVAL FROM DUAL;
SELECT * FROM books;