package com.web.iami.persistent;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.iami.domain.PortfolioDTO;

@Repository("PortfolioDAO")
public class PortfolioDAOImpl implements PortfolioDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insertPortfolio(PortfolioDTO dto) throws Exception {
		return sqlSession.insert("portfolio.insertPortfolio", dto);
	}

}
