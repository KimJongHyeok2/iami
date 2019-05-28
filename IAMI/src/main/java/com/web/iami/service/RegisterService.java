package com.web.iami.service;

import com.web.iami.domain.EmailAccessDTO;
import com.web.iami.domain.MemberDTO;
import com.web.iami.domain.SocialMemberDTO;

public interface RegisterService {
	public int selectID(String id) throws Exception;
	public int selectEmail(String email) throws Exception;
	public int insertAccessKey(EmailAccessDTO dto) throws Exception;
	public String selectAccessKey(int key_no) throws Exception;
	public int insertMember(MemberDTO dto) throws Exception;
	public int insertMemberByNaver(SocialMemberDTO dto) throws Exception;
	public int selectMemberCountById(String mem_id) throws Exception;
	public String selectPasswordById(String mem_id) throws Exception;
	public int selectEmailCountByEmail(String mem_email) throws Exception;
}