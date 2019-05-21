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
var visitChart;
$(document).ready(function() {
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	resize();
	
	$(".user").click(function() {
		$("#user-drop").toggle();
	});
	$.ajax({
		url: "${pageContext.request.contextPath}/common/visitor",
		type: "GET",
		cache: false,
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data.status == "Ok") {
					var visitCount = new Array();
					var visitDate = new Array();
					for(var i=0; i<data.count; i++) {
						visitDate.push(data.list[i].vit_date);
						visitCount.push(data.list[i].vit_count);
					}
					visitChart = c3.generate({
						bindto: "#chart",
						data: {
							json: {
								date: visitDate,
								data1: visitCount,
								data2: visitCount
							},
							x: "date",
							names: {
								data1: "방문자(Bar)",
								data2: "방문자(Line)"
							},
							types: {
								data1: "bar",
								data2: "line"
							},
						},
						grid: {
							x: {
								show: true
							},
							y: {
								show: true
							}
						},
						axis: {
							x: {
								tick: {
									format: function (x) {
										var dates = new Date(x);
										var year = dates.getFullYear();
										var month = dates.getMonth()+1;
										month = (month + "").length == 1? ("0" + month):month;
										var day = dates.getDate();
										day = (day + "").length == 1? ("0" + day):day;
										
										return year + "-" + month + "-" + day;
									}
								}
							}
						},
					});
				}
			}
		}
	});
});
$(window).resize(function() {
	resize();
	visitChart.resize({
		width: $(".chart").width()
	});
});
function resize() {
	$htmlHeight = $("html").height();
	$headerHeight = $(".headerWrapper").height();
	$navHeight = $(".navWrapper").height();
	$chartHeight = $(".chartWrapper").height();
	$footerHeight = $(".footerWrapper").height();
	
	$(".container-fluid").css("min-height", $htmlHeight - $headerHeight - $navHeight - $chartHeight - $footerHeight - 71 + "px");
}
function userList(type) {
	if(type == "write") {
		location.href = "${pageContext.request.contextPath}/portfolio/write";
	} else if(type == "myinfo") {
		location.href = "${pageContext.request.contextPath}/member/myinfo";
	}
}
function list(type) {
	var $form = $("<form>/<form>");
	$form.attr("action", "${pageContext.request.contextPath}/");
	$form.attr("method", "post");
	$form.append("<input type='hidden' id='type' name='type' value='" + type + "'/>");
	$form.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
	$form.appendTo("body");
	$form.submit();
}
function dateFormat(date) {
	var dates = new Date(date);
	var year = dates.getFullYear();
	var month = dates.getMonth()+1;
	month = (month + "").length == 1? ("0" + month):month;
	var day = dates.getDate();
	day = (day + "").length == 1? ("0" + day):day;
	
	return year + "-" + month + "-" + day;
}
function openChart() {
	visitChart.resize({
		width: $(".chart").width()
	});
	$(".chart").toggle();
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
	margin-right: 5px;
	cursor: pointer;
}
.headerWrapper .headerInner .user .profile-img {
	width: 35px;
	height: 35px;
	border-radius: 50%;
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.headerWrapper .headerInner .user .profile-img-none {
	width: 35px;
	height: 35px;
}
.headerWrapper .headerInner .account {
	float: right;
	margin-right: 5px;
}
.headerWrapper .headerInner .account-399 {
	position: relative;
	display: none;
	margin-right: 5px;
}
.headerWrapper .headerInner .account button {
	border-color: rgba(17, 135, 207, 0.4) !important;
	color: rgba(17, 135, 207, 0.8) !important;
}
.headerWrapper .headerInner .account-399 button {
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
	margin-right: 10px;
}
.headerWrapper .headerInner .user ul li .user-info .profile .profile-img {
	width: 100%;
	height: 100%;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 50%;
}
.headerWrapper .headerInner .user ul li .user-info .profile .profile-img-none {
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
	background-color: rgba(17, 135, 207, 0.4);
}
.navWrapper .navInner {
	max-width: 1200px;
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
.contentWrapper .container-fluid {
	position: relative;
	max-width: 1200px;
	margin: auto;
	padding: 0;
}
.chartWrapper {
	margin-bottom: 10px;
}
.chartWrapper .chartInner {
	position: relative;
	max-width: 1200px;
	margin: auto;
	padding: 0 10px;
}
.chartWrapper .chartInner .chart-box {
	text-align: center;
}
.chartWrapper .chartInner .chart-box .chart {
	display: none;
	position: absolute;
	width: 100%;
	max-width: 500px;
	top: -340px;
	left: 50%;
	transform: translatex(-50%);
	padding: 5px;
	background-color: white;
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.chartWrapper .chartInner .chart-box .chart-btn {
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
@media (max-width:399px) {
	.account {
		display: none;
	}
	#account-399 {
		display: block;
	}
}
</style>
</head>
<body>
<div class="headerWrapper">
	<div class="headerInner">
		<div class="logo">
			<a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/image/main/logo.png"/></a>
		</div>
		<s:authorize access="!isAuthenticated()">
			<div class="account">
				<button class="w3-button w3-white w3-border" onclick="location.href='${pageContext.request.contextPath}/login'">로그인</button>
				<button class="w3-button w3-white w3-border" onclick="location.href='${pageContext.request.contextPath}/register'">회원가입</button>
			</div>
			<div id="account-399" class="account-399">
				<button class="w3-button w3-white w3-border" onclick="location.href='${pageContext.request.contextPath}/login'"><i class="fas fa-sign-in-alt"></i></button>		
			</div>
		</s:authorize>
		<s:authorize access="isAuthenticated()">
	 		<div class="user">
	 			<c:choose>
	 				<c:when test="${not empty sessionScope.mem_profile}">
						<img id="head-profile" class="profile-img" src="${pageContext.request.contextPath}/resources/upload/${sessionScope.mem_profile}"/>
	 				</c:when>
	 				<c:otherwise>
	 					<img id="head-profile" class="profile-img-none" src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
	 				</c:otherwise>
				</c:choose>
				<ul id="user-drop" class="w3-animate-zoom">
					<li>
						<div class="user-info">
							<div class="profile">
					 			<c:choose>
					 				<c:when test="${not empty sessionScope.mem_profile}">
										<img id="drop-profile" class="profile-img" src="${pageContext.request.contextPath}/resources/upload/${sessionScope.mem_profile}"/>
					 				</c:when>
					 				<c:otherwise>
					 					<img id="drop-profile" class="profile-img-none" src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
					 				</c:otherwise>
								</c:choose>
							</div>
							<div class="info">
								<div>${sessionScope.mem_nickname}</div>
								<div>${sessionScope.mem_id}</div>
							</div>
						</div>
					</li>
					<li class="user-list" onclick="userList('myinfo');">
						<i class="fas fa-user-edit"></i> 내 정보
					</li>
<!-- 				<li class="user-list">
						<i class="fas fa-user-friends"></i> 친구목록
					</li> -->
					<li class="user-list" onclick="userList('write');">
						<i class="fas fa-edit"></i> 포트폴리오 업로드
					</li>
					<li class="user-list">
						<i class="far fa-folder-open"></i> 내 포트폴리오
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
</div>
<div class="navWrapper">
	<div class="navInner">
		<ul>
			<li onclick="list('new');"><span>최신순</span></li>
			<li onclick="list('popular');"><span>인기순</span></li>
		</ul>
	</div>
</div>
<div class="contentWrapper">
	<div class="container-fluid">
		<c:choose>
			<c:when test="${type == 'findInfo'}">
				<jsp:include page="find/findInfo.jsp"/>
			</c:when>
			<c:when test="${type == 'view'}">
				<jsp:include page="portfolio/view.jsp"/>
			</c:when>
			<c:when test="${type == 'myinfo'}">
				<jsp:include page="myinfo/myinfo.jsp"/>
			</c:when>
			<c:otherwise>
				<jsp:include page="portfolio/list.jsp"/>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<c:if test="${type == 'new' || type == 'popular'}">
	<div class="chartWrapper">
		<div class="chartInner">
			<div class="chart-box">
				<div class="chart">
					<div id="chart"></div>
				</div>
				<button class="w3-button chart-btn" onclick="openChart();">
					<div><i class="fas fa-chevron-up"></i></div>
					<div>방문자 통계</div>
				</button>
			</div>
		</div>
	</div>
</c:if>
<jsp:include page="/resources/include/footer/footer.jsp"/>
</body>
</html>