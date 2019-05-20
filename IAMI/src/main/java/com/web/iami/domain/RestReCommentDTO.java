package com.web.iami.domain;

import java.util.List;

public class RestReCommentDTO {
	
	private List<ReCommentDTO> list; // 답글 리스트
	private int count; // 불러온 댓글 수
	private String status; // 상태
	
	public RestReCommentDTO() { }

	public RestReCommentDTO(List<ReCommentDTO> list, int count, String status) {
		this.list = list;
		this.count = count;
		this.status = status;
	}
	
	public List<ReCommentDTO> getList() {
		return list;
	}

	public void setList(List<ReCommentDTO> list) {
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