package com.web.iami.domain;

import java.util.List;

public class RestCommentDTO {
	
	private List<CommentDTO> list; // 댓글 리스트
	private int count; // 불러온 댓글 수
	private String status; // 상태
	
	public RestCommentDTO() { }
	
	public RestCommentDTO(List<CommentDTO> list, int count, String status) {
		this.list = list;
		this.count = count;
		this.status = status;
	}

	public List<CommentDTO> getList() {
		return list;
	}

	public void setList(List<CommentDTO> list) {
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