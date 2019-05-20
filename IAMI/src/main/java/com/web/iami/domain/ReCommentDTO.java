package com.web.iami.domain;

import java.sql.Timestamp;

public class ReCommentDTO {

	private int rcom_no; // 답글 고유번호
	private int mem_no; // 회원 고유번호
	private int pot_no; // 포트폴리오 고유번호
	private int com_no; // 부모 댓글 고유번호
	private String rcom_nickname; // (비회원)답글 작성자 닉네임
	private String rcom_pw; // (비회원)답글 작성자 비밀번호
	private String rcom_content; // 답글 내용
	private int rcom_type; // 답글 타입(비회원 : 1, 회원 : 2)
	private int rcom_status; // 답글 상태
	private Timestamp rcom_regdate; // 답글 작성일시

	// 회원 답글
	private String mem_id; // 회원 아이디
	private String mem_nickname; // 회원 닉네임
	private String mem_profile; // 회원 프로필 사진
	
	public ReCommentDTO() { }
	
	public ReCommentDTO(int rcom_no, int mem_no, int pot_no, int com_no, String rcom_nickname, String rcom_pw,
			String rcom_content, int rcom_type, int rcom_status, Timestamp rcom_regdate, String mem_id,
			String mem_nickname, String mem_profile) {
		this.rcom_no = rcom_no;
		this.mem_no = mem_no;
		this.pot_no = pot_no;
		this.com_no = com_no;
		this.rcom_nickname = rcom_nickname;
		this.rcom_pw = rcom_pw;
		this.rcom_content = rcom_content;
		this.rcom_type = rcom_type;
		this.rcom_status = rcom_status;
		this.rcom_regdate = rcom_regdate;
		this.mem_id = mem_id;
		this.mem_nickname = mem_nickname;
		this.mem_profile = mem_profile;
	}

	public int getRcom_no() {
		return rcom_no;
	}
	
	public void setRcom_no(int rcom_no) {
		this.rcom_no = rcom_no;
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
	
	public int getCom_no() {
		return com_no;
	}
	
	public void setCom_no(int com_no) {
		this.com_no = com_no;
	}
	
	public String getRcom_nickname() {
		return rcom_nickname;
	}
	
	public void setRcom_nickname(String rcom_nickname) {
		this.rcom_nickname = rcom_nickname;
	}
	
	public String getRcom_pw() {
		return rcom_pw;
	}
	
	public void setRcom_pw(String rcom_pw) {
		this.rcom_pw = rcom_pw;
	}
	
	public String getRcom_content() {
		return rcom_content;
	}
	
	public void setRcom_content(String rcom_content) {
		this.rcom_content = rcom_content;
	}
	
	public int getRcom_type() {
		return rcom_type;
	}
	
	public void setRcom_type(int rcom_type) {
		this.rcom_type = rcom_type;
	}
	
	public int getRcom_status() {
		return rcom_status;
	}
	
	public void setRcom_status(int rcom_status) {
		this.rcom_status = rcom_status;
	}
	
	public Timestamp getRcom_regdate() {
		return rcom_regdate;
	}
	
	public void setRcom_regdate(Timestamp rcom_regdate) {
		this.rcom_regdate = rcom_regdate;
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

	@Override
	public String toString() {
		return "ReCommentDTO [rcom_no=" + rcom_no + ", mem_no=" + mem_no + ", pot_no=" + pot_no + ", com_no=" + com_no
				+ ", rcom_nickname=" + rcom_nickname + ", rcom_pw=" + rcom_pw + ", rcom_content=" + rcom_content
				+ ", rcom_type=" + rcom_type + ", rcom_status=" + rcom_status + ", rcom_regdate=" + rcom_regdate
				+ ", mem_id=" + mem_id + ", mem_nickname=" + mem_nickname + ", mem_profile=" + mem_profile + "]";
	}
	
}