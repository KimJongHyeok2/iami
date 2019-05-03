package com.web.iami.persistent;

import com.web.iami.domain.EmailAccessDTO;
import com.web.iami.domain.MemberDTO;

public interface RegisterDAO {
	public int selectID(String id) throws Exception;
	public int selectEmail(String email) throws Exception;
	public int insertAccessKey(EmailAccessDTO dto) throws Exception;
	public String selectAccessKey(int key_no) throws Exception;
	public int insertMember(MemberDTO dto) throws Exception;
}