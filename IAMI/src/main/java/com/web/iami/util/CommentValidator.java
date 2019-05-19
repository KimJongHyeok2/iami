package com.web.iami.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.iami.domain.CommentDTO;

public class CommentValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return CommentDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		CommentDTO dto = (CommentDTO)target;
		
		ValidationUtils.rejectIfEmpty(errors, "com_type", "emptyCommentType");
		
		if(dto.getCom_type() == 1) {
			ValidationUtils.rejectIfEmpty(errors, "pot_no", "emptyPortfolioNumber");
			ValidationUtils.rejectIfEmpty(errors, "com_nickname", "emptyCommentNickname");
			ValidationUtils.rejectIfEmpty(errors, "com_pw", "emptyCommentPassword");
			ValidationUtils.rejectIfEmpty(errors, "com_content", "emptyCommentContent");
		} else {
			ValidationUtils.rejectIfEmpty(errors, "mem_no", "emptyMemberNumber");
			ValidationUtils.rejectIfEmpty(errors, "pot_no", "emptyPortfolioNumber");
			ValidationUtils.rejectIfEmpty(errors, "com_content", "emptyCommentContent");			
		}
	
	}

}