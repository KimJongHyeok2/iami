package com.web.iami.persistent;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.iami.domain.EmailAccessDTO;
import com.web.iami.domain.MemberDTO;
import com.web.iami.domain.SocialMemberDTO;

@Repository("RegisterDAO")
public class RegisterDAOImpl implements RegisterDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int selectID(String id) throws Exception {
		return sqlSession.selectOne("register.selectID", id);
	}
	
	@Override
	public int selectEmail(String email) throws Exception {
		return sqlSession.selectOne("register.selectEmail", email);
	}
	
	@Override
	public int insertAccessKey(EmailAccessDTO dto) throws Exception {
		return sqlSession.insert("register.insertAccessKey", dto);
	}

	@Override
	public String selectAccessKey(int key_no) throws Exception {
		return sqlSession.selectOne("register.selectAccessKey", key_no);
	}

	@Override
	public int insertMember(MemberDTO dto) throws Exception {
		return sqlSession.insert("register.insertMember", dto);
	}

	@Override
	public int insertMemberByNaver(SocialMemberDTO dto) throws Exception {
		return sqlSession.insert("register.insertMemberByNaver", dto);
	}

	@Override
	public int selectMemberCountById(String mem_id) throws Exception {
		return sqlSession.selectOne("register.selectMemberCountById", mem_id);
	}

	@Override
	public String selectPasswordById(String mem_id) throws Exception {
		return sqlSession.selectOne("register.selectPasswordById", mem_id);
	}

	@Override
	public int selectEmailCountByEmail(String mem_email) throws Exception {
		return sqlSession.selectOne("register.selectEmailCountByEmail", mem_email);
	}

	@Override
	public int insertMemberByGoogle(SocialMemberDTO dto) throws Exception {
		return sqlSession.insert("register.insertMemberByGoogle", dto);
	}

}