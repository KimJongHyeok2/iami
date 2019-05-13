package com.web.iami.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.iami.domain.PortfolioDTO;
import com.web.iami.service.PortfolioService;
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
				showErrors(result);
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
	
	void showErrors(Errors result) { 
		if(result.hasErrors()) {
			List<FieldError> error = result.getFieldErrors();
			for(FieldError list : error) {
				System.out.println(list.getField() + " : " + list.getCode());
			}
		}
		
	}
	
}