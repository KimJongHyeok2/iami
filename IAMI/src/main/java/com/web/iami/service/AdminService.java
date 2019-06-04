package com.web.iami.service;

import com.web.iami.domain.NoticeDTO;

public interface AdminService {
	public int insertNotice(NoticeDTO dto) throws Exception;
	public int updateNotice(NoticeDTO dto) throws Exception;
	public int deleteNotice(int cnc_no) throws Exception;
}