<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버 로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script type="text/javascript">
	var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "KmvgOPJ6Ilbc111SxJ7C",
			callbackUrl: "https://iamiportfolio.com/login/naverCallback",
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
						} else if(data.status == "emailAlready") {
							alert("이미 가입된 이메일입니다.");
						} else {
							alert("알 수 없는 오류입니다.");
						}
						
						window.close();
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
</body>
</html>