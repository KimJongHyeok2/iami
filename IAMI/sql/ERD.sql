
/* Drop Tables */

DROP TABLE career CASCADE CONSTRAINTS;
DROP TABLE customerNotice CASCADE CONSTRAINTS;
DROP TABLE emailAccessKeys CASCADE CONSTRAINTS;
DROP TABLE friend CASCADE CONSTRAINTS;
DROP TABLE portfolio CASCADE CONSTRAINTS;
DROP TABLE project CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE career
(
	car_no number NOT NULL,
	mem_no number NOT NULL,
	car_name varchar2(50) NOT NULL,
	car_joindate date NOT NULL,
	car_resigndate date NOT NULL,
	car_position varchar2(30),
	car_job varchar2(30),
	car_task varchar2(100) NOT NULL,
	car_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (car_no)
);


CREATE TABLE customerNotice
(
	cnc_no number NOT NULL,
	mem_no number NOT NULL,
	cnc_subject varchar2(100) NOT NULL,
	cnc_content clob NOT NULL,
	cnc_type number(10) DEFAULT 1,
	cnc_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (cnc_no)
);


CREATE TABLE emailAccessKeys
(
	key_no number NOT NULL,
	key_accessKey varchar2(30) NOT NULL,
	PRIMARY KEY (key_no)
);


CREATE TABLE friend
(
	fri_no number NOT NULL,
	mem_no_req number NOT NULL,
	mem_no_res number NOT NULL,
	fri_status number DEFAULT 1,
	PRIMARY KEY (fri_no)
);


CREATE TABLE members
(
	mem_no number NOT NULL,
	mem_id varchar2(30) NOT NULL UNIQUE,
	mem_pw varchar2(100) NOT NULL,
	mem_nickname varchar2(30) DEFAULT 'NONE',
	mem_gender number(2) NOT NULL,
	mem_profile varchar2(300),
	mem_birth date NOT NULL,
	mem_email varchar2(100) NOT NULL,
	mem_regdate timestamp DEFAULT SYSDATE,
	mem_auth varchar2(20) DEFAULT 'ROLE_USER',
	failureCount number DEFAULT 0,
	enabled number DEFAULT 1,
	PRIMARY KEY (mem_no)
);


CREATE TABLE portfolio
(
	pot_no number NOT NULL,
	mem_no number NOT NULL,
	pot_subject varchar2(70) NOT NULL,
	pot_description varchar2(100) NOT NULL,
	pot_summary varchar2(500) NOT NULL,
	pot_startdate date NOT NULL,
	pot_enddate date NOT NULL,
	pot_environment clob NOT NULL,
	pot_thumbnail varchar2(300) NOT NULL,
	pot_video clob NOT NULL,
	pot_source clob NOT NULL,
	pot_recommend number DEFAULT 0,
	pot_status number DEFAULT 1,
	pot_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (pot_no)
);


CREATE TABLE project
(
	pro_no number NOT NULL,
	mem_no number NOT NULL,
	pro_name varchar2(50),
	pro_joindate date NOT NULL,
	pro_resigndate date NOT NULL,
	pro_task varchar2(100) NOT NULL,
	pro_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (pro_no)
);



/* Create Foreign Keys */

ALTER TABLE career
	ADD FOREIGN KEY (mem_no)
	REFERENCES members (mem_no)
;


ALTER TABLE customerNotice
	ADD FOREIGN KEY (mem_no)
	REFERENCES members (mem_no)
;


ALTER TABLE friend
	ADD FOREIGN KEY (mem_no_res)
	REFERENCES members (mem_no)
;


ALTER TABLE friend
	ADD FOREIGN KEY (mem_no_req)
	REFERENCES members (mem_no)
;


ALTER TABLE portfolio
	ADD FOREIGN KEY (mem_no)
	REFERENCES members (mem_no)
;


ALTER TABLE project
	ADD FOREIGN KEY (mem_no)
	REFERENCES members (mem_no)
;


SELECT * FROM (SELECT rownum rnum, p.* FROM (SELECT * FROM portfolio ORDER BY pot_regdate DESC) p) WHERE rnum >= 1 AND rnum < 11;

SELECT p.*, m.mem_nickname, m.mem_id, m.mem_profile, m.mem_email FROM portfolio p, members m WHERE p.pot_no = 22 AND m.mem_no = p.mem_no;