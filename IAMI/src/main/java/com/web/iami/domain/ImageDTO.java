package com.web.iami.domain;

public class ImageDTO {

	private boolean uploaded;
	private String url;
	private String name;
	
	public ImageDTO() { }

	public ImageDTO(boolean uploaded, String url, String name) {
		this.uploaded = uploaded;
		this.url = url;
		this.name = name;
	}

	public boolean isUploaded() {
		return uploaded;
	}

	public void setUploaded(boolean uploaded) {
		this.uploaded = uploaded;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
