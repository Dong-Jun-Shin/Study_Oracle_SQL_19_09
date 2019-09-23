---실습
--회원 정보를 저장하는 테이블을 MEMBER란 이름으로 생성한다. MEMBER 테이블은 다음과 같은 칼럼으로 구성된다.
--(PK : 기본키라고 한다. PRIMARY KEY)
CREATE TABLE member(
    id VARCHAR2(20) NOT NULL PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    regno VARCHAR2(8) NOT NULL,
    hp VARCHAR2(13) NULL,
    address VARCHAR2(100) NULL
);
INSERT INTO member(id, name, regno, hp, address) VALUES('java12', 'HONG', '60/03/01', '010-1111-2222', 'KOREA');
INSERT INTO member VALUES('javauser', '홍길동', '19660606', '01012345678', '서울시 성동구');
INSERT INTO member VALUES('dbuser', '김철수', '19890124', NULL, NULL);
INSERT INTO member(id, name, regno) VALUES('springuser', 'dlwlsgml', '19981201');

DESC member;
SELECT * FROM member;
--도서 정보를 저장하는 테이블을 BOOK이란 이름으로 생성한다. 테이블은 다음과 같은 칼럼으로 구성된다.
CREATE TABLE book(
    code NUMBER(4) NOT NULL  PRIMARY KEY,
    title VARCHAR2(50) NOT NULL,
    count NUMBER(6) NULL,
    price NUMBER(10) NULL,
    publish VARCHAR2(50) NULL
);

DESC book;

--회원이 책을 주문하였을 때 이에 대한 정보를 저장하는 테이블로 이름은 BOOK_ORDER로 한다. 테이블은 다음과 같은 칼럼으로 구성된다.
CREATE TABLE book_order(
    no VARCHAR2(10) NOT NULL PRIMARY KEY,
    id VARCHAR2(20) NOT NULL,
    code NUMBER(4) NOT NULL,
    count NUMBER(6) NULL,
    or_date DATE NULL
);

DESC book_order;

--부서 테이블 DEPTNO01을 생성한다.
CREATE TABLE dept01(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);
--칼럼 DEPTNO에 10번 부서, DNAME에는 'ACCOUNTING'을, LOC에는 'NEW YORK'을 추가하자
INSERT INTO dept01(deptno, dname, loc) VALUES(10, 'ACCOUNTING', 'NEW YORK');

DESC dept01;
SELECT * FROM dept01;