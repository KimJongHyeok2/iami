package com.web.iami.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.web.iami.domain.EmailAccessDTO;
import com.web.iami.service.MemberService;
import com.web.iami.util.EmailAccessValidator;
import com.web.iami.util.PasswordEncoding;

@RestController
@RequestMapping("/member")
public class RestMemberController {
	
	@Inject
	private MemberService memberService;
	@Inject
	private JavaMailSender maliSender;
	@Value("${email.username}")
	private String fromEmail;
	
	// 회원 닉네임 수정
	@PostMapping("/myinfo/update/nickname")
	public String updateNickname(@RequestParam(value = "mem_no", defaultValue = "0") int mem_no,
			String mem_nickname,
			HttpServletRequest request) {
		
		if(mem_no == 0 || mem_nickname == null) {
			return "Fail";
		} else {
			Map<String, String> map = new HashMap<String, String>();
			map.put("no", String.valueOf(mem_no));
			map.put("nickname", mem_nickname);
			
			try {
				int count = memberService.updateMemberNickname(map);
				if(count == 1) {
					request.getSession().setAttribute("mem_nickname", mem_nickname);
					return "Ok";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	// 회원 이메일 수정(인증키 요청)
	@PostMapping("/myinfo/update/emailAccess")
	public String updateEmail(String mem_email) {
		
		if(mem_email == null) {
			return "Fail";
		} else {
			try {
			Integer overlapCount = memberService.selectEmail(mem_email);
			
			if(overlapCount != 0) {
				return "Overlap";
			} else {
				EmailAccessDTO emailDTO = new EmailAccessDTO();
				
				int count = memberService.insertAccessKey(emailDTO);
				
				if(count == 1) {
					MimeMessage mail = maliSender.createMimeMessage();
					
					String html = "<h3>아래 인증키를 입력해주세요.</h3>"
							+ "<div style='width: 200px; height: 50px; line-height: 50px; text-align: center; background-color: rgba(246, 246, 246, 0.4); border: 1px solid #D5D5D5;'>"
							+ emailDTO.getKey_accessKey()
							+ "</div>";
					mail.setFrom(new InternetAddress(fromEmail, "IAMI", "utf-8"));
					mail.setText(html, "utf-8", "html");
					mail.setSubject("[IAMI] 이메일 정보 변경을 위한 인증키입니다.");
					mail.addRecipient(RecipientType.TO, new InternetAddress(mem_email));
					maliSender.send(mail);
					
					return String.valueOf(emailDTO.getKey_no());
				}
			}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	// 회원 이메일 수정(인증키 확인)
	@PostMapping("/myinfo/update/emailAccessOk")
	public String updateEmailOk(@RequestParam(value = "mem_no", defaultValue = "0") int mem_no,
			String mem_email, EmailAccessDTO dto, BindingResult result,
			HttpServletRequest request) {
		
		EmailAccessValidator validation = new EmailAccessValidator();
		
		if(validation.supports(dto.getClass()) && mem_no != 0) {
			validation.validate(dto, result);
			
			if(result.hasErrors()) {
				return "Fail";
			}
			
			try {
				String accessKey = memberService.selectAccessKey(dto.getKey_no());
				
				if(accessKey.equals(dto.getKey_accessKey())) {
					Map<String, String> map = new HashMap<String, String>();
					map.put("no", String.valueOf(mem_no));
					map.put("email", mem_email);
					
					int count = memberService.updateMemberEmail(map);
					if(count == 1) {	
						request.getSession().setAttribute("mem_email", mem_email);
						return "Ok";
					}
				} else {
					return "Wrong";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	// 회원 비밀번호 변경
	@PostMapping("/myinfo/update/password")
	public String updatePassword(@RequestParam(value = "mem_no", defaultValue = "0") int mem_no,
			String password_now, String password_new) {
		
		if(mem_no == 0 || password_now == null || password_now.length() == 0 || password_new == null || password_new.length() == 0) {
			return "Fail";
		} else {
			PasswordEncoding encode = new PasswordEncoding();
			
			try {
				String mem_pw = memberService.selectMemberPassword(mem_no);
				
				if(mem_pw == null || !encode.matches(password_now, mem_pw)) {
					return "Wrong";
				} else {
					if(encode.matches(password_new, mem_pw)) {
						return "Same";
					}
					password_new = encode.encode(password_new);
					
					Map<String, String> map = new HashMap<String, String>();
					map.put("no", String.valueOf(mem_no));
					map.put("password", password_new);
					
					int count = memberService.updateMemberPassword(map);
					if(count == 1) {
						return "Ok";
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "Fail";
	}
	
}