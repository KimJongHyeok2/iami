package com.web.iami.domain;

import java.security.MessageDigest;
import java.sql.Date;
import java.sql.Timestamp;

import com.web.iami.util.PasswordEncoding;

public class MemberDTO {

	private int mem_no; // 고유번호
	private String mem_id; // 아이디
	private String mem_pw; // 비밀번호
	private String mem_nickname; // 닉네임
	private int mem_gender; // 성별
	private String mem_profile; // 프로필 사진
	private Date mem_birth; // 생년월일
	private String mem_email; // 이메일
	private Timestamp mem_regdate; // 가입일시
	private String mem_auth; // 권한
	private int enabled; // 상태
	
	public MemberDTO() { }

	public MemberDTO(int mem_no, String mem_id, String mem_pw, String mem_nickname, int mem_gender, String mem_profile,
			Date mem_birth, String mem_email, Timestamp mem_regdate, String mem_auth, int enabled, Exception e) {
		this.mem_no = mem_no;
		this.mem_id = mem_id;
		this.mem_pw = mem_pw;
		this.mem_nickname = mem_nickname;
		this.mem_gender = mem_gender;
		this.mem_profile = mem_profile;
		this.mem_birth = mem_birth;
		this.mem_email = mem_email;
		this.mem_regdate = mem_regdate;
		this.mem_auth = mem_auth;
		this.enabled = enabled;
	}
	
	public int getMem_no() {
		return mem_no;
	}

	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
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
		// 비밀번호 SHA 암호화
/*		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(mem_pw.getBytes());
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				String hex = Integer.toHexString(0xff & byteData[i]);
				if (hex.length() == 1) {
					hexString.append('0');
				}
				hexString.append(hex);
			}
			this.mem_pw = hexString.toString();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}*/
		// BCrypt 암호화
		PasswordEncoding passwordEncode = new PasswordEncoding();
		this.mem_pw = passwordEncode.encode(mem_pw);
	}

	public String getMem_nickname() {
		return mem_nickname;
	}

	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}

	public int getMem_gender() {
		return mem_gender;
	}

	public void setMem_gender(int mem_gender) {
		this.mem_gender = mem_gender;
	}

	public String getMem_profile() {
		return mem_profile;
	}

	public void setMem_profile(String mem_profile) {
		this.mem_profile = mem_profile;
	}

	public Date getMem_birth() {
		return mem_birth;
	}

	public void setMem_birth(Date mem_birth) {
		this.mem_birth = mem_birth;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public Timestamp getMem_regdate() {
		return mem_regdate;
	}

	public void setMem_regdate(Timestamp mem_regdate) {
		this.mem_regdate = mem_regdate;
	}

	public String getMem_auth() {
		return mem_auth;
	}

	public void setMem_auth(String mem_auth) {
		this.mem_auth = mem_auth;
	}

	public int getEnabled() {
		return enabled;
	}

	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	
}