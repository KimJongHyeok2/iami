package com.web.iami.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.web.iami.domain.CommentDTO;
import com.web.iami.domain.PortfolioDTO;
import com.web.iami.domain.ReCommentDTO;
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

	@Override
	public PortfolioDTO selectViewPortfolio(int no) throws Exception {
		return dao.selectViewPortfolio(no);
	}

	@Override
	public int insertPortfolioComment(CommentDTO dto) throws Exception {
		return dao.insertPortfolioComment(dto);
	}

	@Override
	public List<CommentDTO> selectPortfolioComments(Map<String, Integer> map) throws Exception {
		return dao.selectPortfolioComments(map);
	}

	@Override
	public String selectCommentPassword(int com_no) throws Exception {
		return dao.selectCommentPassword(com_no);
	}

	@Override
	public int updatePortfolioComment(Map<String, String> map) throws Exception {
		return dao.updatePortfolioComment(map);
	}

	@Override
	public int deletePortfolioComment(int com_no) throws Exception {
		return dao.deletePortfolioComment(com_no);
	}

	@Override
	public int insertPortfolioReComment(ReCommentDTO dto) throws Exception {
		return dao.insertPortfolioReComment(dto);
	}

	@Override
	public List<ReCommentDTO> selectPortfolioReComments(int pot_no) throws Exception {
		return dao.selectPortfolioReComments(pot_no);
	}

	@Override
	public String selectReCommentPassword(int rcom_no) throws Exception {
		return dao.selectReCommentPassword(rcom_no);
	}
	
	@Override
	public int deletePortfolioReComment(int rcom_no) throws Exception {
		return dao.deletePortfolioReComment(rcom_no);
	}

	@Override
	public int selectCommentCount(int pot_no) throws Exception {
		return dao.selectCommentCount(pot_no);
	}

	@Override
	public int isAlreadyRecommend(Map<String, String> map) throws Exception {
		return dao.isAlreadyRecommend(map);
	}

	@Override
	public int updatePortfolioRecommend(int pot_no) throws Exception {
		return dao.updatePortfolioRecommend(pot_no);
	}

	@Override
	public int insertRecommendHistory(Map<String, String> map) throws Exception {
		return dao.insertRecommendHistory(map);
	}

	@Override
	public List<PortfolioDTO> selectPopularPortfolio(Map<String, Integer> map) throws Exception {
		return dao.selectPopularPortfolio(map);
	}

	@Override
	public List<PortfolioDTO> selectMemberPortfolio(int mem_no) throws Exception {
		return dao.selectMemberPortfolio(mem_no);
	}

	@Override
	public int updatePortfolio(PortfolioDTO dto) throws Exception {
		return dao.updatePortfolio(dto);
	}

	@Override
	public int deletePortfolio(int pot_no) throws Exception {
		return dao.deletePortfolio(pot_no);
	}

}