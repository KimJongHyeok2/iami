package com.web.iami.persistent;

import com.web.iami.domain.EmailAccessDTO;

public interface RegisterDAO {
	public int insertAccessKey(EmailAccessDTO dto) throws Exception;
	public String selectAccessKey(int key_no) throws Exception;
}
