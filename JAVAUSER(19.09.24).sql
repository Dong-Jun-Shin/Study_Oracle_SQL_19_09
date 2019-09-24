---로우 5개 입력
--칼럼명 모두 명시
INSERT INTO dept01 (deptno, dname, loc) VALUES(10, 'ACCOUNTING', 'NEW YORK');
--칼럼명 생략, 모두 입력
INSERT INTO dept01 VALUES(20, 'RESEARCH', 'DALLAS');
--특정 칼럼에 입력
INSERT INTO dept01 (deptno, dname) VALUES(30, 'SALES');
--입력시 NULL로 초기화
INSERT INTO dept01 VALUES (40, 'OPERATIONS', NULL);
--NULL을 입력한 칼럼을 제외하고 입력
INSERT INTO dept01 VALUES (50, '', 'CHICAGO');

--dept01의 자료를 dept02에 입력
INSERT INTO dept02 SELECT * FROM dept01;

--테이블 지우기
DELETE FROM dept01;
DELETE FROM book;
DELETE FROM book_order;
DELETE FROM member;

INSERT INTO dept01 VALUES(10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept01 VALUES(20, 'RESEARCH', 'DALLAS');
INSERT INTO dept01 VALUES(40, 'OPERATIONS', 'BOSTON');
SELECT * FROM dept01;

---------------------------------------------------------------------------------------
--book에 등록일(regdate) DATE / 입력이 없을 시, 기본으로 오늘 날짜로 변경
ALTER TABLE book ADD(regdate2 DATE DEFAULT SYSDATE);

-- '' = null
INSERT INTO book VALUES(10, 'ABC', 3, 9000, 'US', '19/09/23', '');
-- 지정값 입력
INSERT INTO book VALUES(20, 'School', 5, 3000, 'Teacher', SYSDATE, '19/09/23');
-- 지정값 입력, null 입력
INSERT INTO book VALUES(30, 'Rectangle', 2, 4000, 'Figure', SYSDATE, '');
-- 등록일 생략
INSERT INTO book(code, title, count, price, publish) VALUES(40, 'iPhone', 0, 18000, 'Apple');

UPDATE book SET code = 0001 WHERE code = 10;
UPDATE book SET code = 0002 WHERE code = 20;
UPDATE book SET code = 0003 WHERE code = 30;
UPDATE book SET code = 0005 WHERE code = 40;

DELETE FROM book WHERE code = 5;

ALTER TABLE book ADD(regdate DATE DEFAULT SYSDATE);
ALTER TABLE book MODIFY(regdate DATE DEFAULT SYSDATE);

--시간단위까지 비교가 되기 때문에 해당이 없는것으로 나온다.
DELETE FROM book WHERE SUBSTR(regdate, 1, 2) = '19';

SELECT * FROM book; 