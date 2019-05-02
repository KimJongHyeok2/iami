package com.web.iami.domain;

import java.util.Random;

public class EmailAccessDTO {
	
	private int key_no;
	private String key_accessKey;
	private boolean lowerCheck = false;
	private int size = 20;	

	public EmailAccessDTO() { initKey(); }

	public int getKey_no() {
		return key_no;
	}

	public void setKey_no(int key_no) {
		this.key_no = key_no;
	}

	public String getKey_accessKey() {
		return key_accessKey;
	}

	public void setKey_accessKey(String key_accessKey) {
		this.key_accessKey = key_accessKey;
	}

	public boolean isLowerCheck() {
		return lowerCheck;
	}

	public void setLowerCheck(boolean lowerCheck) {
		this.lowerCheck = lowerCheck;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	// 이메일 인증키 생성
	private void initKey() {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;

		do {
			num = ran.nextInt(75) + 48;
			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			} else {
				continue;
			}

		} while (sb.length() < size);
		if (lowerCheck) {
			this.key_accessKey = sb.toString().toLowerCase();
		}
		this.key_accessKey = sb.toString(); 
	}
	
}
