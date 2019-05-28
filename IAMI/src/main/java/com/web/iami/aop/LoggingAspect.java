package com.web.iami.aop;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;import java.util.Date;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
@Aspect
public class LoggingAspect {

	private static final Logger logger = LoggerFactory.getLogger(LoggingAspect.class);
	
	@Around("execution(* com.web.iami.controller.*.*(..))")
	public Object requestLogging(ProceedingJoinPoint jp) throws Throwable {
	
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String signature = jp.getSignature().getName();
		long startTime = System.currentTimeMillis();
		Calendar currCal = Calendar.getInstance();
		
		try {
			Object obj = jp.proceed();
			return obj;
		} finally {
			long endTime = System.currentTimeMillis();
		
	        String ip = request.getHeader("X-FORWARDED-FOR");
	        if (ip == null) {
	            ip = request.getRemoteAddr();
	        }
	        
	        TimeZone time = TimeZone.getTimeZone("Asia/Seoul");
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	        sdf.setTimeZone(time);
	        
	        logger.info("----------------------------------------------------------------------------------------------");
	        
			logger.info("Request : " + request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI());
			logger.info("Method : " + signature);
			logger.info("Parameter : " + Arrays.toString(jp.getArgs()));
			logger.info("MemberIP : " + ip);
			logger.info("Runtime : " + (endTime - startTime) + "ms");
			logger.info("RunDate : " + sdf.format(currCal.getTime()));
			
			logger.info("----------------------------------------------------------------------------------------------");
		}

	}

}