package com.web.iami.security;

public interface CustomUserDAO {
	public CustomUserDetails selectMemberById(String id);
	public int selectMemberFailureCount(String id);
	public int updateMemberFailureCount(String id);
	public int updateMemberEnabled(String id);
	public int updateMemberFailureCount_Init(String id);
}