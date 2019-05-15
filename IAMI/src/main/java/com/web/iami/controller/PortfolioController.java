package com.web.iami.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/portfolio")
public class PortfolioController {

	// 포트폴리오 업로드 페이지 이동
	@GetMapping("/write")
	public String write() {
		return "portfolio/write";
	}
	
	@GetMapping("/view/{no}")
	public String view(@PathVariable int no, Model model) {
		
		model.addAttribute("type", "view");
		
		return "main";
	}
	
}