package com.web.iami.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.iami.domain.PortfolioDTO;
import com.web.iami.service.PortfolioService;

@Controller
public class MainController {

	@Inject
	private PortfolioService portfolioService;
	
	@RequestMapping("")
	public String main(@RequestParam(value="type", defaultValue = "new") String type,
			@RequestParam(value="page", defaultValue = "1") int page,
			@RequestParam(value="row", defaultValue = "12") int row,
			Model model) {
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		map.put("page", (page-1)*row+1);
		map.put("row", row);
		
		if(type.equals("new")) {
			try {
				List<PortfolioDTO> list = portfolioService.selectNewPortfolio(map);
				
				model.addAttribute("list", list);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		model.addAttribute("type", type);
		model.addAttribute("page", page);
		
		return "main";
	}
	
	// 권한 없는 페이지 접근 시
	@RequestMapping("/access-denied")
	public String access_denied() {
		return "error/access-denied";
	}

	// 중복 로그인 발생 시
	@RequestMapping("/expired-login")
	public String expired_login() {
		return "error/expired-login";
	}
	
}