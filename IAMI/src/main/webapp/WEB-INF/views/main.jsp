<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IAMI</title>
<jsp:include page="/resources/common/common.jsp"/>
<style type="text/css">
.headerWrapper {
	border-bottom: 1px solid #D5D5D5;
}
.headerWrapper .headerInner {
	max-width: 1200px;
	margin: auto;
	padding: 0;
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
<section class="contentWrapper">
테스트
</section>
<footer class="footerWrapper">
푸터
</footer>
</body>
</html>