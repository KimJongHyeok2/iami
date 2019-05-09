package com.web.iami.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.iami.security.CustomUserDetails;
import com.web.iami.service.LoginService;
import com.web.iami.util.PasswordEncoding;

@Controller
@RequestMapping("/login")
public class LoginController {

	@Inject
	private LoginService loginService;
	@Inject
	private JavaMailSender mailSender;
	@Value("${email.username}")
	private String fromEmail;
	
	@RequestMapping("")
	public String login() {
		return "login/login";
	}
	
	@RequestMapping("/success")
	public String success(HttpServletRequest request) {
		
		CustomUserDetails userDetails = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getDetails();

		request.getSession().setAttribute("mem_id", userDetails.getMem_id());
		request.getSession().setAttribute("nickname", userDetails.getMem_nickname());
		
		return "redirect:/";
	}
	
	@GetMapping("/findInfo")
	public String findInfo(String type) {
		return "main";
	}
	
	@PostMapping("/findID")
	public String findID(String mem_nickname, String mem_email) {
		
		if(mem_nickname == null || mem_nickname.length() == 0 || mem_email == null || mem_email.length() == 0) {
			return "redirect:/";
		} else {
			try {
				Map<String, String> map = new HashMap<String, String>();
				
				map.put("nickname", mem_nickname);
				map.put("email", mem_email);
				
				String id = loginService.selectFindID(map);
				
				if(id == null || id.length() == 0) {
					return "find/notfound";
				}
				
				MimeMessage mail = mailSender.createMimeMessage();
				
				String html = "<h3>회원님의 아이디입니다.</h3>"
						+ "<div style='width: 200px; height: 50px; line-height: 50px; text-align: center; background-color: rgba(246, 246, 246, 0.4); border: 1px solid #D5D5D5;'>"
						+ id
						+ "</div>";
				
					mail.setFrom(new InternetAddress(fromEmail, "IAMI", "utf-8"));
					mail.setText(html, "utf-8", "html");
					mail.setSubject("[IAMI] 아이디 찾기 서비스입니다.", "utf-8");
					mail.addRecipient(RecipientType.TO, new InternetAddress(mem_email));
					mailSender.send(mail);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (MessagingException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "find/success";
	}
	
	@PostMapping("/findPW")
	public String findPW(String mem_id, String mem_nickname, String mem_email) {
		
		if(mem_id == null || mem_id.length() == 0 || mem_nickname == null || mem_nickname.length() == 0 || mem_email == null || mem_email.length() == 0) {
			return "redirect:/";
		} else {
			Map<String, String> map = new HashMap<String, String>();
			
			map.put("id", mem_id);
			map.put("nickname", mem_nickname);
			map.put("email", mem_email);
			
			try {
				Integer mem_no = loginService.selectFindPW(map);
				
				if(mem_no != null) {
					map = new HashMap<String, String>();
					
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
					
					map.put("no", String.valueOf(mem_no));
					
					PasswordEncoding encoder = new PasswordEncoding();
					map.put("password", encoder.encode(sb));
					
					MimeMessage mail = mailSender.createMimeMessage();
					
					String html = "<h3>회원님의 임시 비밀번호입니다.</h3>"
							+ "<div style='width: 200px; height: 50px; line-height: 50px; text-align: center; background-color: rgba(246, 246, 246, 0.4); border: 1px solid #D5D5D5;'>"
							+ sb
							+ "</div>";
					mail.setFrom(new InternetAddress(fromEmail, "IAMI", "utf-8"));
					mail.setText(html, "utf-8", "html");
					mail.setSubject("[IAMI] 비밀번호 찾기 서비스입니다.", "utf-8");
					mail.addRecipient(RecipientType.TO, new InternetAddress(mem_email));
					mailSender.send(mail);

					int count = loginService.updateMemberPW(map);
					if(count != 1) {
						return "find/error";
					}
				} else {
					return "find/notfound";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "find/success";
	}
}