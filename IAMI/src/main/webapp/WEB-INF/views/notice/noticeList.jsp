<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<script>
$(document).ready(function() {
	resize_noticeList();
	noticeDateFormat();
});
$(window).resize(resize_noticeList);
function resize_noticeList() {
	$htmlHeight = $("html").height();
	$headerHeight = $(".headerWrapper").height();
	$navHeight = $(".navWrapper").height();
	$footerHeight = $(".footerWrapper").height();
	
	$(".container-fluid .noticeWrapper").css("min-height", $htmlHeight - $headerHeight - $navHeight - $footerHeight - 61 + "px");
}
function noticeDateFormat() {
	var noticeLength = "${fn:length(list)}"; 
	
	for(var i=0; i<noticeLength; i++) {
		var dates = new Date($("#notice-regdate-" + (i+1)).html().trim().replace(/-/g, "/").replace(".0", ""));
		var year = dates.getFullYear();
		var month = dates.getMonth()+1;
		month = (month + "").length == 1? ("0" + month):month;
		var day = dates.getDate();
		day = (day + "").length == 1? ("0" + day):day;
		
		$("#notice-regdate-" + (i+1)).html(year + "-" + month + "-" + day);
		$("#notice-regdate-m-" + (i+1)).html(year + "-" + month + "-" + day);
	}
}
function view(no) {
	location.href = "notice/view/" + no;
}
function page(page) {
	location.href = "?page=" + page + "&noticeType=${noticeType}";
}
function noticeType_list_nav(type) {
	location.href = "?page=1&noticeType=" + type;
}
function search() {
	var searchValue = $("#notice-search-input").val();
	var searchType = $("#notice-search-select option:selected").val();
	
	if(searchValue == null || searchValue.length == 0) {
		alert("검색할 단어를 입력해주세요.");
		return false;
	}
	
	searchValue = urlEncode(searchValue);
	
	location.href = "?noticeType=${noticeType}&searchType=" + searchType + "&searchValue=" + searchValue;	
}
function searchOn() {
	if(event.keyCode == 13) {
		search();
	}
}
function urlEncode(str) {
    str = (str + '').toString();
    return encodeURIComponent(str)
        .replace(/!/g, '%21')
        .replace(/'/g, '%27')
        .replace(/\(/g, '%28')
        .replace(/\)/g, '%29')
        .replace(/\*/g, '%2A')
        .replace(/%20/g, '+');
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/noticeList.css">
<div class="noticeWrapper">
	<div class="noticeInner">
		<div class="noticeInner-wrapper">
		<div class="notice-title">
			공지사항
		</div>
		<div class="notice-title-sub">
			<span class="site-name">IAMI</span>의 새로운 소식을 전해드립니다.
		</div>
		<div class="notice-tab">
			<div class="w3-button ${empty noticeType || noticeType == 'all'? 'normalActive':''}" onclick="noticeType_list_nav('all');">전체</div>
			<div class="w3-button ${noticeType == 'normal'? 'normalActive':''}" onclick="noticeType_list_nav('normal');">일반</div>
			<div class="w3-button last ${noticeType == 'event'? 'eventActive':''}" onclick="noticeType_list_nav('event');">이벤트</div>
		</div>
		<div class="notice-content">
			<ul class="notice-content-inner">
				<li id="notice-title" class="notice-content-title">
					<div class="number">번호</div>
					<div class="type"></div>
					<div class="subject">제목</div>
					<div class="regdate">등록일</div>
					<div class="viewCount">조회수</div>
				</li>
				<c:choose>
					<c:when test="${not empty list && fn:length(list) != 0}">
						<c:forEach var="i" items="${list}" varStatus="index">
							<li class="notice-content-list">
								<div class="list-inner">
									<div class="number">
										${i.cnc_no}
									</div>
									<div class="type">
										<c:if test="${i.cnc_type == 1}">
											<div class="normal">일반</div>
										</c:if>
										<c:if test="${i.cnc_type == 2}">
											<div class="event">이벤트</div>
										</c:if>
									</div>
									<div class="subject-box">
										<div class="subject" onclick="view(${i.cnc_no});">
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
									<div id="notice-regdate-${index.count}" class="regdate">
										${i.cnc_regdate}
									</div>
									<div class="viewCount">
										${i.cnc_viewcount}
									</div>
								</div>
								<div class="list-inner m">
									<span id="notice-regdate-m-${index.count}" class="regdate-m">${i.cnc_regdate}</span> <span class="viewCount-m">조회 <span class="count">${i.cnc_viewcount}</span></span>
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
		<s:authorize access="hasRole('ROLE_ADMIN')">
			<div class="notice-function">
				<div class="w3-button btn-write" onclick="location.href='${pageContext.request.contextPath}/notice/write'">
					작성하기
				</div>
			</div>
		</s:authorize>
		<div class="notice-pagination">
			<ul class="pagination-box">
				<c:if test="${startPage > pageBlock}">
					<li class="prev" onclick="page(${startPage - 10})">
						<i class='fas fa-chevron-left'></i>
					</li>
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:choose>
						<c:when test="${i == page}">
							<li class="active ${i==endPage? 'pagination-last':''}">${i}</li>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${i == endPage}">
									<li class="pagination-last" onclick="page(${i});">${i}</li>
								</c:when>
								<c:otherwise>
									<li onclick="page(${i});">${i}</li>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					<li class="next pagination-last" onclick="page(${startPage + 10})">
						<i class='fas fa-chevron-right'></i>
					</li>
				</c:if>
			</ul>
		</div>
		<div class="notice-search">
			<div class="search-box">
				<select id="notice-search-select">
					<option value="1">제목</option>
				</select>
				<input id="notice-search-input" type="text" onkeyup="searchOn();"/><div class="w3-button btn-search" onclick="search();">검색</div>
			</div>
		</div>
	</div>
	</div>
</div>