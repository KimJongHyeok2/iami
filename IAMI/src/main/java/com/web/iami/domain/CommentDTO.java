package com.web.iami.domain;

import java.sql.Timestamp;

public class CommentDTO {

	private int com_no; // 댓글 고유번호
	private int mem_no; // 회원 고유번호
	private int pot_no; // 포트폴리오 고유번호
	private String com_nickname; // (비회원)댓글 작성자 닉네임
	private String com_pw; // (비회원)댓글 작성자 비밀번호 
	private String com_content; // 댓글 내용
	private int com_type; // 댓글 타입(비회원 : 1, 회원 : 2)
	private int com_status; // 댓글 상태
	private Timestamp com_regdate; // 댓글 작성일시
	
	// 회원 댓글
	private String mem_id; // 회원 아이디
	private String mem_nickname; // 회원 닉네임
	private String mem_profile; // 회원 프로필 사진
	
	public CommentDTO() { }

	public CommentDTO(int com_no, int mem_no, int pot_no, String com_nickname, String com_pw, String com_content,
			int com_type, int com_status, Timestamp com_regdate, String mem_id, String mem_nickname,
			String mem_profile) {
		this.com_no = com_no;
		this.mem_no = mem_no;
		this.pot_no = pot_no;
		this.com_nickname = com_nickname;
		this.com_pw = com_pw;
		this.com_content = com_content;
		this.com_type = com_type;
		this.com_status = com_status;
		this.com_regdate = com_regdate;
		this.mem_id = mem_id;
		this.mem_nickname = mem_nickname;
		this.mem_profile = mem_profile;
	}

	public int getCom_no() {
		return com_no;
	}

	public void setCom_no(int com_no) {
		this.com_no = com_no;
	}

	public int getMem_no() {
		return mem_no;
	}

	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}

	public int getPot_no() {
		return pot_no;
	}

	public void setPot_no(int pot_no) {
		this.pot_no = pot_no;
	}

	public String getCom_nickname() {
		return com_nickname;
	}

	public void setCom_nickname(String com_nickname) {
		this.com_nickname = com_nickname;
	}

	public String getCom_pw() {
		return com_pw;
	}

	public void setCom_pw(String com_pw) {
		this.com_pw = com_pw;
	}

	public String getCom_content() {
		return com_content;
	}

	public void setCom_content(String com_content) {
		this.com_content = com_content;
	}

	public int getCom_type() {
		return com_type;
	}

	public void setCom_type(int com_type) {
		this.com_type = com_type;
	}

	public int getCom_status() {
		return com_status;
	}

	public void setCom_status(int com_status) {
		this.com_status = com_status;
	}

	public Timestamp getCom_regdate() {
		return com_regdate;
	}

	public void setCom_regdate(Timestamp com_regdate) {
		this.com_regdate = com_regdate;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMem_nickname() {
		return mem_nickname;
	}

	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}

	public String getMem_profile() {
		return mem_profile;
	}

	public void setMem_profile(String mem_profile) {
		this.mem_profile = mem_profile;
	}
	
}