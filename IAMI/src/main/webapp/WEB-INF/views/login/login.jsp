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
$(document).ready(function() {
	$(".social-box div").click(function() {
		alert("공부 중입니다!");
	});
});
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
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/image/main/icon.ico">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login.css">
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
				<button class="w3-button btn-login">로그인</button>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
			<c:if test="${not empty errorMsg}">
				<label class="check-valid">${errorMsg}</label>
			</c:if>
		</div>
		<div class="func-box">
			<span onclick="location.href='${pageContext.request.contextPath}/login/findInfo'">아이디/비밀번호 찾기</span>
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
<jsp:include page="/resources/include/footer/footer.jsp"/>
</body>
</html>