package com.web.iami.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.iami.domain.EmailAccessDTO;

public class EmailAccessValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return EmailAccessDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		EmailAccessDTO dto = (EmailAccessDTO)target;

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "key_no", "emptyKeyNumber");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "key_accessKey", "emptyAccessKey");
	}

}
