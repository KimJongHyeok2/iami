package com.web.iami.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.iami.domain.PortfolioDTO;

public class PortfolioValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return PortfolioDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		PortfolioDTO dto = (PortfolioDTO)target;

		if(dto.getMem_no() == 0) {
			errors.rejectValue("mem_no", "emptyMemberNumber");
		}
		
		ValidationUtils.rejectIfEmpty(errors, "pot_subject", "emptySubject");
		ValidationUtils.rejectIfEmpty(errors, "pot_description", "emptyDescription");
		ValidationUtils.rejectIfEmpty(errors, "pot_summary", "emptySummary");
		ValidationUtils.rejectIfEmpty(errors, "pot_startdate", "emptyStartDate");
		ValidationUtils.rejectIfEmpty(errors, "pot_enddate", "emptyEndDate");
		ValidationUtils.rejectIfEmpty(errors, "pot_environment", "emptyEnvironment");
		ValidationUtils.rejectIfEmpty(errors, "pot_thumbnail", "emptyThumbnail");
		ValidationUtils.rejectIfEmpty(errors, "pot_video", "emptyVideo");
		ValidationUtils.rejectIfEmpty(errors, "pot_source", "emptySource");
	}

}