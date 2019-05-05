package com.web.iami.aop;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;

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
		
		logger.info("----------------------------------------------------------------------------------------------");
	
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String signature = jp.getSignature().getName();
		logger.info("요청주소 : " + request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI());
		logger.info("메소드명 : " + signature);
		logger.info("파라미터 : " + Arrays.toString(jp.getArgs()));
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
			
			logger.info("접속유저 : " + ip);
			logger.info("실행시간 : " + (endTime - startTime) + "ms");
			logger.info("실행일시 : " + new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(currCal.getTime()));
			
			logger.info("----------------------------------------------------------------------------------------------");
		}

	}

}