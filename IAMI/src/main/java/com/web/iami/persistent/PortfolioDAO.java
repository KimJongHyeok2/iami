package com.web.iami.persistent;

import java.util.List;
import java.util.Map;

import com.web.iami.domain.CommentDTO;
import com.web.iami.domain.PortfolioDTO;

public interface PortfolioDAO {
	public int insertPortfolio(PortfolioDTO dto) throws Exception;
	public List<PortfolioDTO> selectNewPortfolio(Map<String, Integer> map) throws Exception;
	public PortfolioDTO selectViewPortfolio(int no) throws Exception;
	public int insertPortfolioComment(CommentDTO dto) throws Exception;
	public List<CommentDTO> selectPortfolioComments(int pot_no) throws Exception;
}