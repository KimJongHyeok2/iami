package com.web.iami.persistent;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.iami.domain.CommentDTO;
import com.web.iami.domain.PortfolioDTO;
import com.web.iami.domain.ReCommentDTO;

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
	public List<CommentDTO> selectPortfolioComments(Map<String, Integer> map) throws Exception {
		return sqlSession.selectList("portfolio.selectPortfolioComments", map);
	}

	@Override
	public String selectCommentPassword(int com_no) throws Exception {
		return sqlSession.selectOne("portfolio.selectCommentPassword", com_no);
	}

	@Override
	public int updatePortfolioComment(Map<String, String> map) throws Exception {
		return sqlSession.update("portfolio.updatePortfolioComment", map);
	}

	@Override
	public int deletePortfolioComment(int com_no) throws Exception {
		return sqlSession.update("portfolio.deletePortfolioComment", com_no);
	}

	@Override
	public int insertPortfolioReComment(ReCommentDTO dto) throws Exception {
		return sqlSession.insert("portfolio.insertPortfolioReComment", dto);
	}

	@Override
	public List<ReCommentDTO> selectPortfolioReComments(int pot_no) throws Exception {
		return sqlSession.selectList("portfolio.selectPortfolioReComments", pot_no);
	}

	@Override
	public String selectReCommentPassword(int rcom_no) throws Exception {
		return sqlSession.selectOne("portfolio.selectReCommentPassword", rcom_no);
	}
	
	@Override
	public int deletePortfolioReComment(int rcom_no) throws Exception {
		return sqlSession.update("portfolio.deletePortfolioReComment", rcom_no);
	}

	@Override
	public int selectCommentCount(int pot_no) throws Exception {
		return sqlSession.selectOne("portfolio.selectCommentCount", pot_no);
	}
	
}
