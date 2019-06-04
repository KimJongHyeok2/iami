package com.web.iami.persistent;

import com.web.iami.domain.NoticeDTO;

public interface AdminDAO {
	public int insertNotice(NoticeDTO dto) throws Exception;
	public int updateNotice(NoticeDTO dto) throws Exception;
	public int deleteNotice(int cnc_no) throws Exception;
}