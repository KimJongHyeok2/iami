package com.web.iami.persistent;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.iami.domain.CommentDTO;
import com.web.iami.domain.PortfolioDTO;

@Repository("PortfolioDAO")
public class PortfolioDAOImpl implements PortfolioDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insertPortfolio(PortfolioDTO dto) throws Exception {
		return sqlSession.insert("portfolio.insertPortfolio", dto);
	}

	@Override
	public List<PortfolioDTO> selectNewPortfolio(Map<String, Integer> map) throws Exception {
		return sqlSession.selectList("portfolio.selectNewPortfolio", map);
	}

	@Override
	public PortfolioDTO selectViewPortfolio(int no) throws Exception {
		return sqlSession.selectOne("portfolio.selectViewPortfolio", no);
	}

	@Override
	public int insertPortfolioComment(CommentDTO dto) throws Exception {
		return sqlSession.insert("portfolio.insertPortfolioComment", dto);
	}

	@Override
	public List<CommentDTO> selectPortfolioComments(int pot_no) throws Exception {
		return sqlSession.selectList("portfolio.selectPortfolioComments", pot_no);
	}
	
}
