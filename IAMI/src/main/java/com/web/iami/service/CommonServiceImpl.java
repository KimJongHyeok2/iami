package com.web.iami.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.web.iami.domain.NoticeDTO;
import com.web.iami.domain.VisitDTO;
import com.web.iami.persistent.CommonDAO;

@Transactional(isolation=Isolation.READ_COMMITTED)
@Service("CommonService")
public class CommonServiceImpl implements CommonService {

	@Inject
	private CommonDAO dao;
	
	@Override
	public int insertVisitDate() throws Exception {
		return dao.insertVisitDate();
	}

	@Override
	public int checkAlreadyVisitDate(String date) throws Exception {
		return dao.checkAlreadyVisitDate(date);
	}

	@Override
	public int updateVisitCount(String date) throws Exception {
		return dao.updateVisitCount(date);
	}

	@Override
	public List<VisitDTO> selectWeekVisitCount(Map<String, String> map) throws Exception {
		return dao.selectWeekVisitCount(map);
	}

	@Override
	public List<NoticeDTO> selectMainNotice() throws Exception {
		return dao.selectMainNotice();
	}
	@Override
	public int selectNoticeCount(Map<String, String> map) throws Exception {
		return dao.selectNoticeCount(map);
	}

	@Override
	public NoticeDTO selectViewNotice(int cnc_no) throws Exception {
		return dao.selectViewNotice(cnc_no);
	}

	@Override
	public int updateNoticeViewCount(int cnc_no) throws Exception {
		return dao.updateNoticeViewCount(cnc_no);
	}

	@Override
	public List<NoticeDTO> selectNotice(Map<String, String> map) throws Exception {
		return dao.selectNotice(map);
	}
	
}