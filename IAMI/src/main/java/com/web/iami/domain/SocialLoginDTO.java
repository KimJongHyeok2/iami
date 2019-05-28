package com.web.iami.domain;

public class SocialLoginDTO {
	
	private SocialMemberDTO dto;
	private String status;
	
	public SocialLoginDTO() { }

	public SocialLoginDTO(SocialMemberDTO dto, String status) {
		this.dto = dto;
		this.status = status;
	}

	public SocialMemberDTO getDto() {
		return dto;
	}

	public void setDto(SocialMemberDTO dto) {
		this.dto = dto;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
