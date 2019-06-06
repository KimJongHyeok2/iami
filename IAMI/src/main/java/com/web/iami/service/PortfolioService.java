package com.web.iami.service;

import java.util.List;
import java.util.Map;

import com.web.iami.domain.CommentDTO;
import com.web.iami.domain.FileDTO;
import com.web.iami.domain.PortfolioDTO;
import com.web.iami.domain.ReCommentDTO;

public interface PortfolioService {
	public int insertPortfolio(PortfolioDTO dto) throws Exception;
	public List<PortfolioDTO> selectNewPortfolio(Map<String, Integer> map) throws Exception;
	public PortfolioDTO selectViewPortfolio(int no) throws Exception;
	public int insertPortfolioComment(CommentDTO dto) throws Exception;
	public List<CommentDTO> selectPortfolioComments(Map<String, Integer> map) throws Exception;
	public String selectCommentPassword(int com_no) throws Exception;
	public int updatePortfolioComment(Map<String, String> map) throws Exception;
	public int deletePortfolioComment(int com_no) throws Exception;
	public int insertPortfolioReComment(ReCommentDTO dto) throws Exception;
	public List<ReCommentDTO> selectPortfolioReComments(int pot_no) throws Exception;
	public String selectReCommentPassword(int rcom_no) throws Exception;
	public int deletePortfolioReComment(int rcom_no) throws Exception;
	public int selectCommentCount(int pot_no) throws Exception;
	public int isAlreadyRecommend(Map<String, String> map) throws Exception;
	public int updatePortfolioRecommend(int pot_no) throws Exception;
	public int insertRecommendHistory(Map<String, String> map) throws Exception;
	public List<PortfolioDTO> selectPopularPortfolio(Map<String, Integer> map) throws Exception;
	public List<PortfolioDTO> selectMemberPortfolio(int mem_no) throws Exception;
	public int updatePortfolio(PortfolioDTO dto) throws Exception;
	public int deletePortfolio(int pot_no) throws Exception;
	public int insertPortfolioFiles(FileDTO dto) throws Exception;
	public List<FileDTO> selectPortfolioFiles(int pot_no) throws Exception;
	public int deletePortfolioFiles(int pot_no) throws Exception;
}