-- 학과번호, 학생명, 학과명을 조회해 주세요.
SELECT ST.s_num, sd_name, s_name FROM student ST, subject SU WHERE ST.s_num = SU.s_num;
