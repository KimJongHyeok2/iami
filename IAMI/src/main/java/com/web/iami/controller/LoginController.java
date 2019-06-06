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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.social.connect.Connection;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.api.User;
import org.springframework.social.facebook.api.UserOperations;
import org.springframework.social.facebook.api.impl.FacebookTemplate;
import org.springframework.social.facebook.connect.FacebookConnectionFactory;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.web.iami.domain.SocialInfoDTO;
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
	
	@Inject
	private SocialInfoDTO googleSocialInfo;
	@Autowired
	private GoogleOAuth2Template googleOAuth2Template;
	@Autowired
	@Qualifier("googleOAuth2Parameters")
	private OAuth2Parameters googleOAuth2Parameters;
	
	@Autowired
	private FacebookConnectionFactory connectionFactory;
	@Autowired
	@Qualifier("facebookOAuth2Parameters")
	private OAuth2Parameters facebookOAuth2Parameters;
	
	@RequestMapping("")
	public String login(HttpServletResponse response, Model model) {
		
		// Google Login URL 생성
		String googleUrl = googleOAuth2Template.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("google_url", googleUrl);
		
		// Facebook Login URL 생성
		OAuth2Operations oauthOperations = connectionFactory.getOAuthOperations();
		String facebookUrl = oauthOperations.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, facebookOAuth2Parameters);
		model.addAttribute("facebook_url", facebookUrl);
		
		return "login/login";
	}
	
	@GetMapping("/findInfo")
	public String findInfo(String type, Model model) {
		model.addAttribute("type", "findInfo");
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
	
	// 네이버 로그인 Callback
	@GetMapping("/naverCallback")
	public String callback(HttpSession session) {
		return "login/naverCallback";
	}
	
	// 구글 로그인 Callback
	@GetMapping("/googleCallback")
	public String googleCallback(HttpServletRequest request, Model model) throws Exception {
		
		String code = request.getParameter("code");

		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("code", code);
		parameters.add("client_id", googleSocialInfo.getClientId());
		parameters.add("client_secret", googleSocialInfo.getSecretCode());
		parameters.add("redirect_uri", googleOAuth2Parameters.getRedirectUri());
		parameters.add("grant_type", "authorization_code");
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String,String>>(parameters, headers);
		ResponseEntity<Map> responseEntity = restTemplate.exchange("https://www.googleapis.com/oauth2/v4/token", HttpMethod.POST, requestEntity, Map.class);
		Map<String, Object> responseMap = responseEntity.getBody();
		
		String[] tokens = ((String)responseMap.get("id_token")).split("\\.");
		Base64 base64 = new Base64(true);
		String body = new String(base64.decode(tokens[1]));
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> result = mapper.readValue(body, Map.class);
		
		model.addAttribute("name", result.get("name"));
		model.addAttribute("email", result.get("email"));
		
		return "login/googleCallback";
	}
	
	// 페이스북 로그인 Callback
	@GetMapping("/facebookCallback")
	public String facebookCallback(String code, Model model) {

		String redirectUri = facebookOAuth2Parameters.getRedirectUri();

		OAuth2Operations oauthOperations = connectionFactory.getOAuthOperations();
		AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, redirectUri, null);
		String accessToken = accessGrant.getAccessToken();
		Long expireTime = accessGrant.getExpireTime();
		
		if(expireTime != null && expireTime < System.currentTimeMillis()) {
			accessToken = accessGrant.getRefreshToken();
		}
		
		Connection<Facebook> connection = connectionFactory.createConnection(accessGrant);
		Facebook facebook = connection == null ? new FacebookTemplate(accessToken) : connection.getApi();
		UserOperations userOperations = facebook.userOperations();
		
		String[] fields = {"id", "email", "name"};
		User userProfile = facebook.fetchObject("me", User.class, fields);
		String name = userProfile.getName();
		String email = userProfile.getEmail(); 

		if(email == null) {
			Random ran = new Random();
			StringBuffer sb = new StringBuffer();
			int num = 0;
			
			// 페이스북 사용자가 이메일 주소 대신 전화번호 사용 시 난수로 대체 
			do {
				num = ran.nextInt(75) + 48;
				
				if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
					sb.append((char) num);
				} else {
					continue;
				}
			} while (sb.length() < 5);
			
			email = "fb" + sb.toString() + "@none.com";
		}
		model.addAttribute("name", name);
		model.addAttribute("email", email);
		
		return "login/facebookCallback";
	}
}