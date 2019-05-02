package com.web.iami.service;

import com.web.iami.domain.EmailAccessDTO;

public interface RegisterService {
	public int insertAccessKey(EmailAccessDTO dto) throws Exception;
	public String selectAccessKey(int key_no) throws Exception;
}