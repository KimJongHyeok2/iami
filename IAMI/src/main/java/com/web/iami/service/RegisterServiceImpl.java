package com.web.iami.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.web.iami.domain.EmailAccessDTO;
import com.web.iami.domain.MemberDTO;
import com.web.iami.domain.SocialMemberDTO;
import com.web.iami.persistent.RegisterDAO;

@Service("RegisterService")
public class RegisterServiceImpl implements RegisterService {

	@Inject
	private RegisterDAO dao;
	
	@Override
	public int selectID(String id) throws Exception {
		return dao.selectID(id);
	}
	
	@Override
	public int selectEmail(String email) throws Exception {
		return dao.selectEmail(email);
	}
	
	@Override
	public int insertAccessKey(EmailAccessDTO dto) throws Exception {
		return dao.insertAccessKey(dto);
	}

	@Override
	public String selectAccessKey(int key_no) throws Exception {
		return dao.selectAccessKey(key_no);
	}

	@Override
	public int insertMember(MemberDTO dto) throws Exception {
		return dao.insertMember(dto);
	}

	@Override
	public int insertMemberByNaver(SocialMemberDTO dto) throws Exception {
		return dao.insertMemberByNaver(dto);
	}

	@Override
	public int selectMemberCountById(String mem_id) throws Exception {
		return dao.selectMemberCountById(mem_id);
	}

	@Override
	public String selectPasswordById(String mem_id) throws Exception {
		return dao.selectPasswordById(mem_id);
	}

	@Override
	public int selectEmailCountByEmail(String mem_email) throws Exception {
		return dao.selectEmailCountByEmail(mem_email);
	}

	@Override
	public int insertMemberByGoogle(SocialMemberDTO dto) throws Exception {
		return dao.insertMemberByGoogle(dto);
	}

	@Override
	public int insertMemberByFacebook(SocialMemberDTO dto) throws Exception {
		return dao.insertMemberByFacebook(dto);
	}

}
