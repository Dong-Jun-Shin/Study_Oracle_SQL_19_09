--1. 학번, 학생명과 학과명을 출력하기
SELECT ST.sd_num, ST.sd_name, SB.s_name FROM subject SB INNER JOIN student ST ON SB.s_num = ST.s_num;
--2. 학과에 소속된 학생 수를 출력하기
SELECT SB.s_name, COUNT(ST.sd_num) FROM subject SB INNER JOIN student ST 
ON SB.s_num = ST.s_num GROUP BY SB.s_name;
--3. 전체 학과명에 소속된 학생 수를 출력하기
SELECT SB.s_name, COUNT(ST.sd_num) FROM subject SB LEFT OUTER JOIN student ST 
ON SB.s_num = ST.s_num GROUP BY SB.s_name;
--4. 수강 테이블(trainee)에서 수강 신청한 학생명, 과목명, 등록일(2018.12.28 형태)을 출력하기
--Oracle Join
SELECT ST.sd_name 학생명, LS.l_name 과목명, TO_CHAR(TR.t_date, 'YYYY.MM.DD') 등록일 FROM student ST, lesson LS, trainee TR 
WHERE ST.sd_num = TR.sd_num AND LS.l_abbre = TR.l_abbre;
--ANSI Join
SELECT ST.sd_name 학생명, LS.l_name 과목명, TO_CHAR(TR.t_date, 'YYYY.MM.DD') 등록일 FROM trainee TR 
INNER JOIN student ST ON ST.sd_num = TR.sd_num 
INNER JOIN lesson LS ON LS.l_abbre = TR.l_abbre;