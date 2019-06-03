package com.web.iami.persistent;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.iami.domain.NoticeDTO;

@Repository("AdminDAO")
public class AdminDAOImpl implements AdminDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insertNotice(NoticeDTO dto) throws Exception {
		return sqlSession.insert("admin.insertNotice", dto);
	}

}