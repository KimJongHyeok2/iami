package com.web.iami.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.iami.domain.MemberDTO;
import com.web.iami.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Inject
	private MemberService memberService;
	
	@GetMapping("/myinfo")
	public String myinfo(HttpServletRequest request, Model model) {
		
		if(request.getSession().getAttribute("mem_no") == null) {
			return "redirect:/";
		} else {
			int mem_no = (Integer)request.getSession().getAttribute("mem_no");
			
			try {
				MemberDTO dto = memberService.selectMemberInfo(mem_no);
				
				if(dto == null) {
					return "redirect:/";
				} else {
					model.addAttribute("member", dto);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		model.addAttribute("type", "myinfo");
		
		return "main";
	}
}
