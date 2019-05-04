package com.web.iami.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.iami.security.CustomUserDetails;

@Controller
@RequestMapping("/login")
public class LoginController {

	@GetMapping("")
	public String login() {
		return "login/login";
	}
	
	@PostMapping("/success")
	public String success(HttpServletRequest request) {
		
		CustomUserDetails userDetails = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getDetails();

		request.getSession().setAttribute("mem_id", userDetails.getMem_id());
		request.getSession().setAttribute("nickname", userDetails.getMem_nickname());
		
		return "redirect:/";
	}
	
}