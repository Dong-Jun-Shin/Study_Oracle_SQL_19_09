---예제
--사원번호, 사원명, 급여 3개의 칼럼으로 구성된 EMP01 테이블을 생성하라
CREATE TABLE emp01(
    empno NUMBER(4),
    ename VARCHAR2(20),
    sal NUMBER(7, 2)
);

--전체 테이블 조회
SELECT * FROM tab;
--테이블 조회
DESC emp01;

--기존 테이블 복사
CREATE TABLE emp02
AS
SELECT * FROM emp;


--emp01 테이블에 문자 타입의 직급(job) 칼럼을 추가
ALTER TABLE emp01
ADD(job VARCHAR2(9));

--이미 존재하는 emp01 테이블에 입사일 칼럼(CREDATE)를 날짜형으로 추가하라.
ALTER TABLE emp01 ADD(credate DATE);

--직급을 최대 30자까지 입력할 수 있도록 크기 수정
ALTER TABLE emp01 MODIFY(job VARCHAR2(30));

--기존 컬럼명 수정
ALTER TABLE emp01 RENAME COLUMN job TO work;

--컬럼 생성 및 삭제
ALTER TABLE emp01 ADD(abcd DATE);
ALTER TABLE emp01 DROP COLUMN abcd;

--emp01 테이블을 삭제
DROP TABLE emp01;

--recyclebin 구조 확인
DESC recyclebin;

--휴지통(recyclebin) 보기
SELECT * FROM recyclebin;

--휴지통 비우기 (해당 소유주의 오브젝트만 purge)
PURGE recyclebin;

--실수로 지운 테이블이라 삭제를 취소하려면 다음과 같은 명령으로 다시 복구하면 된다.
--FLASHBACK TABLE 테이블명 TO BEFORE DROP;
FLASHBACK TABLE emp01 TO BEFORE DROP;
--새로운 이름으로 복원하는 방법
FLASHBACK TABLE emp01 TO BEFORE DROP RENAME TO emp05;

--테이블 이름 바꾸기
RENAME emp02 TO emp03;

--emp03 테이블의 모든 로우(데이터)를 제거
TRUNCATE TABLE emp03;