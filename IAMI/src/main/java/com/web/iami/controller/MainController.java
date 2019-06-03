package com.web.iami.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.iami.domain.NoticeDTO;
import com.web.iami.domain.PortfolioDTO;
import com.web.iami.service.AdminService;
import com.web.iami.service.CommonService;
import com.web.iami.service.PortfolioService;
import com.web.iami.util.NoticeValidator;

@Controller
public class MainController {

	@Inject
	private PortfolioService portfolioService;
	@Inject
	private CommonService commonService;
	@Inject
	private AdminService adminService;
	
	@RequestMapping("")
	public String main(@RequestParam(value="type", defaultValue = "new") String type,
			@RequestParam(value="page", defaultValue = "1") int page,
			@RequestParam(value="row", defaultValue = "12") int row,
			Model model) {
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		map.put("page", (page-1)*row+1);
		map.put("row", row);

		try {
			List<PortfolioDTO> list = null;
			
			if(type.equals("new")) {
				list = portfolioService.selectNewPortfolio(map);					
			} else if(type.equals("popular")) {
				list = portfolioService.selectPopularPortfolio(map);
			}
			
			List<NoticeDTO> noticeList = commonService.selectMainNotice();
			
			model.addAttribute("list", list);
			model.addAttribute("noticeList", noticeList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("type", type);
		model.addAttribute("page", page);
		
		return "main";
	}
	
	@GetMapping("/notice")
	public String notice(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		int noticeCount = 0;
		int row = 10;
		int pageBlock = 5;
		int pageCount = 0;
		int startPage = 0;
		int endPage = 0;
		
		try {
			noticeCount = commonService.selectNoticeCount();
			
			pageCount = noticeCount / row + (noticeCount%row==0? 0:1);
			startPage = ((page-1) / pageBlock) * pageBlock + 1;
			endPage = startPage + pageBlock - 1;
			
			if(endPage > pageCount) {
				endPage = pageCount;
			}
			
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("page", (page-1)*row+1);
			map.put("row", row);
			List<NoticeDTO> list = commonService.selectNotice(map);
			
			model.addAttribute("pageBlock", pageBlock);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("page", page);
			model.addAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("type", "noticeList");
		return "main";
	}
	
	// 공지사항 작성 페이지 이동(ACCESS : ROLE_ADMIN)
	@GetMapping("/notice/write")
	public String noticeWrite(Model model) {
		model.addAttribute("type", "noticeWrite");
		return "main";
	}
	
	// 공지사항 작성(ACCESS : ROLE_ADMIN)
	@PostMapping("/notice/writeOk")
	public String noticeWriteOk(NoticeDTO dto, BindingResult result, Model model) {
		
		NoticeValidator validation = new NoticeValidator();
		
		if(validation.supports(dto.getClass())) {
			validation.validate(dto, result);
			
			if(!result.hasErrors()) {
				try {
					int count = adminService.insertNotice(dto);
					
					if(count == 1) {
						return "confirm/success";
					} else {
						return "confirm/fail";
					}
				} catch (Exception e) {
					e.printStackTrace();
					return "confirm/fail";
				}
			}
		}
		
		return "main";
	}
	
	// 공지사항 상세보기
	@GetMapping("/notice/view/{no}")
	public String noticeView(@PathVariable int no, HttpServletRequest request, Model model) {
		
		try {
			if(request.getSession().getAttribute("notice-view-" + no) == null) {
				commonService.updateNoticeViewCount(no);
				request.getSession().setAttribute("notice-view-" + no, no);
				request.getSession().setMaxInactiveInterval(60*60*6);
			}
			
			NoticeDTO dto = commonService.selectViewNotice(no);
			
			if(dto == null) {
				model.addAttribute("type", "alreadyDelete");
				return "confirm/fail";
			} else {
				model.addAttribute("dto", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("type", "noticeView");
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