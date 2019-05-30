<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.math.BigInteger"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<jsp:include page="/resources/common/common.jsp"/>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function() {	
	var naverLogin = new naver.LoginWithNaverId(
			{
				clientId: "KmvgOPJ6Ilbc111SxJ7C",
				callbackUrl: "https://iamiportfolio.com/login/naverCallback",
				isPopup: true, /* 팝업을 통한 연동처리 여부 */
				loginButton: {color: "green", type: 1, height: 47} /* 로그인 버튼의 타입을 지정  */
			}
	);
	naverLogin.init();
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
function snsLogin(infos) {
 	var $form = $("<form></form>");
	$form.attr("action", "<c:url value='/loginOk'/>");
	$form.attr("method", "post");
	$form.append("<input type='hidden' id='mem_id' name='mem_id' value='" + infos[0] + "'/>");
	$form.append("<input type='hidden' id='mem_pw' name='mem_pw' value='" + infos[1] + "'/>");
	$form.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
	$form.appendTo("body");
	$form.submit();
}
function googleLogin(url) {
	var pop = window.open(url,"pop","width=600,height=600, scrollbars=yes, resizable=yes");
}
function facebookLogin(url) {
	var pop = window.open(url,"pop","scrollbars=yes, resizable=yes");
}
</script>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/image/main/icon.ico">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login.css">
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v3.3&appId=372667063380455&autoLogAppEvents=1"></script>
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
			<%-- <div class="naver" onclick="location.href='<%=apiURL%>'">N</div> --%>
			<div id="naverIdLogin"></div>
<!-- 		<div class="kakao">K</div>
			<div class="facebook">F</div> -->
			<%-- <div onclick="googleLogin('${google_url}');"><img class="btn-google" src="${pageContext.request.contextPath}/resources/image/main/btn_google_sign.png"/></div> --%>
			<img class="btn-login" onclick="googleLogin('${google_url}');" src="${pageContext.request.contextPath}/resources/image/main/btn-google.png"/>
			<img class="btn-login" onclick="facebookLogin('${facebook_url}');" src="${pageContext.request.contextPath}/resources/image/main/btn-facebook.png"/>
		</div>
		<div class="register-box">
			<div class="comment">아직 회원이 아니신가요?</div>
			<button class="w3-button btn-login" onclick="location.href='${pageContext.request.contextPath}/register'">회원가입</button>
		</div>
	</div>
</div>
<jsp:include page="/resources/include/footer/footer.jsp"/>
</body>
</html>