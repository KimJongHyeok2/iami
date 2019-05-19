package com.web.iami.controller;

import javax.inject.Inject;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.web.iami.domain.CommentDTO;
import com.web.iami.domain.PortfolioDTO;
import com.web.iami.domain.RestCommentDTO;
import com.web.iami.service.PortfolioService;
import com.web.iami.util.CommentValidator;
import com.web.iami.util.PortfolioValidator;

@RestController
@RequestMapping("/portfolio")
public class RestPortfolioController {

	@Inject
	private PortfolioService portfolioService;
	
	// 포트폴리오 업로드
	@PostMapping("/writeOk")
	public String writeOk(PortfolioDTO dto, BindingResult result) {
		
		PortfolioValidator validation = new PortfolioValidator();
		if(validation.supports(dto.getClass())) {
			
			validation.validate(dto, result);
			
			if(result.hasErrors()) {
				return "Fail";
			} else {
				try {
					int count = portfolioService.insertPortfolio(dto);
					
					if(count == 1) {
						return "Ok";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return "Fail";
	}
	
	// 포트폴리오 댓글 작성
	@PostMapping("/comment/write")
	public String commmentWrite(CommentDTO dto, BindingResult result) {
		
		CommentValidator validation = new CommentValidator();
		
		if(validation.supports(dto.getClass())) {
			
			validation.validate(dto, result);
			
			if(result.hasErrors()) {
				return "Fail";
			} else {
				try {
					if(dto.getCom_type() == 1) {
						int count = portfolioService.insertPortfolioComment(dto);
						if(count == 1) {
							return "Ok";
						}
					} else {
						
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return "Fail";
	}
	
	// 포트폴리오 댓글 불러오기
	@PostMapping("/comment/list")
	public RestCommentDTO commentList(@RequestParam(value = "pot_no", defaultValue = "0") int pot_no) {
		
		RestCommentDTO dto = new RestCommentDTO();
		
		if(pot_no == 0) {
			dto.setStatus("Fail");
			return dto;
		} else {
			try {
				dto.setList(portfolioService.selectPortfolioComments(pot_no));
				
				if(dto.getList() != null) {
					dto.setCount(dto.getList().size());
					dto.setStatus("Ok");
				} else {
					dto.setStatus("Fail");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return dto;
	}
}