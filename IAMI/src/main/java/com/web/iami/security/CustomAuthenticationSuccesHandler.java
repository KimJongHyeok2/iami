package com.web.iami.security;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

public class CustomAuthenticationSuccesHandler implements AuthenticationSuccessHandler {

	@Inject
	private SqlSession sqlSession;
	
	private String mem_id;
	private String defaultUrl;
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();
	
	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getDefaultUrl() {
		return defaultUrl;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {

		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		CustomUserDAO dao = sqlSession.getMapper(CustomUserDAO.class);
		
		String mem_id = request.getParameter(this.mem_id);
		dao.updateMemberFailureCount_Init(mem_id);
		
		if(savedRequest != null) {
			String tempUrl = savedRequest.getRedirectUrl();
			redirectStratgy.sendRedirect(request, response, tempUrl);
		} else {
			redirectStratgy.sendRedirect(request, response, defaultUrl);
		}

	}

}
