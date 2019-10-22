--책번호(p_book_id)를 매개변수로 전달받아 책제목(r_title)을 외부로 반환하는 저장 프로시저(books_inproc)를 만들어라.
CREATE OR REPLACE PROCEDURE books_inproc(
    vp_book_id IN books.book_id%TYPE,
    vbooks OUT books%ROWTYPE)
IS
BEGIN
    SELECT * INTO vbooks FROM books WHERE book_id=vp_book_id;
EXCEPTION
    WHEN OTHERS THEN
        vbooks.title :='해당하는 책이 존재하지 않습니다.';
END books_inproc;
/
SHOW ERROR;

DECLARE
    p_id books.book_id%TYPE := 1;
    vbooks books%ROWTYPE; 
BEGIN
    books_inproc(p_id, vbooks);
    DBMS_OUTPUT.PUT_LINE(vbooks.title);
END;
/
