package com.web.iami.persistent;

import com.web.iami.domain.PortfolioDTO;

public interface PortfolioDAO {
	public int insertPortfolio(PortfolioDTO dto) throws Exception;
}