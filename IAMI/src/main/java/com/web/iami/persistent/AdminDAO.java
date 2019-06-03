package com.web.iami.persistent;

import com.web.iami.domain.NoticeDTO;

public interface AdminDAO {
	public int insertNotice(NoticeDTO dto) throws Exception;
}