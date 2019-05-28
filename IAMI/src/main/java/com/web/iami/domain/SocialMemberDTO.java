package com.web.iami.domain;

public class SocialMemberDTO {
	
	private String mem_id;
	private String mem_pw;
	private String mem_nickname;
	private String mem_email;
	private int mem_gender;
	private String sns_gender;
	
	public SocialMemberDTO() { }

	public SocialMemberDTO(String mem_id, String mem_pw, String mem_nickname, String mem_email, int mem_gender,
			String sns_gender) {
		this.mem_id = mem_id;
		this.mem_pw = mem_pw;
		this.mem_nickname = mem_nickname;
		this.mem_email = mem_email;
		this.mem_gender = mem_gender;
		this.sns_gender = sns_gender;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}

	public String getMem_nickname() {
		return mem_nickname;
	}

	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public int getMem_gender() {
		return mem_gender;
	}

	public void setMem_gender(int mem_gender) {
		this.mem_gender = mem_gender;
	}

	public String getSns_gender() {
		return sns_gender;
	}

	public void setSns_gender(String sns_gender) {
		this.sns_gender = sns_gender;
	}

}
