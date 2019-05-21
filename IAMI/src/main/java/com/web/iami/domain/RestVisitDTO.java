package com.web.iami.domain;

import java.util.List;

public class RestVisitDTO {
	
	private List<VisitDTO> list;
	private int count;
	private String status;
	
	public RestVisitDTO() { }
	
	public RestVisitDTO(List<VisitDTO> list, int count, String status) {
		this.list = list;
		this.count = count;
		this.status = status;
	}

	public List<VisitDTO> getList() {
		return list;
	}
	
	public void setList(List<VisitDTO> list) {
		this.list = list;
	}
	
	public int getCount() {
		return count;
	}
	
	public void setCount(int count) {
		this.count = count;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
}
