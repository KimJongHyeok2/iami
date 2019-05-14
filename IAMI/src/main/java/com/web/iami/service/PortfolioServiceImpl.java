package com.web.iami.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.web.iami.domain.PortfolioDTO;
import com.web.iami.persistent.PortfolioDAO;

@Service("PortfolioService")
public class PortfolioServiceImpl implements PortfolioService {

	@Inject
	private PortfolioDAO dao;
	
	@Override
	public int insertPortfolio(PortfolioDTO dto) throws Exception {
		return dao.insertPortfolio(dto);
	}

	@Override
	public List<PortfolioDTO> selectNewPortfolio(Map<String, Integer> map) throws Exception {
		return dao.selectNewPortfolio(map);
	}

}