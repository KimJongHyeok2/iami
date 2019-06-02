package com.web.iami.service;

import java.util.List;
import java.util.Map;

import com.web.iami.domain.VisitDTO;

public interface CommonService {
	public int insertVisitDate() throws Exception;
	public int checkAlreadyVisitDate(String date) throws Exception;
	public int updateVisitCount(String date) throws Exception;
	public List<VisitDTO> selectWeekVisitCount(Map<String, String> map) throws Exception;
}