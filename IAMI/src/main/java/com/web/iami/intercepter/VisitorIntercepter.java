package com.web.iami.intercepter;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.web.iami.domain.VisitDTO;
import com.web.iami.service.CommonService;

public class VisitorIntercepter extends HandlerInterceptorAdapter {

	@Inject
	private CommonService commonService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String date;
		Date nowDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		TimeZone time = TimeZone.getTimeZone("Asia/Seoul");
		sdf.setTimeZone(time);
		date = sdf.format(nowDate);
		
		int dateCount = commonService.checkAlreadyVisitDate(date);
		
		if(dateCount == 0) {
			commonService.insertVisitDate();
		}
		
		String requestAddr = request.getRemoteAddr();
		
		if(request.getSession().getAttribute(requestAddr) == null) {
			request.getSession().setAttribute(requestAddr, "visit");
			request.getSession().setMaxInactiveInterval(60*60*6);
			
			commonService.updateVisitCount(date);
		}
		
		return super.preHandle(request, response, handler);
	}
	
}