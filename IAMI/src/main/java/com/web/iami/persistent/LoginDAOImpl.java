package com.web.iami.persistent;

import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository("LoginDAO")
public class LoginDAOImpl implements LoginDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public String selectFindID(Map<String, String> map) throws Exception {
		return sqlSession.selectOne("login.selectFindID", map);
	}

	@Override
	public Integer selectFindPW(Map<String, String> map) throws Exception {
		return sqlSession.selectOne("login.selectFindPW", map);
	}

	@Override
	public int updateMemberPW(Map<String, String> map) throws Exception {
		return sqlSession.update("login.updateMemberPW", map);
	}

}