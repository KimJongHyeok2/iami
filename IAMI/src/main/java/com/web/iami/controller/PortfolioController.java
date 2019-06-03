package com.web.iami.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.iami.domain.PortfolioDTO;
import com.web.iami.service.PortfolioService;

@Controller
@RequestMapping("/portfolio")
public class PortfolioController {

	@Inject
	private PortfolioService portfolioService;
	
	// 포트폴리오 업로드 페이지 이동
	@GetMapping("/write")
	public String write() {
		return "portfolio/write";
	}
	
	// 포트폴리오 상세보기
	@GetMapping("/view/{no}")
	public String view(@PathVariable int no, Model model) {
		
		PortfolioDTO dto = null;
		
		try {
			dto = portfolioService.selectViewPortfolio(no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(dto == null) {
			model.addAttribute("type", "alreadyDelete");
			return "confirm/fail";
		} else {
			model.addAttribute("portfolio", dto);
		}
		
		model.addAttribute("type", "view");
		
		return "main";
	}
	
	// 포트폴리오 수정 페이지 이동
	@PostMapping("/update")
	public String update(@RequestParam(value = "no", defaultValue = "0") int no,
			HttpServletRequest request, Model model) {

		try {
			PortfolioDTO dto = portfolioService.selectViewPortfolio(no);
			
			if(dto == null) {
				return "redirect:/";
			} else {
				int mem_no = (Integer)(request.getSession().getAttribute("mem_no")==null? 0:request.getSession().getAttribute("mem_no"));
				
				if(mem_no == 0) {
					return "redirect:/";
				} else {
					model.addAttribute("portfolio", dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "portfolio/update";
	}
	
	@GetMapping("/comment/delete-popup")
	public String delete(@RequestParam(value = "no", defaultValue = "0") int no, Model model) {
		if(no == 0) {
			return "main";
		}
		model.addAttribute("no", no);
		return "portfolio/delete";
	}
	
}