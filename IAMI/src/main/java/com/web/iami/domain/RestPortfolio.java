package com.web.iami.domain;

import java.util.List;

public class RestPortfolio {
	
	private List<PortfolioDTO> list; // 포트폴리오 목록
	private int count;
	private String status; // 상태
	
	// 선택한 회원정보
	private int mem_no;
	private String mem_id;
	private String mem_nickname;
	private String mem_profile;
	
	public RestPortfolio() { }

	public RestPortfolio(List<PortfolioDTO> list, int count, String status, int mem_no, String mem_id,
			String mem_nickname, String mem_profile) {
		this.list = list;
		this.count = count;
		this.status = status;
		this.mem_no = mem_no;
		this.mem_id = mem_id;
		this.mem_nickname = mem_nickname;
		this.mem_profile = mem_profile;
	}

	public List<PortfolioDTO> getList() {
		return list;
	}

	public void setList(List<PortfolioDTO> list) {
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

	public String getMem_nickname() {
		return mem_nickname;
	}

	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}

	public String getMem_profile() {
		return mem_profile;
	}

	public void setMem_profile(String mem_profile) {
		this.mem_profile = mem_profile;
	}
	
}