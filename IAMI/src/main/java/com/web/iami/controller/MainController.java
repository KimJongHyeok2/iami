package com.web.iami.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@GetMapping("/")
	public String main() {
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