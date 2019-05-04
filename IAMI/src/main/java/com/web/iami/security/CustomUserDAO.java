package com.web.iami.security;

public interface CustomUserDAO {
	public CustomUserDetails selectMemberById(String id);
}