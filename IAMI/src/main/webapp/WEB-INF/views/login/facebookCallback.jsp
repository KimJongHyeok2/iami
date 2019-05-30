<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이스북 로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
var name = "${name}";
var email = "${email}";
var header = "${_csrf.headerName}";
var token = "${_csrf.token}";

if(email == "" && email.length == 0) {
	email = "facebook";
}

$.ajax({
	url: "${pageContext.request.contextPath}/register/facebook",
	type: "POST",
	data: {
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
</script>
</head>
<body>
</body>
</html>