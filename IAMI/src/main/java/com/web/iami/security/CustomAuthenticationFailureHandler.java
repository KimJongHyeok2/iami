package com.web.iami.security;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
	
	@Inject
	private SqlSession sqlSession;

	private String mem_id;
	private String mem_pw;
	private String errormsgname;
	private String defaultFailUrl;

	public String getMem_id() {
		return mem_id;
	}
	
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}

	public String getErrormsgname() {
		return errormsgname;
	}

	public void setErrormsgname(String errormsgname) {
		this.errormsgname = errormsgname;
	}

	public String getDefaultFailUrl() {
		return defaultFailUrl;
	}

	public void setDefaultFailUrl(String defaultFailUrl) {
		this.defaultFailUrl = defaultFailUrl;
	}

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception)
			throws IOException, ServletException {

		String id = request.getParameter(this.mem_id);
		String pw = request.getParameter(this.mem_pw);
		String errormsg = null;
		
		request.setAttribute(this.mem_id, id);
		request.setAttribute(this.mem_pw, pw);
		
		if(exception instanceof InternalAuthenticationServiceException) {
			errormsg = "아이디 또는 비밀번호를 다시 한번 확인해주세요.";
		} else if(exception instanceof BadCredentialsException) {
			CustomUserDAO dao = sqlSession.getMapper(CustomUserDAO.class);
			dao.updateMemberFailureCount(id);
			int count = dao.selectMemberFailureCount(id);
			if(count == 5) {
				dao.updateMemberEnabled(id);
				errormsg = "계정이 비활성화 처리되었습니다.";
			} else {
				errormsg = "아이디 또는 비밀번호를 다시 한번 확인해주세요.<br>5회 잘못 입력 시 계정이 비활성화됩니다.(" + count + "/5)";				
			}
		} else if(exception instanceof DisabledException) {
			errormsg = "비활성화되어 있는 계정입니다.";
		}
		
		request.setAttribute(errormsgname, errormsg);
		
		request.getRequestDispatcher(defaultFailUrl).forward(request, response);
	}

}
