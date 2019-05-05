package com.web.iami.security;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

@Component
public class CustomUserDetailService implements UserDetailsService {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {

		CustomUserDAO dao = sqlSession.getMapper(CustomUserDAO.class);

		CustomUserDetails dto = dao.selectMemberById(id);
		
		if(dto == null) {
			throw new InternalAuthenticationServiceException(id);
		} else {
			List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
			roles.add(new SimpleGrantedAuthority(dto.getMem_auth()));
			return dto;
		}
	
	}

}
