/* Drop Tables */

DROP TABLE recomments CASCADE CONSTRAINTS;
DROP TABLE comments CASCADE CONSTRAINTS;
DROP TABLE customerNotice CASCADE CONSTRAINTS;
DROP TABLE emailAccessKeys CASCADE CONSTRAINTS;
DROP TABLE recommendHistory CASCADE CONSTRAINTS;
DROP TABLE portfolio CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;
DROP TABLE visitor CASCADE CONSTRAINTS;

DROP SEQUENCE cnc_seq;
DROP SEQUENCE key_seq;
DROP SEQUENCE mem_seq;
DROP SEQUENCE pot_seq;
DROP SEQUENCE com_seq;
DROP SEQUENCE rcom_seq;
DROP SEQUENCE vit_seq;

/* Create Tables */

CREATE TABLE comments
(
	com_no number NOT NULL,
	mem_no number,
	pot_no number NOT NULL,
	com_nickname varchar2(30),
	com_pw varchar2(100),
	com_content clob NOT NULL,
	com_type number(2) NOT NULL,
	com_status number DEFAULT 1,
	com_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (com_no)
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

CREATE TABLE members
(
	mem_no number NOT NULL,
	mem_id varchar2(30) NOT NULL UNIQUE,
	mem_pw varchar2(100) NOT NULL,
	mem_nickname varchar2(30) DEFAULT 'NONE',
	mem_gender number(2) NOT NULL,
	mem_profile varchar2(300),
	mem_birth date,
	mem_email varchar2(100) NOT NULL,
	mem_regdate timestamp DEFAULT SYSDATE,
	mem_auth varchar2(20) DEFAULT 'ROLE_USER',
	mem_type number(5) DEFAULT 1,
	failureCount number DEFAULT 0,
	enabled number DEFAULT 1,
	PRIMARY KEY (mem_no)
);

CREATE TABLE portfolio
(
	pot_no number NOT NULL,
	mem_no number NOT NULL,
	pot_subject varchar2(70) NOT NULL,
	pot_description clob NOT NULL,
	pot_summary clob NOT NULL,
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

CREATE TABLE recommendHistory
(
	rec_no number NOT NULL,
	pot_no number NOT NULL,
	mem_no number,
	rec_ip varchar2(100) NOT NULL,
	PRIMARY KEY (rec_no)
);

CREATE TABLE recomments
(
	rcom_no number NOT NULL,
	mem_no number,
	pot_no number NOT NULL,
	com_no number NOT NULL,
	rcom_nickname varchar2(30),
	rcom_pw varchar2(100),
	rcom_content clob NOT NULL,
	rcom_type number(2) NOT NULL,
	rcom_status number DEFAULT 1,
	rcom_regdate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (rcom_no)
);

CREATE TABLE visitor
(
	vit_no number NOT NULL,
	vit_date date DEFAULT TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
	vit_count number DEFAULT 0,
	PRIMARY KEY (vit_no)
);

/* Create Foreign Keys */

ALTER TABLE recomments
	ADD FOREIGN KEY (com_no)
	REFERENCES comments (com_no)
;

ALTER TABLE customerNotice
	ADD FOREIGN KEY (mem_no)
	REFERENCES members (mem_no)
;

ALTER TABLE portfolio
	ADD FOREIGN KEY (mem_no)
	REFERENCES members (mem_no)
;

ALTER TABLE comments
	ADD FOREIGN KEY (pot_no)
	REFERENCES portfolio (pot_no)
;

ALTER TABLE recommendHistory
	ADD FOREIGN KEY (pot_no)
	REFERENCES portfolio (pot_no)
;

ALTER TABLE recomments
	ADD FOREIGN KEY (pot_no)
	REFERENCES portfolio (pot_no)
;

CREATE SEQUENCE cnc_seq;
CREATE SEQUENCE key_seq;
CREATE SEQUENCE mem_seq;
CREATE SEQUENCE pot_seq;
CREATE SEQUENCE com_seq;
CREATE SEQUENCE rcom_seq;
CREATE SEQUENCE vit_seq;

SELECT * FROM members;

SELECT * FROM portfolio;

UPDATE members SET mem_no = 22 WHERE mem_no = 100;

UPDATE members SET mem_auth = 'ROLE_ADMIN' WHERE mem_id = 'test13587';