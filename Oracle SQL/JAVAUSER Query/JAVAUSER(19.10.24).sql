--상품 테이블을 생성
CREATE TABLE product(
    pcode CHAR(6),
    pname VARCHAR2(12) NOT NULL,
    pcompany VARCHAR(12),
    pprice NUMBER(8),
    stock NUMBER default 0,
    
    CONSTRAINT product_pk PRIMARY KEY(pcode)
);

--입고 테이블을 생성
CREATE TABLE receiving(
    rno NUMBER(6),
    pcode CHAR(6),
    rdate date DEFAULT SYSDATE,
    rqty NUMBER(6),
    rprice NUMBER(8),
    ramount NUMBER(8),
    
    CONSTRAINT receiving_pk PRIMARY KEY(rno),
    CONSTRAINT receiving_fk FOREIGN KEY(pcode) REFERENCES product(pcode)
);

--샘플 데이터 입력
INSERT INTO product(pcode, pname, pcompany, pprice) VALUES('A00001', '세탁기', 'LG', 1500000);
INSERT INTO product(pcode, pname, pcompany, pprice) VALUES('A00002', '컴퓨터', 'LG', 1000000);
INSERT INTO product(pcode, pname, pcompany, pprice) VALUES('A00003', '냉장고', '삼성', 4500000);

SELECT * FROM product;

--입고 테이블의 입고 수량을 상품 테이블의 재고 수량에 추가
CREATE OR REPLACE TRIGGER trg_in
AFTER INSERT ON receiving
FOR EACH ROW
BEGIN
    UPDATE product
    SET stock = stock + :NEW.rqty --재고수량 = 재고수량 + 
    WHERE pcode = :NEW.pcode;
END;
/

--트리거를 실행시킨 후, 테이블에 행을 추가 (상품 테이블의 재고 수량이 변경됨을 확인할 수 있다.)
INSERT INTO receiving(rno, pcode, rqty, rprice, ramount) VALUES(1, 'A00001', 5, 850000, 950000);
SELECT * FROM receiving;
SELECT * FROM product;

--입고 테이블에 상품이 입력되면 자동으로 상품 테이블의 재고 수량이 증가하게 된다. 입고 테이블에 또 다른 상품을 입력한다.
INSERT INTO receiving(rno, pcode, rqty, rprice, ramount) VALUES(2, 'A00002', 10, 680000, 780000);
SELECT * FROM receiving;
SELECT * FROM product;

INSERT INTO receiving(rno, pcode, rqty, rprice, ramount) VALUES(3, 'A00003', 10, 250000, 300000);
SELECT * FROM receiving;
SELECT * FROM product;

----<실습1> 삭제 트리거 작성하기
--삭제 트리거 생성
CREATE OR REPLACE TRIGGER trg_del 
AFTER DELETE ON receiving 
FOR EACH ROW
BEGIN
    UPDATE product SET stock = stock + (-:old.rqty + :new.rqty)
    WHERE pcode = :new.pcode;
END;
/

--재고 수량이 같이 변하는 쿼리문 (삭제 트리거 작동 확인)
UPDATE receiving SET rqty=8, ramount=280000 --입고 수량과 입고금액
WHERE rno=3;

SELECT * FROM receiving;
SELECT * FROM product;


----<실습2> 삭제 트리거 작성하기
CREATE OR REPLACE TRIGGER trg_del
AFTER DELETE ON receiving
FOR EACH ROW
BEGIN
    UPDATE product SET stock = stock - :old.rqty
    WHERE pcode = :old.pcode;
END;
/

--삭제에 따른 재고 수량이 같이 변하는 쿼리문 (삭제 트리거 작동 확인)
DELETE receiving WHERE rno = 3;
SELECT * FROM receiving;
SELECT * FROM product;