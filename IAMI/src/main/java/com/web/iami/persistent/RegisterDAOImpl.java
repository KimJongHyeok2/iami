package com.web.iami.persistent;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.iami.domain.EmailAccessDTO;

@Repository("RegisterDAO")
public class RegisterDAOImpl implements RegisterDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insertAccessKey(EmailAccessDTO dto) throws Exception {
		return sqlSession.insert("register.insertAccessKey", dto);
	}

	@Override
	public String selectAccessKey(int key_no) throws Exception {
		return sqlSession.selectOne("register.selectAccessKey", key_no);
	}

}