package com.web.iami.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.iami.domain.NoticeDTO;

public class NoticeValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return NoticeDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		NoticeDTO dto = (NoticeDTO)target;

		ValidationUtils.rejectIfEmpty(errors, "mem_no", "emptyMemberNumber");
		ValidationUtils.rejectIfEmpty(errors, "cnc_subject", "emptyNoticeSubject");
		ValidationUtils.rejectIfEmpty(errors, "cnc_content", "emptyNoticeContent");
		ValidationUtils.rejectIfEmpty(errors, "cnc_type", "emptyNoticeType");
		ValidationUtils.rejectIfEmpty(errors, "cnc_hasImage", "emptyHasImageValue");
		ValidationUtils.rejectIfEmpty(errors, "cnc_hasVideo", "emptyHasVideoValue");
	}

}
