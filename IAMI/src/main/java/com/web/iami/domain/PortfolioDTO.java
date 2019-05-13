package com.web.iami.domain;

import java.sql.Timestamp;

public class PortfolioDTO {

	private int pot_no; // 포트폴리오 고유번호
	private int mem_no; // 회원 고유번호
	private String pot_subject; // 포트폴리오 제목
	private String pot_description; // 포트폴리오 서술
	private String pot_summary; // 포트폴리오 개요
	private String pot_startdate; // 포트폴리오 개발기간(시작)
	private String pot_enddate; // 포트폴리오 개발기간(종료)
	private String pot_environment; // 포트폴리오 주요환경
	private String pot_thumbnail; // 포트폴리오 섬네일
	private String pot_video; // 포트폴리오 동영상
	private String pot_source; // 포트폴리오 Demo, GitHub URL
	private int pot_status; // 포트폴리오 상태
	private Timestamp pot_regdate; // 포트폴리오 업로드 일시
	
	public PortfolioDTO() { }

	public PortfolioDTO(int pot_no, int mem_no, String pot_subject, String pot_description, String pot_summary,
			String pot_startdate, String pot_enddate, String pot_environment, String pot_thumbnail, String pot_video,
			String pot_source, int pot_status, Timestamp pot_regdate) {
		this.pot_no = pot_no;
		this.mem_no = mem_no;
		this.pot_subject = pot_subject;
		this.pot_description = pot_description;
		this.pot_summary = pot_summary;
		this.pot_startdate = pot_startdate;
		this.pot_enddate = pot_enddate;
		this.pot_environment = pot_environment;
		this.pot_thumbnail = pot_thumbnail;
		this.pot_video = pot_video;
		this.pot_source = pot_source;
		this.pot_status = pot_status;
		this.pot_regdate = pot_regdate;
	}

	public int getPot_no() {
		return pot_no;
	}

	public void setPot_no(int pot_no) {
		this.pot_no = pot_no;
	}

	public int getMem_no() {
		return mem_no;
	}

	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}

	public String getPot_subject() {
		return pot_subject;
	}

	public void setPot_subject(String pot_subject) {
		this.pot_subject = pot_subject;
	}

	public String getPot_description() {
		return pot_description;
	}

	public void setPot_description(String pot_description) {
		this.pot_description = pot_description;
	}

	public String getPot_summary() {
		return pot_summary;
	}

	public void setPot_summary(String pot_summary) {
		this.pot_summary = pot_summary;
	}

	public String getPot_startdate() {
		return pot_startdate;
	}

	public void setPot_startdate(String pot_startdate) {
		this.pot_startdate = pot_startdate;
	}

	public String getPot_enddate() {
		return pot_enddate;
	}

	public void setPot_enddate(String pot_enddate) {
		this.pot_enddate = pot_enddate;
	}

	public String getPot_environment() {
		return pot_environment;
	}

	public void setPot_environment(String pot_environment) {
		this.pot_environment = pot_environment;
	}

	public String getPot_thumbnail() {
		return pot_thumbnail;
	}

	public void setPot_thumbnail(String pot_thumbnail) {
		this.pot_thumbnail = pot_thumbnail;
	}

	public String getPot_video() {
		return pot_video;
	}

	public void setPot_video(String pot_video) {
		this.pot_video = pot_video;
	}

	public String getPot_source() {
		return pot_source;
	}

	public void setPot_source(String pot_source) {
		this.pot_source = pot_source;
	}

	public int getPot_status() {
		return pot_status;
	}

	public void setPot_status(int pot_status) {
		this.pot_status = pot_status;
	}

	public Timestamp getPot_regdate() {
		return pot_regdate;
	}

	public void setPot_regdate(Timestamp pot_regdate) {
		this.pot_regdate = pot_regdate;
	}

	@Override
	public String toString() {
		return "PortfolioDTO [pot_no=" + pot_no + ", mem_no=" + mem_no + ", pot_subject=" + pot_subject
				+ ", pot_description=" + pot_description + ", pot_summary=" + pot_summary + ", pot_startdate="
				+ pot_startdate + ", pot_enddate=" + pot_enddate + ", pot_environment=" + pot_environment
				+ ", pot_thumbnail=" + pot_thumbnail + ", pot_video=" + pot_video + ", pot_source=" + pot_source
				+ ", pot_status=" + pot_status + ", pot_regdate=" + pot_regdate + "]";
	}
	
}