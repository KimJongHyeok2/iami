package com.web.iami.controller;

import java.util.Random;

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
import com.web.iami.domain.SocialLoginDTO;
import com.web.iami.domain.SocialMemberDTO;
import com.web.iami.service.MemberService;
import com.web.iami.service.RegisterService;
import com.web.iami.util.EmailAccessValidator;
import com.web.iami.util.MemberValidator;
import com.web.iami.util.SocialMemberValidator;

@RestController
@RequestMapping("/register")
public class RestRegisterController {

	@Inject
	private RegisterService registerService;
	@Inject
	private MemberService memberService;
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
		
		EmailAccessValidator validation = new EmailAccessValidator();
		
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
		
		MemberValidator validation = new MemberValidator();
		
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
	
	// 네이버 연동 회원가입
	@PostMapping("/naver")
	public SocialLoginDTO naverRegister(SocialMemberDTO dto, BindingResult result) {
		
		SocialLoginDTO socialDTO = new SocialLoginDTO();
		
		SocialMemberValidator validation = new SocialMemberValidator();
		
		// 유효성 검사
		if(validation.supports(dto.getClass())) {
			validation.validate(dto, result);
			
			if(!result.hasErrors()) {
				try {
					// 아이디 설정
					dto.setMem_id(dto.getMem_email().substring(0, dto.getMem_email().lastIndexOf("@")));
					
					// 기존에 가입된 회원인지
					int count = registerService.selectMemberCountById(dto.getMem_id());
					
					// 가입되지 않았다면
					if(count == 0) {
						int emailCount = registerService.selectEmailCountByEmail(dto.getMem_email());
						
						if(emailCount != 0) {
							socialDTO.setStatus("emailAlready");
							return socialDTO;
						}
						
						// 비밀번호 난수 생성
						Random ran = new Random();
						StringBuffer sb = new StringBuffer();
						int num = 0;

						do {
							num = ran.nextInt(75) + 48;
							
							if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
								sb.append((char) num);
							} else {
								continue;
							}
						} while (sb.length() < 10);
						
						// Spring 5버전부터 비밀번호 인코더 미사용시 {noop}명시
						dto.setMem_pw("{noop}" + sb.toString());
						
						// 성별 값 남자(M) 1, 여자 2
						if(dto.getSns_gender().equals("M")) {
							dto.setMem_gender(1);
						} else {
							dto.setMem_gender(2);							
						}
						
						int count2 = registerService.insertMemberByNaver(dto);
						
						if(count2 == 1) {
							socialDTO.setDto(dto);
							socialDTO.setStatus("Ok");
							return socialDTO;
						}
					} else if(count == 1) { // 이미 가입되어 있다면
						socialDTO.setStatus("Ok");
						socialDTO.setDto(dto);
						socialDTO.getDto().setMem_pw(registerService.selectPasswordById(dto.getMem_id())); // 난수로 생성한 비밀번호 SET
						return socialDTO;
					}
				} catch (Exception e) {
					e.printStackTrace();
				}				
			}
		}
		
		socialDTO.setStatus("Fail");
		
		return socialDTO;
	}
	
	// 구글 연동 회원가입
	@PostMapping("/google")
	public SocialLoginDTO googleRegister(SocialMemberDTO dto, BindingResult result) {
		
		SocialLoginDTO socialDTO = new SocialLoginDTO();
		
		System.out.println(dto.getMem_email());
		System.out.println(dto.getMem_email());
		System.out.println(dto.getMem_email());
		System.out.println(dto.getMem_email());
		
		SocialMemberValidator validation = new SocialMemberValidator();
		
		// 유효성 검사
		if(validation.supports(dto.getClass())) {
			validation.validate(dto, result);
			
			if(!result.hasErrors()) {
				try {
					// 아이디 설정
					dto.setMem_id(dto.getMem_email().substring(0, dto.getMem_email().lastIndexOf("@")));
					
					// 기존에 가입된 회원인지
					int count = registerService.selectMemberCountById(dto.getMem_id());
					
					// 가입되지 않았다면
					if(count == 0) {
						int emailCount = registerService.selectEmailCountByEmail(dto.getMem_email());
						
						if(emailCount != 0) {
							socialDTO.setStatus("emailAlready");
							return socialDTO;
						}
						
						// 비밀번호 난수 생성
						Random ran = new Random();
						StringBuffer sb = new StringBuffer();
						int num = 0;
						
						do {
							num = ran.nextInt(75) + 48;
							
							if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
								sb.append((char) num);
							} else {
								continue;
							}
						} while (sb.length() < 10);
						
						// Spring 5버전부터 비밀번호 인코더 미사용시 {noop}명시
						dto.setMem_pw("{noop}" + sb.toString());
						
						int count2 = registerService.insertMemberByGoogle(dto);
						
						if(count2 == 1) {
							socialDTO.setDto(dto);
							socialDTO.setStatus("Ok");
							return socialDTO;
						}
					} else if(count == 1) { // 이미 가입되어 있다면
						socialDTO.setStatus("Ok");
						socialDTO.setDto(dto);
						socialDTO.getDto().setMem_pw(registerService.selectPasswordById(dto.getMem_id())); // 난수로 생성한 비밀번호 SET
						return socialDTO;
					}
				} catch (Exception e) {
					e.printStackTrace();
				}				
			}
		}
		
		socialDTO.setStatus("Fail");
		
		return socialDTO;
	}
}