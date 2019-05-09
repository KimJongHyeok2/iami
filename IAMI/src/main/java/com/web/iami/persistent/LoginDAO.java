package com.web.iami.persistent;

import java.util.Map;

public interface LoginDAO {
	public String selectFindID(Map<String, String> map) throws Exception;
	public Integer selectFindPW(Map<String, String> map) throws Exception;
	public int updateMemberPW(Map<String, String> map) throws Exception;
}