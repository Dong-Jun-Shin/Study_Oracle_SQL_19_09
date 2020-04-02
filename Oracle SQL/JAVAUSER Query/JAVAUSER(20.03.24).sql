-- ORDER BY를 활용한 정렬 조회
SELECT * FROM spring_reply ORDER BY b_num desc;
SELECT * FROM spring_board ORDER BY b_num desc;

-- hint 문법과 INDEX를 활용한 정렬 조회
SELECT /*+INDEX_DESC(spring_board spring_board_pk)*/
    *
FROM spring_board WHERE b_num > 0;


-- rowid 고유 식별자
SELECT rowid, b_num FROM spring_board;


-- 힌트 없이 조회 (아무 정렬 기준 없는 상태로 순차 출력)
SELECT rownum, b_num, b_name, b_title, to_char(b_date, 'YYYY-MM-DD') as b_date
FROM spring_board WHERE rownum <= 10;

-- 힌트에 제시한 기준으로 정렬 후, 1번부터 10번까지의 한 페이지 단위 데이터를 출력
SELECT /*+ INDEX_DESC(spring_board spring_board_pk) */
	rownum, b_num, b_name, b_title, to_char(b_date, 'YYYY-MM-DD') as b_date
FROM spring_board WHERE rownum <= 10;

-- In-line View로 힌트 활용한 데이터를 가져온 후, 11번부터 20번까지 출력 ()
-- In-line View에서 끝번호 조건, 바깥 쿼리에서 시작번호 조건
SELECT 
    rnum, b_num, b_name, b_title, to_char(b_date, 'YYYY-MM-DD') as b_date
FROM(
    SELECT /*+ INDEX_DESC(spring_board spring_board_pk) */
        rownum as rnum, b_num, b_name, b_title, b_date
    FROM spring_board WHERE rownum <= 10 AND b_title LIKE '%08%'
    )boardlist
WHERE rnum > 0;


--페이징 처리를 위한 샘플 데이터 입력 처리
CREATE OR REPLACE PROCEDURE board_paging_insert
IS
BEGIN
    FOR cnt IN 1..120 LOOP
        INSERT INTO spring_board(b_num, b_name, b_title, b_content, b_pwd) 
        VALUES(spring_board_seq.NEXTVAL, '홍길동'||cnt, 
        '페이징 처리를 위한 데이터'||cnt, '페이징 처리를 위한 데이터 입력입니다', '1234');
    END LOOP;
    COMMIT;
END;
/
SHOW ERROR;

EXECUTE board_paging_insert;
SELECT COUNT(*) FROM spring_board;


--갤러리 샘플 데이터 입력
CREATE OR REPLACE PROCEDURE gallery_paging_insert
IS
BEGIN
    FOR cnt IN 1..120 LOOP
        INSERT INTO spring_gallery(g_num, g_name, g_subject, g_content, g_thumb, g_file, g_pwd, g_date) 
        VALUES(spring_gallery_seq.NEXTVAL, '사진'||cnt, 
        '사진 부제목'||cnt, '사진 내용'||cnt, 'thumb_file_image'||cnt, 'file_image'||cnt, '1234', SYSDATE);
    END LOOP;
    COMMIT;
END;
/
SHOW ERROR;

EXECUTE gallery_paging_insert;
SELECT COUNT(*) FROM spring_gallery;