--학과 테이블(일련번호, 학과번호, 학과명)
CREATE TABLE subject(
    no NUMBER,
    s_num VARCHAR2(2) NOT NULL,
    s_name VARCHAR(20) NOT NULL,
    
    CONSTRAINT subject_no_pk PRIMARY KEY(no),
    CONSTRAINT subject_s_num_uk UNIQUE(s_num)
);

INSERT INTO subject VALUES(1, '01', '컴퓨터학과');
INSERT INTO subject VALUES(2, '02', '교육학과');
INSERT INTO subject VALUES(3, '03', '신문방송학과');
INSERT INTO subject VALUES(4, '04', '인터넷비즈니스과');
INSERT INTO subject VALUES(5, '05', '기술경영과');


--학생 테이블(일련번호, 학번, 이름, 아이디, 비밀번호, 학과번호, 생년월일, 핸드폰번호, 주소, 이메일, 등록일자
CREATE TABLE student(
    no VARCHAR2(4),
    sd_num VARCHAR2(8) NOT NULL,
    sd_name VARCHAR2(10) NOT NULL,
    sd_id VARCHAR2(20) NOT NULL,
    sd_passwd VARCHAR2(20) NOT NULL,
    s_num VARCHAR2(2)  NOT NULL,
    sd_birth NUMBER(8) NOT NULL,
    sd_phone VARCHAR2(15) NOT NULL,
    sd_address VARCHAR2(40) NOT NULL,
    sd_email VARCHAR2(40) NOT NULL,
    sd_date DATE DEFAULT SYSDATE NOT NULL,
    
    CONSTRAINT student_no_pk PRIMARY KEY(no),
    CONSTRAINT student_sd_num_uk UNIQUE(sd_num),
    CONSTRAINT student_s_num_fk FOREIGN KEY(s_num) REFERENCES subject(s_num)
);

INSERT INTO student(no, sd_num, sd_name, sd_id, sd_passwd, s_num, sd_birth, sd_phone, sd_address, sd_email, sd_date)
                    VALUES(1, '06010001', '김정수', 'javajsp', 'java1234', '01', '1999/11/01', 
                    '010-1111-1111', '서울시 서대문구 창전동', 'aaaa@aaaa.com', SYSDATE);
INSERT INTO student(no, sd_num, sd_name, sd_id, sd_passwd, s_num, sd_birth, sd_phone, sd_address, sd_email, sd_date)
                    VALUES(2, '95010002', '김수현', 'jdbcmania', 'jdbc1234', '01', '1998/10/01', 
                    '010-2222-2222', '서울시 서초구 양재동', 'bbbb@bbbb.com', SYSDATE);
INSERT INTO student(no, sd_num, sd_name, sd_id, sd_passwd, s_num, sd_birth, sd_phone, sd_address, sd_email, sd_date)
                    VALUES(3, '98040001', '공지영', 'gonji', 'gon1234', '04', '1997/09/01', 
                    '010-3333-3333', '부산광역시 해운대구 반송동', 'cccc@cccc.com', SYSDATE);
INSERT INTO student(no, sd_num, sd_name, sd_id, sd_passwd, s_num, sd_birth, sd_phone, sd_address, sd_email, sd_date)
                    VALUES(4, '02050001', '조수영', 'water', 'water1234', '05', '1996/08/01', 
                    '010-4444-4444', '대전광역시 중구 은행동', 'dddd@dddd.com', SYSDATE);
INSERT INTO student(no, sd_num, sd_name, sd_id, sd_passwd, s_num, sd_birth, sd_phone, sd_address, sd_email, sd_date)
                    VALUES(5, '94040002', '최경란', 'novel', 'no1234', '04', '1995/07/01', 
                    '010-5555-5555', '경기도 수원시 장안구 이목동', 'eeee@eeee.com', SYSDATE);
INSERT INTO student(no, sd_num, sd_name, sd_id, sd_passwd, s_num, sd_birth, sd_phone, sd_address, sd_email, sd_date)
                    VALUES(6, '08020001', '안익태', 'korea', 'kor1234', '02', '1994/06/01', 
                    '010-6666-6666', '본인의 주소', 'ffff@ffff.com', SYSDATE);

--과목 테이블(일련번호, 과목약어, 과목명)
CREATE TABLE lesson(
    no NUMBER,
    l_abbre VARCHAR2(10) NOT NULL,
    l_name VARCHAR2(20) NOT NULL,
    
    CONSTRAINT lesson_no_pk PRIMARY KEY(no),
    CONSTRAINT lesson_l_abbre_uk UNIQUE(l_abbre)
);

INSERT INTO lesson VALUES(1, 'K', '국어');
INSERT INTO lesson VALUES(2, 'M', '수학');
INSERT INTO lesson VALUES(3, 'E', '영어');
INSERT INTO lesson VALUES(4, 'H', '역사');
INSERT INTO lesson VALUES(5, 'P', '프로그래밍');
INSERT INTO lesson VALUES(6, 'D', '데이터베이스');
INSERT INTO lesson VALUES(7, 'ED', '교육학이론');

--수강 테이블(일련번호, 학번, 과목약어, 과목구분, 등록일자)
CREATE TABLE trainee(
    no NUMBER,
    sd_num VARCHAR2(8) NOT NULL,
    l_abbre VARCHAR2(10) NOT NULL,
    t_section VARCHAR2(20) NOT NULL ,
    t_date DATE DEFAULT SYSDATE NOT NULL,
    
    CONSTRAINT trainee_l_abbre_fk FOREIGN KEY(l_abbre) REFERENCES lesson(l_abbre),
    CONSTRAINT trainee_sd_num_fk FOREIGN KEY(sd_num) REFERENCES student(sd_num)
);

INSERT INTO trainee(no, sd_num, l_abbre, t_section) 
                    VALUES(1, '06010001', 'K', 'culture');
INSERT INTO trainee(no, sd_num, l_abbre, t_section) 
                    VALUES(2, '95010002', 'M', 'culture');
INSERT INTO trainee(no, sd_num, l_abbre, t_section) 
                    VALUES(3, '98040001', 'E', 'culture');
INSERT INTO trainee(no, sd_num, l_abbre, t_section) 
                    VALUES(4, '02050001', 'H', 'culture');
INSERT INTO trainee(no, sd_num, l_abbre, t_section) 
                    VALUES(5, '94040002', 'P', 'major');
INSERT INTO trainee(no, sd_num, l_abbre, t_section) 
                    VALUES(6, '08020001', 'D', 'major');
INSERT INTO trainee(no, sd_num, l_abbre, t_section) 
                    VALUES(7, '08020001', 'ED', 'minor');


 
--DROP TABLE trainee;
--DROP TABLE lesson;
--DROP TABLE student;
--DROP TABLE subject;


