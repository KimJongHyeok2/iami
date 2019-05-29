package com.web.iami.domain;

public class SocialInfoDTO {
	
	private String clientId;
	private String secretCode;
	
	public SocialInfoDTO() { }
	
	public SocialInfoDTO(String clientId, String secretCode) {
		this.clientId = clientId;
		this.secretCode = secretCode;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getSecretCode() {
		return secretCode;
	}

	public void setSecretCode(String secretCode) {
		this.secretCode = secretCode;
	}
	
}
