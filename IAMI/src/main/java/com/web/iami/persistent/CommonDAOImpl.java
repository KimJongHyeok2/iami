package com.web.iami.persistent;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.iami.domain.VisitDTO;

@Repository("CommonDAO")
public class CommonDAOImpl implements CommonDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insertVisitDate() throws Exception {
		return sqlSession.insert("common.insertVisitDate");
	}

	@Override
	public int checkAlreadyVisitDate(String date) throws Exception {
		return sqlSession.selectOne("common.checkAlreadyVisitDate", date);
	}

	@Override
	public int updateVisitCount(String date) throws Exception {
		return sqlSession.update("common.updateVisitCount", date);
	}

	@Override
	public List<VisitDTO> selectWeekVisitCount(Map<String, String> map) throws Exception {
		return sqlSession.selectList("common.selectWeekVisitCount", map);
	}

}