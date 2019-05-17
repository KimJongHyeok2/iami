package com.web.iami.persistent;

import java.util.Map;

import com.web.iami.domain.EmailAccessDTO;
import com.web.iami.domain.MemberDTO;

public interface MemberDAO {
	public MemberDTO selectMemberInfo(int mem_no) throws Exception;
	public int updateMemberProfile(Map<String, String> map) throws Exception;
	public int updateMemberNickname(Map<String, String> map) throws Exception;
	public int selectEmail(String mem_email) throws Exception;
	public int insertAccessKey(EmailAccessDTO dto) throws Exception;
	public String selectAccessKey(int key_no) throws Exception;
	public int updateMemberEmail(Map<String, String> map) throws Exception;
	public String selectMemberPassword(int mem_no) throws Exception;
	public int updateMemberPassword(Map<String, String> map) throws Exception;
}