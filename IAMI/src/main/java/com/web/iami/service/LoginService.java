package com.web.iami.service;

import java.util.Map;

public interface LoginService {
	public String selectFindID(Map<String, String> map) throws Exception;
	public Integer selectFindPW(Map<String, String> map) throws Exception;
	public int updateMemberPW(Map<String, String> map) throws Exception;
}