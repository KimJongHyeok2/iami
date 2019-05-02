package com.web.iami.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.web.iami.domain.EmailAccessDTO;
import com.web.iami.persistent.RegisterDAO;

@Service("RegisterService")
public class RegisterServiceImpl implements RegisterService {

	@Inject
	private RegisterDAO dao;
	
	@Override
	public int insertAccessKey(EmailAccessDTO dto) throws Exception {
		return dao.insertAccessKey(dto);
	}

	@Override
	public String selectAccessKey(int key_no) throws Exception {
		return dao.selectAccessKey(key_no);
	}

}
