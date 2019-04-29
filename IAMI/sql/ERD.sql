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
	mem_id varchar2(30) NOT NULL,
	mem_pw varchar2(30) NOT NULL,
	mem_nickname varchar2(10) DEFAULT 'NONE',
	mem_profile varchar2(300),
	mem_birth date NOT NULL,
	mem_email varchar2(100) NOT NULL,
	mem_regdate timestamp DEFAULT SYSDATE,
	mem_auth varchar2(20) DEFAULT 'ROLE_USER',
	enabled number DEFAULT 0,
	PRIMARY KEY (mem_no)
);

CREATE TABLE portfolio
(
	pot_no number NOT NULL,
	mem_no number NOT NULL,
	pot_subject varchar2(70) NOT NULL,
	pot_description varchar2(100) NOT NULL,
	pot_summary varchar2(500) NOT NULL,
	pot_environment clob NOT NULL,
	pot_video clob,
	pot_source clob,
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
	ADD FOREIGN KEY (mem_no_req)
	REFERENCES members (mem_no)
;

ALTER TABLE friend
	ADD FOREIGN KEY (mem_no_res)
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

CREATE SEQUENCE car_seq;
CREATE SEQUENCE cnc_seq;
CREATE SEQUENCE key_seq;
CREATE SEQUENCE fre_seq;
CREATE SEQUENCE mem_seq;
CREATE SEQUENCE pot_seq;
CREATE SEQUENCE pro_seq;