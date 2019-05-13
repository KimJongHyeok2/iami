package com.web.iami.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.iami.domain.MemberDTO;

public class MemberValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberDTO dto = (MemberDTO)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_id", "emptyMemberID");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_pw", "emptyMemberPassword");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_nickname", "emptyMemberNickname");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_birth", "emptyMemberBirth");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_gender", "emptyMemberGender");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_email", "emptyMemberEmail");
	}

}