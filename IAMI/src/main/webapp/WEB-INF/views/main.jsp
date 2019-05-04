<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IAMI</title>
<jsp:include page="/resources/common/common.jsp"/>
<script type="text/javascript">
$(document).ready(function() {
	resize();
	$(".user").click(function() {
		$("#user-drop").toggle();
	});
});
$(window).resize(resize);
function resize() {
	$htmlHeight = $("html").height();
	$headerHeight = $(".headerWrapper").height();
	$navHeight = $(".navWrapper").height();
	$footerHeight = $(".footerWrapper").height();
	
	$(".container-fluid").css("min-height", $htmlHeight - $headerHeight - $navHeight - $footerHeight - 42 + "px");
}
</script>
<style type="text/css">
.headerWrapper {
	border-bottom: 1px solid #D5D5D5;
}
.headerWrapper .headerInner {
	display: flex;
	justify-content: space-between;
	align-items: center;
	max-width: 1200px;
	margin: auto;
	padding: 0;
}
.headerWrapper .headerInner .user {
	position: relative;
	float: right;
	width: 35px;
	height: 35px;
	border-radius: 50px;
	cursor: pointer;
}
.headerWrapper .headerInner .account {
	float: right;
	margin-right: 5px;
}
.headerWrapper .headerInner .account button {
	border-color: rgba(17, 135, 207, 0.4) !important;
	color: rgba(17, 135, 207, 0.8) !important;
}
.headerWrapper .headerInner .user img {
	width: 100%;
	height: 100%;
}
.headerWrapper .headerInner .user ul {
	display: none;
	position: absolute;
	top: 40px;
	left: -225px;
	width: 250px;
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	background-color: white;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	z-index: 1;
	cursor: default;
}
.headerWrapper .headerInner .user ul li {
	padding: 10px;
}
.headerWrapper .headerInner .user ul li .user-info {
	display: flex;
	align-items: center;
}
.headerWrapper .headerInner .user ul li .user-info .profile {
	width: 50px;
	height: 50px;
	border-radius: 50px;
	margin-right: 10px;
}
.headerWrapper .headerInner .user ul li .user-info .profile img {
	width: 100%;
	height: 100%;
}
.headerWrapper .headerInner .user ul li.user-list {
	border-top: 1px solid #EAEAEA;
	cursor: pointer;
	/* color: rgba(17, 135, 207, 0.7); */
	color: #747474;
}
.headerWrapper .headerInner .user ul li.user-list:hover {
	background-color: #EAEAEA;
}
.navWrapper {
	border-bottom: 1px solid #D5D5D5;
	background-color: rgba(17, 135, 207, 0.4);
}
.navWrapper .navInner {
	width: 1200px;
	margin: auto;
	color: white;
}
.navWrapper .navInner ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.navWrapper .navInner ul li {
	display: inline-block;
	padding: 10px;
	cursor: pointer;
}
.navWrapper .navInner ul li span:hover {
	border-bottom: 3px solid white;
}
.footerWrapper {
	padding: 20px;
	font-size: 10pt;
	text-align: center;
	background-color: #f4f5f7;
}
.footerWrapper span {
	color: gray;
}
</style>
</head>
<body>
<header class="headerWrapper">
	<div class="headerInner">
		<div class="logo">
			<img src="${pageContext.request.contextPath}/resources/image/main/logo.png"/>
		</div>
		<s:authorize access="!isAuthenticated()">
			<div class="account">
				<button class="w3-button w3-white w3-border" onclick="location.href='${pageContext.request.contextPath}/login'">로그인</button>
				<button class="w3-button w3-white w3-border" onclick="location.href='${pageContext.request.contextPath}/register'">회원가입</button>
			</div>
		</s:authorize>
		<s:authorize access="isAuthenticated()">
	 		<div class="user">
				<img src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
				<ul id="user-drop" class="w3-animate-zoom">
					<li>
						<div class="user-info">
							<div class="profile">
								<img src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
							</div>
							<div class="info">
								<div>${sessionScope.nickname}</div>
								<div>${sessionScope.mem_id}</div>
							</div>
						</div>
					</li>
					<li class="user-list">
						<i class="fas fa-user-edit"></i> 내 정보
					</li>
					<li class="user-list">
						<i class="fas fa-user-friends"></i> 친구목록
					</li>
					<li class="user-list">
						<i class="fas fa-edit"></i> 포트폴리오 작성
					</li>
					<li class="user-list">
						<i class="far fa-folder-open"></i> 포트폴리오 목록
					</li>
					<li class="user-list" onclick="$('#logout').submit();">
						<i class="fas fa-sign-out-alt"></i> 로그아웃
						<form id="logout" action="<c:url value='/logout'/>" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						</form>
					</li>
				</ul>
			</div>
		</s:authorize>
	</div>
</header>
<nav class="navWrapper">
	<div class="navInner">
		<ul>
			<li><span>전체</span></li>
		</ul>
	</div>
</nav>
<section class="contentWrapper">
	<div class="container-fluid">
		컨테이너
	</div>
</section>
<footer class="footerWrapper">
Copyright <span>KimJongHyeok.</span> All Rights Reserved.
</footer>
</body>
</html>