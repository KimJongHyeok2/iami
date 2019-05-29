package com.web.iami.security;

import javax.inject.Inject;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

import com.web.iami.util.PasswordEncoding;

public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Inject
	private CustomUserDetailService service;
	
	@Override
	public Authentication authenticate(Authentication auth) throws AuthenticationException {

		String id = (String)auth.getPrincipal();
		String pw = (String)auth.getCredentials();

		CustomUserDetails user = null;
		
		user = (CustomUserDetails)service.loadUserByUsername(id);
		
		PasswordEncoding encode = new PasswordEncoding();
		
		if(user.getMem_type() == 1) { // IAMI 회원이라면
			if(!encode.matches(pw, user.getPassword())) {
				throw new BadCredentialsException(id);
			}	
		} else if(user.getMem_type() == 2) { // 네이버 로그인 회원이라면
			if(!pw.equals(user.getMem_pw())) {
				throw new BadCredentialsException(id);
			}
		}

		if(!user.isEnabled()) {
			throw new AuthenticationCredentialsNotFoundException(id);
		}
		
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(id, pw, user.getAuthorities());
		token.setDetails(user);
		
		return token;
	}

	@Override
	public boolean supports(Class<?> arg0) {
		return true;
	}

}
