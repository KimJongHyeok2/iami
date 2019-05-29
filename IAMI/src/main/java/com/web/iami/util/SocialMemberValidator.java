package com.web.iami.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.iami.domain.SocialMemberDTO;

public class SocialMemberValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return SocialMemberDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		SocialMemberDTO dto = (SocialMemberDTO)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_nickname", "emptySocialMemberNickname");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_email", "emptySocialMemberEmail");
	}

}