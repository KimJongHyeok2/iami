package com.web.iami.service;

import com.web.iami.domain.NoticeDTO;

public interface AdminService {
	public int insertNotice(NoticeDTO dto) throws Exception;
}