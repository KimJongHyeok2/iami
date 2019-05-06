<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<jsp:include page="/resources/common/common.jsp"/>
<script type="text/javascript">
function validCheck(obj) {
	var id = obj["mem_id"].value; 
	var pw = obj["mem_pw"].value;
	
	if(id == "" || id.length == 0) {
		alert("아이디를 입력해주세요.");
		return false;
	}
	if(pw == "" || pw.length == 0) {
		alert("비밀번호를 입력해주세요.");
		return false;
	}
}
</script>
<style type="text/css">
html, body {
	background-color: #f4f5f7;
}
.loginInner {
	max-width: 500px;
	margin: auto;
}
.loginInner .logo {
	text-align: center;
}
.loginInner .form {
}
.loginInner .form input {
	width: 100%;
	height: 50px;
	padding: 5px;
}
.loginInner .form .input-id {
	border: 1px solid #D5D5D5;
	border-bottom: none;
}
.loginInner .form .input-pw {
	border: 1px solid #D5D5D5;
}
.loginInner .form .btn-login {
	width: 100%;
	height: 50px;
	background-color: #1187CF;
	color: white;
}
.loginInner .form .check-valid {
	margin-top: 5px;
	color: #CC3D3D;
}
.loginInner .func-box {
	margin-top: 10px;
	text-align: center;
}
.loginInner .func-box span {
	font-size: 8pt;
	color: gray;
	cursor: pointer;
}
.loginInner .func-box .find-id {
	margin-right: 5px;
	padding-right: 5px;
	border-right: 1px solid #D5D5D5;
}
.loginInner .social-box {
	margin-top: 20px;
	text-align: center;
	font-size: 13pt;
}
.loginInner .social-box div {
	display: inline-block;
	width: 40px;
	height: 40px;
	line-height: 40px;
	border-radius: 50px;
	padding: 0 !important;
	cursor: pointer;
}
.loginInner .social-box .naver {
	font-weight: bold;
	background-color: #03cf5d;
	color: white;
}
.loginInner .social-box .kakao {
	font-weight: bold;
	background-color: #f9df33;
	color: white;
}
.loginInner .social-box .facebook {
	font-weight: bold;
	background-color: #3b5998;
	color: white;
}
.loginInner .social-box .google {
	font-weight: bold;
	background-color: #F15F5F;
	color: white;
}
.loginInner .register-box {
	margin-top: 20px;
}
.loginInner .register-box .comment {
	text-align: center;
	font-size: 10pt;
	color: gray;
}
.loginInner .register-box button {
	width: 100%;
	height: 50px;
	margin-top: 5px;
	background-color: #1187CF;
	color: white;
}
@media (max-width: 600px) {
	.logo img {
		width: 220px;
		height: 150px;
	}
}
</style>
</head>
<body>
<div class="container">
	<div class="loginInner">
		<div class="logo">
			<a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/image/main/regLogo.png"/></a>
		</div>
		<div class="form">
			<form action="<c:url value='/loginOk'/>" method="post" onsubmit="return validCheck(this);">
				<input id="mem_id" name="mem_id" type="text" class="input-id" value="${mem_id}" placeholder="아이디"/>
				<input id="mem_pw" name="mem_pw" type="password" class="input-pw" placeholder="비밀번호"/>
				<button class="w3-button btn-login" onclick="register();">로그인</button>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
			<c:if test="${not empty errorMsg}">
				<label class="check-valid">${errorMsg}</label>
			</c:if>
		</div>
		<div class="func-box">
			<span class="find-id">아이디 찾기</span><span class="find-pw">비밀번호 찾기</span>
		</div>
		<div class="social-box">
			<div class="naver">N</div>
			<div class="kakao">K</div>
			<div class="facebook">F</div>
			<div class="google">G</div>
		</div>
		<div class="register-box">
			<div class="comment">아직 회원이 아니시라면</div>
			<button class="w3-button btn-login" onclick="location.href='${pageContext.request.contextPath}/register'">회원가입</button>
		</div>
	</div>
</div>
</body>
</html>