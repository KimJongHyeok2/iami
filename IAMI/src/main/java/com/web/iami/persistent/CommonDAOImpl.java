package com.web.iami.persistent;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.iami.domain.NoticeDTO;
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

	@Override
	public List<NoticeDTO> selectMainNotice() throws Exception {
		return sqlSession.selectList("common.selectMainNotice");
	}

	@Override
	public int selectNoticeCount(Map<String, String> map) throws Exception {
		return sqlSession.selectOne("common.selectNoticeCount", map);
	}

	@Override
	public NoticeDTO selectViewNotice(int cnc_no) throws Exception {
		return sqlSession.selectOne("common.selectViewNotice", cnc_no);
	}

	@Override
	public int updateNoticeViewCount(int cnc_no) throws Exception {
		return sqlSession.update("common.updateNoticeViewCount", cnc_no);
	}

	@Override
	public List<NoticeDTO> selectNotice(Map<String, String> map) throws Exception {
		return sqlSession.selectList("common.selectNotice", map);
	}

}