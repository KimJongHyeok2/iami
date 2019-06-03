<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<script>
$(document).ready(function() {
	resize();
	noticeDateFormat();
	
	$("oembed[url]").each(function() {
		 const anchor = document.createElement("a");
		 anchor.setAttribute('href', $(this).attr("url"));
		 anchor.className = 'embedly-card';
		 $(this).css("width", "100%");
		 
		 $(this).append(anchor);
	});
});
$(window).resize(resize);
function resize() {
	$htmlHeight = $("html").height();
	$headerHeight = $(".headerWrapper").height();
	$navHeight = $(".navWrapper").height();
	$footerHeight = $(".footerWrapper").height();
	
	$(".container-fluid .noticeWrapper").css("min-height", $htmlHeight - $headerHeight - $navHeight - $footerHeight - 61 + "px");
}
function noticeDateFormat() {
	var dates = new Date($("#notice-regdate").html().trim());
	var year = dates.getFullYear();
	var month = dates.getMonth()+1;
	month = (month + "").length == 1? ("0" + month):month;
	var day = dates.getDate();
	day = (day + "").length == 1? ("0" + day):day;
	var hour = dates.getHours();
	hour = (hour + "").length == 1? ("0" + hour):hour;
	var minute = dates.getMinutes();
	minute = (minute + "").length == 1? ("0" + minute):minute;
		
	$("#notice-regdate").html(year + "-" + month + "-" + day + " " + hour + ":" + minute);
	$("#notice-regdate-m").html(year + "-" + month + "-" + day + " " + hour + ":" + minute);
}
function pageNav(no) {
	location.href = "" + no;
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/noticeView.css">
<script async charset="utf-8" src="//cdn.embedly.com/widgets/platform.js"></script>
<div class="noticeWrapper">
	<div class="noticeInner">
		<div class="noticeInner-wrapper">
		<div class="notice-title">
			공지사항
		</div>
		<div class="notice-title-sub">
			<span class="site-name">IAMI</span>의 새로운 소식을 전해드립니다.
		</div>
		<div class="notice-content">
			<div class="notice-content-header">
				<div class="notice-content-header-inner">
					<div class="type">
						<c:if test="${dto.cnc_type == 1}">
							<div class="normal">일반</div>
						</c:if>
						<c:if test="${dto.cnc_type == 2}">
							<div class="event">이벤트</div>
						</c:if>
					</div>
					<div class="subject">
						${dto.cnc_subject}
					</div>
					<div id="notice-regdate" class="regdate">
						${dto.cnc_regdate}
					</div>
					<div class="viewcount">
						${dto.cnc_viewcount}
					</div>
				</div>
				<div class="notice-content-header-inner-m">
					<div class="notice-content-header-inner-m-box">
						<div id="notice-regdate-m" class="regdate-m">
							${dto.cnc_regdate}
						</div>
						<div class="viewcount-m">
							${dto.cnc_viewcount}
						</div>
					</div>				
				</div>
			</div>
			<div class="notice-content-content">
				${dto.cnc_content}
			</div>
			<div class="notice-content-function">
				<button class="w3-button" onclick="location.href='${pageContext.request.contextPath}/notice'">목록</button>	
				<s:authorize access="hasRole('ROLE_ADMIN')">
					<button class="w3-button" onclick="history.back();">수정</button>	
					<button class="w3-button" onclick="history.back();">삭제</button>	
				</s:authorize>
			</div>
			<div class="notice-content-list-nav">
				<div class="prev">
					<i class="fas fa-chevron-up"></i><div class="list-nav-btn">이전글</div>
					<c:choose>
						<c:when test="${not empty dto.prev_cnc_subject}">
							<div class="list-nav-subject" onclick="pageNav(${dto.prev_cnc_no});">${dto.prev_cnc_subject}</div>
						</c:when>
						<c:otherwise>
							<div class="list-nav-subject empty">이전글이 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="next">
					<i class="fas fa-chevron-down"></i><div class="list-nav-btn">다음글</div>
					<c:choose>
						<c:when test="${not empty dto.next_cnc_subject}">
							<div class="list-nav-subject" onclick="pageNav(${dto.next_cnc_no});">${dto.next_cnc_subject}</div>
						</c:when>
						<c:otherwise>
							<div class="list-nav-subject empty">다음글이 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		</div>
	</div>
</div>