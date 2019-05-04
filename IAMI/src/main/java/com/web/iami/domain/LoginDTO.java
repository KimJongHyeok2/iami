package com.web.iami.domain;

public class LoginDTO {

	private String mem_id;
	private String mem_pw;
	private String mem_auth;
	
	public LoginDTO() { }
	
	public LoginDTO(String mem_id, String mem_pw, String mem_auth) {
		super();
		this.mem_id = mem_id;
		this.mem_pw = mem_pw;
		this.mem_auth = mem_auth;
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
	
	public String getMem_auth() {
		return mem_auth;
	}
	
	public void setMem_auth(String mem_auth) {
		this.mem_auth = mem_auth;
	}
	
}