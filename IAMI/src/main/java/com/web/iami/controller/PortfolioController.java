package com.web.iami.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/portfolio")
public class PortfolioController {

	// 포트폴리오 업로드 페이지 이동
	@GetMapping("/write")
	public String write() {
		return "portfolio/write";
	}
	
}