package com.web.iami.controller;

import java.io.File;
import java.net.URLEncoder;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.util.FileUtil;
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
		
			if(dto == null) {
				model.addAttribute("type", "alreadyDelete");
				return "confirm/fail";
			} else {
				dto.setFilesDTO(portfolioService.selectPortfolioFiles(no));
				model.addAttribute("portfolio", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
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
	
	// 포트폴리오 비회원 댓글/답글 삭제 popup 
	@GetMapping("/comment/delete-popup")
	public String delete(@RequestParam(value = "no", defaultValue = "0") int no, Model model) {
		if(no == 0) {
			return "main";
		}
		model.addAttribute("no", no);
		return "portfolio/delete";
	}
	
	@GetMapping("/download")
	public void download(String fileName, HttpServletRequest request, HttpServletResponse response) {
		try {
			if(fileName == null || fileName.length() == 0) {
				response.sendRedirect(request.getContextPath());
				return;
			}
			byte[] fileByte = FileUtil.readAsByteArray(new File(request.getSession().getServletContext().getRealPath("/resources/file/" + fileName)));
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte);
			
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}