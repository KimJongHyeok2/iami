package com.web.iami.controller;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.iami.domain.EmailAccessDTO;
import com.web.iami.domain.MemberDTO;
import com.web.iami.service.RegisterService;
import com.web.iami.util.EmailAccessValidation;
import com.web.iami.util.MemberValidation;

@RestController
@RequestMapping("/register")
public class RestRegisterController {

	@Inject
	private RegisterService registerService;
	@Inject
	private JavaMailSender mailSender;
	@Value("${email.username}")
	private String fromEmail;
	
	// 아이디 중복확인
	@PostMapping("/idOverlap")
	public String idOverlap(String id) {
		
		if(!(id == null || id.length() == 0)) {
			try {
				int checkCount = registerService.selectID(id);
				
				if(checkCount == 0) {
					return "Ok";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	// 이메일 중복확인
	@PostMapping("/emailOverlap")
	public String emailOverlap(String email) {
		
		if(!(email == null || email.length() == 0)) {
			try {
				int checkCount = registerService.selectEmail(email);
				
				if(checkCount == 0) {
					return "Ok";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	// 이메일 인증키 전송
	@PostMapping("/sendEmail")
	public String sendEmail(String email) {
		
		if(!(email == null || email.length() == 0)) {
			// 객체 생성과 동시에 인증키 생성
			EmailAccessDTO emailDTO = new EmailAccessDTO();
			
			try {
				// DB에 이메일 인증키 저장
				int count = registerService.insertAccessKey(emailDTO);
				
				// DB에 이메일 인증키 저장 성공 시 이메일 전송
				if(count == 1) {
					MimeMessage mail = mailSender.createMimeMessage();
					
					String html = "<h3>아래 인증키를 입력해주세요.</h3>"
							+ "<div style='width: 200px; height: 50px; line-height: 50px; text-align: center; background-color: rgba(246, 246, 246, 0.4); border: 1px solid #D5D5D5;'>"
							+ emailDTO.getKey_accessKey()
							+ "</div>";
					mail.setFrom(new InternetAddress(fromEmail, "IAMI", "utf-8"));
					mail.setText(html, "utf-8", "html");
					mail.setSubject("[IAMI] 가입을 위한 이메일 인증키입니다.", "utf-8");
					mail.addRecipient(RecipientType.TO, new InternetAddress(email));
					mailSender.send(mail);
					return String.valueOf(emailDTO.getKey_no()); // DB에 저장된 이메일 인증키 PK 반환
				}
			} catch (Exception e) {
				e.printStackTrace();
			}	
		}
		
		return "Fail";
	}
	
	// 이메일 인증키 확인
	@PostMapping("/accessOk")
	public String accessOk(EmailAccessDTO dto, BindingResult result) {
		
		EmailAccessValidation validation = new EmailAccessValidation();
		
		// 이메일 유효성 검사
		if(validation.supports(dto.getClass())) {
			validation.validate(dto, result);
			
			if(!result.hasErrors()) {
				try {
					String accessKey = registerService.selectAccessKey(dto.getKey_no());
					
					if(accessKey.equals(dto.getKey_accessKey())) {
						return "Ok";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return "Fail";
	}
	
	// 회원가입 진행
	@PostMapping("/registerOk")
	public String registerOk(MemberDTO dto, BindingResult result) {
		
		MemberValidation validation = new MemberValidation();
		
		// 입력 정보 유효성 검사
		if(validation.supports(dto.getClass())) {
			validation.validate(dto, result);

			if(!result.hasErrors()) {
				try {
					int count = registerService.insertMember(dto);
					
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
}