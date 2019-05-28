package com.web.iami.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.iami.domain.RestVisitDTO;
import com.web.iami.service.CommonService;

@RestController
@RequestMapping("/common")
public class RestCommonController {
	
	@Inject
	private CommonService commonService;
	
	@GetMapping("/visitor")
	public RestVisitDTO visitor() {
		TimeZone time = TimeZone.getTimeZone("Asia/Seoul");
		
		Calendar startDay = Calendar.getInstance();
		startDay.setTimeZone(time);
		startDay.add(Calendar.DATE, -startDay.get(Calendar.DAY_OF_WEEK)+1);
		
		Calendar endDay = Calendar.getInstance();
		endDay.setTimeZone(time);
		endDay.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		endDay.add(Calendar.DATE, 7);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDay", new SimpleDateFormat("yyyy-MM-dd").format(startDay.getTime()));
		map.put("endDay", new SimpleDateFormat("yyyy-MM-dd").format(endDay.getTime()));
		
		RestVisitDTO dto = new RestVisitDTO();
		
		try {
			dto.setList(commonService.selectWeekVisitCount(map));
			
			if(dto != null && dto.getList().size() != 0) {
				dto.setCount(dto.getList().size());
				dto.setStatus("Ok");
			} else {
				dto.setStatus("Fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return dto;
	}
}