package com.web.iami.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.web.iami.domain.NoticeDTO;
import com.web.iami.persistent.AdminDAO;

@Service("AdminService")
public class AdminServiceImpl implements AdminService {

	@Inject
	private AdminDAO dao;
	
	@Override
	public int insertNotice(NoticeDTO dto) throws Exception {
		return dao.insertNotice(dto);
	}

}
