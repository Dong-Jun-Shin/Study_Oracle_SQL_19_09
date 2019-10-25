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
    SET stock = stock + :NEW.rqty
    WHERE pcode = :NEW.pcode;
END;
/

--트리거를 실행시킨 후, 테이블에 행을 추가 (상품 테이블의 재고 수량이 변경됨을 확인할 수 있다.)
INSERT INTO receiving(rno, pcode, rqty, rprice, ramount) VALUES(1, 'A00001', 5, 850000, 950000);
SELECT * FROM receiving;
SELECT * FROM 상품;