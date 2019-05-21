package com.web.iami.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.web.iami.domain.VisitDTO;
import com.web.iami.persistent.CommonDAO;

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

}