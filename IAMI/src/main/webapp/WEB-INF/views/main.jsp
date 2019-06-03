<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IAMI</title>
<jsp:include page="/resources/common/common.jsp"/>
<script type="text/javascript">
var visitChart;
var rotate = 180;
$(document).ready(function() {
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	resize();
	noticeDateFormat();
	
	$(".user").click(function() {
		$("#user-drop").toggle();
	});
	if(${type == 'new'} || ${type == 'popular'}) {
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
										format: function(x) {
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
	}
});
$(window).resize(function() {
	resize();
	if(${type == 'new'} || ${type == 'popular'}) {
		visitChart.resize({
			width: $(".chart").width()
		});
	}
});
function resize() {
	$htmlHeight = $("html").height();
	$headerHeight = $(".headerWrapper").height();
	$navHeight = $(".navWrapper").height();
	$noticeHeight = $(".noticeWrapper").height();
	$chartHeight = $(".chartWrapper").height();
	$footerHeight = $(".footerWrapper").height();
	
	$(".container-fluid").css("min-height", $htmlHeight - $headerHeight - $navHeight - $noticeHeight - $chartHeight - $footerHeight - 81 + "px");
}
function userList(type) {
	if(type == "write") {
		location.href = "${pageContext.request.contextPath}/portfolio/write";
	} else if(type == "myinfo") {
		location.href = "${pageContext.request.contextPath}/member/myinfo";
	} else if(type == "list") {
		var no = "${empty sessionScope.mem_no? 0:sessionScope.mem_no}";
		if(no == 0) {
			alert("로그인이 필요합니다.");
			return false;
		} else {			
			portfolioList(no);
		}
	} else if(type == "noticeList") {
		location.href = "${pageContext.request.contextPath}/notice";
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
function noticeDateFormat() {
	var noticeLength = "${fn:length(noticeList)}"; 
	
	for(var i=0; i<noticeLength; i++) {
		var dates = new Date($("#notice-regdate-" + (i+1)).html().trim());
		var year = dates.getFullYear();
		var month = dates.getMonth()+1;
		month = (month + "").length == 1? ("0" + month):month;
		var day = dates.getDate();
		day = (day + "").length == 1? ("0" + day):day;
		
		$("#notice-regdate-" + (i+1)).html(year + "-" + month + "-" + day);
		$("#notice-regdate-m-" + (i+1)).html(year + "-" + month + "-" + day);
	}
}
function openChart() {
	visitChart.resize({
		width: $(".chart").width()
	});
	$(".chart").toggle();
	$("#chevron-up").css("transform", "rotate(" + rotate + "deg)");
	rotate += 180;
}
function portfolioList(no) {
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	$.ajax({
		url: "${pageContext.request.contextPath}/portfolio/list",
		type: "POST",
		data: {
			"mem_no" : no
		},
		cache: false,
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		complete: function(data) {
			$("#portfolio-list").toggle();
		},
		success: function(data, status) {
			if(status == "success") {
				if(data.status == "Ok") {
					if(data.mem_profile != null) {						
						$("#portfolio-profile").attr("src", "${pageContext.request.contextPath}/resources/upload/" + data.mem_profile + "");
					} else {
						$("#portfolio-profile").attr("src", "${pageContext.request.contextPath}/resources/image/main/user.png");
					}
					$("#portfolio-nickname").html(data.mem_nickname);
					var tempHTML = "";
					if(data.count > 0) {
						for(var i=0; i<data.count; i++) {
							tempHTML += "<li class='list'>";
								tempHTML += "<div class='container'>";							
									tempHTML += "<div class='row " + (i==data.count-1? "last":"") + "'>";
										tempHTML += "<div class='thumbnail-box'>";
											tempHTML += "<img class='thumbnail' src='${pageContext.request.contextPath}/resources/upload/" + data.list[i].pot_thumbnail  + "'/>";
										tempHTML += "</div>";
										tempHTML += "<div class='content-box'>";
											tempHTML += "<div class='title'>";
												tempHTML += "<h5>" + data.list[i].pot_subject + "</h5>";
											tempHTML += "</div>";
											tempHTML += "<div class='regdate'>";
												tempHTML += portfolioDateFormat(data.list[i].pot_regdate);
											tempHTML += "</div>";
											tempHTML += "<div class='functions'>";
												tempHTML += "<button class='w3-button view' onclick='view(" + data.list[i].pot_no + ")'>보기</button>";
												if(${not empty sessionScope.mem_no}) {
													if("${empty sessionScope.mem_no? 0:sessionScope.mem_no}" == data.list[i].mem_no) {
														tempHTML += "<button class='w3-button update' onclick='update(" + data.list[i].pot_no + ");'>수정</button>";
														tempHTML += "<button class='w3-button delete' onclick='deletes(" + data.list[i].pot_no + ", " + data.mem_no + ");'>삭제</button>";	
													}
												}
											tempHTML += "</div>";
										tempHTML += "</div>";
									tempHTML += "</div>";
								tempHTML += "</div>";
							tempHTML += "</li>";
						}
					} else {
						tempHTML += "<li class='list'>";
							tempHTML += "<div class='container'>";
								tempHTML += "<div class='row last empty'>";
									tempHTML += "<div class='empty'>등록된 포트폴리오가 없습니다.</div>";
								tempHTML += "</div>";
							tempHTML += "</div>";
						tempHTML += "</li>";
					}
					$("#portfolio").html(tempHTML);
				}
			}
		}
	});
}
function view(no) {
	location.href = "${pageContext.request.contextPath}/portfolio/view/" + no;
}
function update(no) {
	location.href = "${pageContext.request.contextPath}/portfolio/view/" + no;
	var $form = $("<form>/<form>");
	$form.attr("action", "${pageContext.request.contextPath}/portfolio/update");
	$form.attr("method", "post");
	$form.append("<input type='hidden' id='no' name='no' value='" + no + "'/>");
	$form.append('<s:csrfInput/>');
	$form.appendTo("body");
	$form.submit();
}
function deletes(pot_no, mem_no) {
	var confirms = confirm("정말로 삭제하시겠습니까?");
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	if(confirms) {
		$.ajax({
			url: "${pageContext.request.contextPath}/portfolio/deleteOk",
			type: "POST",
			data: {
				"pot_no" : pot_no
			},
			cache: false,
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						portfolioList(mem_no);
						$("#portfolio-list").toggle();
					} else {
						alert("알 수 없는 오류입니다.");
					}
				}
			}
		});	
	}
}
function portfolioDateFormat(date) {
	var dates = new Date(date);
	year = dates.getFullYear();
	month = dates.getMonth()+1;
	month = (month + "").length == 1? ("0" + month):month;
	day = dates.getDate();
	day = (day + "").length == 1? ("0" + day):day;
	var hour = dates.getHours();
	hour = (hour + "").length == 1? ("0" + hour):hour;
	var minute = dates.getMinutes();
	minute = (minute + "").length == 1? ("0" + minute):minute;
	
	return year + "-" + month + "-" + day + " " + hour + ":" + minute;
}
function page(no) {
	location.href= "${pageContext.request.contextPath}/notice/view/" + no;
}
</script>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/image/main/icon.ico">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
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
					<li class="user-list" onclick="userList('list');">
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
			<c:when test="${type == 'noticeList'}">
				<jsp:include page="notice/noticeList.jsp"/>
			</c:when>
			<c:when test="${type == 'noticeWrite'}">
				<jsp:include page="notice/noticeWrite.jsp"/>
			</c:when>
			<c:when test="${type == 'noticeView'}">
				<jsp:include page="notice/noticeView.jsp"/>
			</c:when>
			<c:otherwise>
				<jsp:include page="portfolio/list.jsp"/>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<c:if test="${type == 'new' || type == 'popular'}">
<div class="noticeWrapper">
	<div class="noticeInner">
		<div class="noticeInnerWrapper">
		<div class="noticeTitle">
			<h3>공지사항</h3>
			<div class="w3-button" onclick="userList('noticeList');">더 보기</div>
		</div>
		<div class="noticeContent">
			<ul class="noticeContentInner">
				<c:choose>
					<c:when test="${not empty noticeList && fn:length(noticeList) != 0}">
						<c:forEach var="i" items="${noticeList}" varStatus="index">
							<li>
								<div class="notice-inner">
									<div class="notice-type">
										<c:if test="${i.cnc_type == 1}">
											<div class="normal">일반</div>
										</c:if>
										<c:if test="${i.cnc_type == 2}">
											<div class="event">이벤트</div>
										</c:if>
									</div>
									<div class="notice-subject-box">
										<div class="subject" onclick="page(${i.cnc_no});">
											${i.cnc_subject}
										</div>
										<div class="subImage">
											<c:if test="${i.cnc_hasImage == 1}">
												<i class="fas fa-image"></i>
											</c:if>
											<c:if test="${i.cnc_hasVideo == 1}">
												<i class="fab fa-youtube"></i>
											</c:if>
										</div>
									</div>
									<div id="notice-regdate-${index.count}" class="notice-regdate">
										${i.cnc_regdate}
									</div>
									<div class="notice-view">
										조회 <span class="viewCount">${i.cnc_viewcount}</span>
									</div>
								</div>
								<div class="notice-inner m">
									<span id="notice-regdate-m-${index.count}" class="regdate m">${i.cnc_regdate}</span> <span class="viewCount m">조회 <span class="count">${i.cnc_viewcount}</span></span>
								</div>
							</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<li class="emptyNotice">
							등록된 공지사항이 없습니다.
						</li>
					</c:otherwise>
				</c:choose>
			</ul>	
		</div>
		</div>
	</div>
</div>
</c:if>
<c:if test="${type == 'new' || type == 'popular'}">
	<div class="chartWrapper">
		<div class="chartInner">
			<div class="chart-box">
				<div class="chart w3-animate-opacity">
					<div>
						<h3>주간 방문자 통계</h3>
					</div>
					<div id="chart"></div>
				</div>
				<button class="w3-button chart-btn" onclick="openChart();">
					<div><i id="chevron-up" class="fas fa-chevron-up"></i></div>
					<div>방문자 통계</div>
				</button>
			</div>
		</div>
	</div>
</c:if>
<div id="portfolio-list" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
		<div class="w3-center portfolio-content"><br>
			<span onclick="$('#portfolio-list').toggle();" class="w3-button w3-xlarge w3-display-topright" title="Close Modal">&times;</span>
			<img id="portfolio-profile" src="${pageContext.request.contextPath}/resources/image/main/user.png" alt="Profile" class="w3-circle w3-margin-top w3-margin-bottom"/>
			<div><h3 id="portfolio-nickname">NONE</h3></div>
			<ul id="portfolio" class="portfolio">
				<li class="list">
					<div class="container">
						<div class="row last empty">
							등록된 포트폴리오가 없습니다.
						</div>
					</div>
				</li>
			</ul>
		</div>
		<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
			<button onclick="$('#portfolio-list').toggle();" type="button" class="w3-button cancle">닫기</button>
		</div>
	</div>
</div>
<jsp:include page="/resources/include/footer/footer.jsp"/>
</body>
</html>