package com.web.iami.domain;

import java.util.List;

public class RestCommentDTO {
	
	private List<CommentDTO> list; // 댓글 리스트
	private int count; // 불러온 댓글 수
	private String status; // 상태
	
	// 댓글 페이징
	private int page;
	private int row;
	private int pageBlock;
	private int pageCount;
	private int startPage;
	private int endPage;
	private int commentCount;
	
	public RestCommentDTO() { }

	public RestCommentDTO(List<CommentDTO> list, int count, String status, int page, int row, int pageBlock,
			int pageCount, int startPage, int endPage, int commentCount) {
		this.list = list;
		this.count = count;
		this.status = status;
		this.page = page;
		this.row = row;
		this.pageBlock = pageBlock;
		this.pageCount = pageCount;
		this.startPage = startPage;
		this.endPage = endPage;
		this.commentCount = commentCount;
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

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public int getPageBlock() {
		return pageBlock;
	}

	public void setPageBlock(int pageBlock) {
		this.pageBlock = pageBlock;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	
}