---시퀀스 생성
--생성
CREATE SEQUENCE emp_seq
START WITH 0
INCREMENT BY 1
MINVALUE 1
MAXVALUE 5
NOCYCLE
CACHE 2;

--시퀀스 삭제
DROP SEQUENCE emp_seq;

--기존 테이블 삭제
DROP TABLE emp01;

--구조만 복사하기
CREATE TABLE emp01
AS
SELECT empno, ename, hiredate FROM emp WHERE 1=0;

--시퀀스를 이용한 데이터 삽입
INSERT INTO emp01 VALUES(emp_seq.NEXTVAL, 'JULIA', sysdate);
DELETE FROM emp01 WHERE ename = 'JULIA';

SELECT * FROM emp01;



---시퀀스 수정 및 삭제
--기존 테이블 삭제
DROP TABLE dept01;

--테이블 구조만 복사해서 생성
CREATE TABLE dept01 
AS
SELECT * FROM dept WHERE 1=0;

--10부터 10씩 증가하면서 최대 30까지의 값을 갖는 시퀀스를 생성
CREATE SEQUENCE dept_seq
START WITH 0
INCREMENT BY 10
MINVALUE 0
MAXVALUE 30
NOCYCLE
CACHE 2;

--시퀀스로부터 부서번호를 자동으로 할당받아 데이터를 추가
INSERT INTO dept01 VALUES(dept_seq.NEXTVAL, '인사과', '서울');
INSERT INTO dept01 VALUES(dept_seq.NEXTVAL, '총무과', '대전');
INSERT INTO dept01 VALUES(dept_seq.NEXTVAL, '교육팀', '서울');

--NOCYCLE 상태에서 최대값인 30을 넘기는 경우 (DEPT_SEQ.NEXTVAL exceeds MAXVALUE)
INSERT INTO dept01 VALUES(dept_seq.NEXTVAL, '기술팀', '인천');

--시퀀스에 관한 데이터 딕셔너리 조회
SELECT sequence_name, min_value, max_value, increment_by, cycle_flag FROM user_sequences;

--시퀀스 수정
ALTER SEQUENCE dept_seq
 MAXVALUE 100;
 
--최대값 변경 후, 다시 삽입
INSERT INTO dept01 VALUES(dept_seq.NEXTVAL, '기술팀', '인천');

SELECT * FROM dept01;