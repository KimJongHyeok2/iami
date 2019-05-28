<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script type="text/javascript">
	var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "KmvgOPJ6Ilbc111SxJ7C",
			callbackUrl: "http://localhost/iami/callback",
			isPopup: false,
			callbackHandle: true
			/* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다. */
		}
	);

	/* (3) 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
	naverLogin.init();

	/* (4) Callback의 처리. 정상적으로 Callback 처리가 완료될 경우 main page로 redirect(또는 Popup close) */
	window.addEventListener('load', function () {
		naverLogin.getLoginStatus(function (status) {
			if (status) {
				/* (5) 필수적으로 받아야하는 프로필 정보가 있다면 callback처리 시점에 체크 */
				var email = naverLogin.user.getEmail();
				var name = naverLogin.user.getNickName();
				var gender = naverLogin.user.getGender();
				if(email == undefined || email == null) {
					alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
					/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
					naverLogin.reprompt();
					return;
				}
				if(name == undefined || name == null) {
					alert("별명은 필수정보입니다. 정보제공을 동의해주세요.");
					/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
					naverLogin.reprompt();
					return;
				}
				if(gender == undefined || gender == null) {
					alert("성별은 필수정보입니다. 정보제공을 동의해주세요.");
					/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
					naverLogin.reprompt();
					return;
				}
				/* window.location.replace("http://localhost/iami/personalInfo"); */
			} else {
				console.log("callback 처리에 실패하였습니다.");
			}
		});
	});
	
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			var name = naverLogin.user.getNickName();
			var email = naverLogin.user.getEmail();
			var uniqId = naverLogin.user.getId();
			var gender = naverLogin.user.getGender();
			var header = "${_csrf.headerName}";
			var token = "${_csrf.token}";
			
			$.ajax({
				url: "${pageContext.request.contextPath}/register/naver",
				type: "POST",
				data: {
					"mem_id" : uniqId,
					"mem_nickname" : name,
					"sns_gender" : gender,
					"mem_email" : email
				},
				cache: false,
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success: function(data, status) {
					if(status == "success") {
						if(data.status == "Ok") {
							var infos = [data.dto.mem_id, data.dto.mem_pw];
 							opener.snsLogin(infos);
 							window.close();
						} else if(data.status == "emailAlready") {
							alert("이미 가입된 이메일입니다.");
							window.close();
						} else {
							alert("알 수 없는 오류입니다.");ㅣ
						}
					}
				}
			});
		} else {
			console.log("AccessToken이 올바르지 않습니다.");
		}
	});
</script>
</head>
<body>
<%-- <%

		String clientId = "KmvgOPJ6Ilbc111SxJ7C";//애플리케이션 클라이언트 아이디값";
		String clientSecret = "00a9wBUnOw";//애플리케이션 클라이언트 시크릿값";
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = URLEncoder.encode("http://localhost/iami/callback", "UTF-8");
		String apiURL;
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&;";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;
		apiURL += "&state=" + state;
		String access_token = "";
		String refresh_token = "";
		System.out.println("apiURL="+apiURL);
		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.print("responseCode="+responseCode);
		if(responseCode==200) { // 정상 호출
			br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		} else {  // 에러 발생
			br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		}
		String inputLine;
		StringBuffer res = new StringBuffer();
		while ((inputLine = br.readLine()) != null) {
			res.append(inputLine);
		}
			br.close();
		if(responseCode==200) {
			out.println(res.toString());
		}
		} catch (Exception e) {
			System.out.println(e);
		}

%> --%>
</body>
</html>