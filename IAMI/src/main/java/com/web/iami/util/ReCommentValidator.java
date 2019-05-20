package com.web.iami.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.iami.domain.CommentDTO;
import com.web.iami.domain.ReCommentDTO;

public class ReCommentValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return ReCommentDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ReCommentDTO dto = (ReCommentDTO)target;
		
		ValidationUtils.rejectIfEmpty(errors, "rcom_type", "emptyReCommentType");
		
		if(dto.getRcom_type() == 1) {
			ValidationUtils.rejectIfEmpty(errors, "pot_no", "emptyPortfolioNumber");
			ValidationUtils.rejectIfEmpty(errors, "com_no", "emptyParentCommentNumber");
			ValidationUtils.rejectIfEmpty(errors, "rcom_nickname", "emptyReCommentNickname");
			ValidationUtils.rejectIfEmpty(errors, "rcom_pw", "emptyReCommentPassword");
			ValidationUtils.rejectIfEmpty(errors, "rcom_content", "emptyReCommentContent");
		} else {
			ValidationUtils.rejectIfEmpty(errors, "mem_no", "emptyMemberNumber");
			ValidationUtils.rejectIfEmpty(errors, "pot_no", "emptyPortfolioNumber");
			ValidationUtils.rejectIfEmpty(errors, "com_no", "emptyParentCommentNumber");
			ValidationUtils.rejectIfEmpty(errors, "rcom_content", "emptyReCommentContent");			
		}
	
	}

}