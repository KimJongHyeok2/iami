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
		
		if(user.getMem_type() == 1) {
			if(!encode.matches(pw, user.getPassword())) {
				throw new BadCredentialsException(id);
			}	
		} else if(user.getMem_type() == 2) {
			if(!pw.equals(user.getMem_pw())) {
				throw new BadCredentialsException(id);
			}
		}

		if(!user.isEnabled()) {
			throw new AuthenticationCredentialsNotFoundException(id);
		}

/*		try {
			user = (CustomUserDetails)service.loadUserByUsername(id);
			
			PasswordEncoding encode = new PasswordEncoding();
			
			if(!encode.matches(pw, user.getPassword())) {
				throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
			}
			
			if(!user.isEnabled()) {
				throw new LockedException("블락된 계정입니다.");
			}
		} catch (InternalAuthenticationServiceException e) {
			throw new InternalAuthenticationServiceException(e.getMessage());
		} catch (BadCredentialsException e) {
			throw new BadCredentialsException(e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
*/
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(id, pw, user.getAuthorities());
		token.setDetails(user);
		
		return token;
	}

	@Override
	public boolean supports(Class<?> arg0) {
		return true;
	}

}
