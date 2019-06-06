package com.web.iami.service;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.web.iami.domain.EmailAccessDTO;
import com.web.iami.domain.MemberDTO;
import com.web.iami.persistent.MemberDAO;

@Transactional(isolation=Isolation.READ_COMMITTED)
@Service("MemberService")
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	
	@Override
	public MemberDTO selectMemberInfo(int mem_no) throws Exception {
		return dao.selectMemberInfo(mem_no);
	}

	@Override
	public int updateMemberProfile(Map<String, String> map) throws Exception {
		return dao.updateMemberProfile(map);
	}

	@Override
	public int updateMemberNickname(Map<String, String> map) throws Exception {
		return dao.updateMemberNickname(map);
	}

	@Override
	public int selectEmail(String mem_email) throws Exception {
		return dao.selectEmail(mem_email);
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
	public int updateMemberEmail(Map<String, String> map) throws Exception {
		return dao.updateMemberEmail(map);
	}

	@Override
	public String selectMemberPassword(int mem_no) throws Exception {
		return dao.selectMemberPassword(mem_no);
	}

	@Override
	public int updateMemberPassword(Map<String, String> map) throws Exception {
		return dao.updateMemberPassword(map);
	}

}