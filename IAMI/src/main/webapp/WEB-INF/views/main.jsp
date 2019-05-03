<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IAMI</title>
<jsp:include page="/resources/common/common.jsp"/>
<script type="text/javascript">
$(document).ready(function() {
	resize();
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
	max-width: 1200px;
	margin: auto;
	padding: 0;
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
	</div>
</header>
<nav class="navWrapper">
	<div class="navInner">
		<ul>
			<li><span>전체</span></li>
			<li><span>친구</span></li>
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