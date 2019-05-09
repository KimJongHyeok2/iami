package com.web.iami.service;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.web.iami.persistent.LoginDAO;

@Service("LoginService")
public class LoginServiceImpl implements LoginService {

	@Inject
	private LoginDAO dao;
	
	@Override
	public String selectFindID(Map<String, String> map) throws Exception {
		return dao.selectFindID(map);
	}

	@Override
	public Integer selectFindPW(Map<String, String> map) throws Exception {
		return dao.selectFindPW(map);
	}

	@Override
	public int updateMemberPW(Map<String, String> map) throws Exception {
		return dao.updateMemberPW(map);
	}

}