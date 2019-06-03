package com.web.iami.domain;

import java.sql.Timestamp;

public class NoticeDTO {

	private int cnc_no; // 글 번호
	private int mem_no; // 회원번호
	private String cnc_subject; // 글 제목
	private String cnc_content; // 글 내용
	private int cnc_type; // 글 타입(일반, 이벤트)
	private int cnc_hasImage; // 글에 이미지가 있는지
	private int cnc_hasVideo; // 글에 동영상이 있는지
	private int cnc_viewcount; // 조회수
	private Timestamp cnc_regdate; // 글 작성일시
	
	// 이전글, 다음글 정보
	private int prev_cnc_no;
	private int next_cnc_no;
	private String prev_cnc_subject;
	private String next_cnc_subject;
	
	public NoticeDTO() { }

	public NoticeDTO(int cnc_no, int mem_no, String cnc_subject, String cnc_content, int cnc_type, int cnc_hasImage,
			int cnc_hasVideo, int cnc_viewcount, Timestamp cnc_regdate, int prev_cnc_no, int next_cnc_no,
			String prev_cnc_subject, String next_cnc_subject) {
		this.cnc_no = cnc_no;
		this.mem_no = mem_no;
		this.cnc_subject = cnc_subject;
		this.cnc_content = cnc_content;
		this.cnc_type = cnc_type;
		this.cnc_hasImage = cnc_hasImage;
		this.cnc_hasVideo = cnc_hasVideo;
		this.cnc_viewcount = cnc_viewcount;
		this.cnc_regdate = cnc_regdate;
		this.prev_cnc_no = prev_cnc_no;
		this.next_cnc_no = next_cnc_no;
		this.prev_cnc_subject = prev_cnc_subject;
		this.next_cnc_subject = next_cnc_subject;
	}

	public int getCnc_no() {
		return cnc_no;
	}

	public void setCnc_no(int cnc_no) {
		this.cnc_no = cnc_no;
	}

	public int getMem_no() {
		return mem_no;
	}

	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}

	public String getCnc_subject() {
		return cnc_subject;
	}

	public void setCnc_subject(String cnc_subject) {
		this.cnc_subject = cnc_subject;
	}

	public String getCnc_content() {
		return cnc_content;
	}

	public void setCnc_content(String cnc_content) {
		this.cnc_content = cnc_content;
	}

	public int getCnc_type() {
		return cnc_type;
	}

	public void setCnc_type(int cnc_type) {
		this.cnc_type = cnc_type;
	}

	public int getCnc_hasImage() {
		return cnc_hasImage;
	}

	public void setCnc_hasImage(int cnc_hasImage) {
		this.cnc_hasImage = cnc_hasImage;
	}

	public int getCnc_hasVideo() {
		return cnc_hasVideo;
	}

	public void setCnc_hasVideo(int cnc_hasVideo) {
		this.cnc_hasVideo = cnc_hasVideo;
	}

	public int getCnc_viewcount() {
		return cnc_viewcount;
	}

	public void setCnc_viewcount(int cnc_viewcount) {
		this.cnc_viewcount = cnc_viewcount;
	}

	public Timestamp getCnc_regdate() {
		return cnc_regdate;
	}

	public void setCnc_regdate(Timestamp cnc_regdate) {
		this.cnc_regdate = cnc_regdate;
	}

	public int getPrev_cnc_no() {
		return prev_cnc_no;
	}

	public void setPrev_cnc_no(int prev_cnc_no) {
		this.prev_cnc_no = prev_cnc_no;
	}

	public int getNext_cnc_no() {
		return next_cnc_no;
	}

	public void setNext_cnc_no(int next_cnc_no) {
		this.next_cnc_no = next_cnc_no;
	}

	public String getPrev_cnc_subject() {
		return prev_cnc_subject;
	}

	public void setPrev_cnc_subject(String prev_cnc_subject) {
		this.prev_cnc_subject = prev_cnc_subject;
	}

	public String getNext_cnc_subject() {
		return next_cnc_subject;
	}

	public void setNext_cnc_subject(String next_cnc_subject) {
		this.next_cnc_subject = next_cnc_subject;
	}

}