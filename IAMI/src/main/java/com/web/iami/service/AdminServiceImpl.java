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

	@Override
	public int updateNotice(NoticeDTO dto) throws Exception {
		return dao.updateNotice(dto);
	}

	@Override
	public int deleteNotice(int cnc_no) throws Exception {
		return dao.deleteNotice(cnc_no);
	}

}
