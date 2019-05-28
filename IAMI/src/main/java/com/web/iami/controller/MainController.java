package com.web.iami.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sun.mail.iap.Response;
import com.web.iami.domain.PortfolioDTO;
import com.web.iami.service.PortfolioService;

@Controller
public class MainController {

	@Inject
	private PortfolioService portfolioService;
	
	@RequestMapping("")
	public String main(@RequestParam(value="type", defaultValue = "new") String type,
			@RequestParam(value="page", defaultValue = "1") int page,
			@RequestParam(value="row", defaultValue = "12") int row,
			Model model) {
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		map.put("page", (page-1)*row+1);
		map.put("row", row);

		
		try {
			List<PortfolioDTO> list = null;
			
			if(type.equals("new")) {
				list = portfolioService.selectNewPortfolio(map);					
			} else if(type.equals("popular")) {
				list = portfolioService.selectPopularPortfolio(map);
			}
			model.addAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("type", type);
		model.addAttribute("page", page);
		
		return "main";
	}
	
	// 권한 없는 페이지 접근 시
	@RequestMapping("/access-denied")
	public String access_denied() {
		return "error/access-denied";
	}

	// 중복 로그인 발생 시
	@RequestMapping("/expired-login")
	public String expired_login() {
		return "error/expired-login";
	}
	
	// 테스트
	@RequestMapping("/testLogin")
	public String isComplete(HttpSession session) {
		return "login/login";
	}
	
	// 테스트
	@RequestMapping("/callback")
	public String callback(HttpSession session) {
		return "login/callback";
	}
	
	// 테스트
	@RequestMapping("/personalInfo")
	public String personalInfo(HttpSession session) {
		StringBuffer response = new StringBuffer();
		
		String token = "AAAAOB6yXBab9KCPR31mr2Of6_rNP4Kj7l256zCWJOBn9MeSVdF8DNCFBgdHC9FlctAtPSrtNpaPZG3irssgeAZih5c";// 네이버 로그인 접근 토큰; 여기에 복사한 토큰값을 넣어줍니다.
		String header = "Bearer " + token; // Bearer 다음에 공백 추가
		try {
			String apiURL = "https://openapi.naver.com/v1/nid/me";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode==200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {  // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			while ((inputLine = br.readLine()) != null) {
			response.append(inputLine);
		}
			br.close();
			System.out.println(response.toString());
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return response.toString();
	}
	
}