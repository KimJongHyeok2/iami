package com.web.iami.persistent;

import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.iami.domain.EmailAccessDTO;
import com.web.iami.domain.MemberDTO;

@Repository("MemberDAO")
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public MemberDTO selectMemberInfo(int mem_no) throws Exception {
		return sqlSession.selectOne("member.selectMemberInfo", mem_no);
	}

	@Override
	public int updateMemberProfile(Map<String, String> map) throws Exception {
		return sqlSession.update("member.updateMemberProfile", map);
	}

	@Override
	public int updateMemberNickname(Map<String, String> map) throws Exception {
		return sqlSession.update("member.updateMemberNickname", map);
	}

	@Override
	public int selectEmail(String mem_email) throws Exception {
		return sqlSession.selectOne("member.selectEmail", mem_email);
	}

	@Override
	public int insertAccessKey(EmailAccessDTO dto) throws Exception {
		return sqlSession.insert("member.insertAccessKey", dto);
	}

	@Override
	public String selectAccessKey(int key_no) throws Exception {
		return sqlSession.selectOne("member.selectAccessKey", key_no);
	}

	@Override
	public int updateMemberEmail(Map<String, String> map) throws Exception {
		return sqlSession.update("member.updateMemberEmail", map);
	}

	@Override
	public String selectMemberPassword(int mem_no) throws Exception {
		return sqlSession.selectOne("member.selectMemberPassword", mem_no);
	}

	@Override
	public int updateMemberPassword(Map<String, String> map) throws Exception {
		return sqlSession.update("member.updateMemberPassword", map);
	}

}
