package com.web.iami.domain;

import java.util.Date;

public class VisitDTO {
	
	private int vit_no;
	private Date vit_date;
	private int vit_count;
	
	public VisitDTO() { }
	
	public VisitDTO(int vit_no, Date vit_date, int vit_count) {
		this.vit_no = vit_no;
		this.vit_date = vit_date;
		this.vit_count = vit_count;
	}
	
	public int getVit_no() {
		return vit_no;
	}
	
	public void setVit_no(int vit_no) {
		this.vit_no = vit_no;
	}
	
	public Date getVit_date() {
		return vit_date;
	}
	
	public void setVit_date(Date vit_date) {
		this.vit_date = vit_date;
	}
	
	public int getVit_count() {
		return vit_count;
	}
	
	public void setVit_count(int vit_count) {
		this.vit_count = vit_count;
	}
	
}
