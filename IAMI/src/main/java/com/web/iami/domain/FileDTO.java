package com.web.iami.domain;

import java.sql.Timestamp;

public class FileDTO {
	
	private int file_no;
	private int pot_no;
	private String file_name;
	private Timestamp file_regdate;

	public FileDTO() { }

	public FileDTO(int file_no, int pot_no, String file_name, Timestamp file_regdate) {
		this.file_no = file_no;
		this.pot_no = pot_no;
		this.file_name = file_name;
		this.file_regdate = file_regdate;
	}

	public int getFile_no() {
		return file_no;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}

	public int getPot_no() {
		return pot_no;
	}

	public void setPot_no(int pot_no) {
		this.pot_no = pot_no;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public Timestamp getFile_regdate() {
		return file_regdate;
	}

	public void setFile_regdate(Timestamp file_regdate) {
		this.file_regdate = file_regdate;
	}
	
}