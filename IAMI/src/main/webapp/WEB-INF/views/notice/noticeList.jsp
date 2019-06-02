<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<script>
$(document).ready(function() {
	resize();
});
$(window).resize(resize);
function resize() {
	$htmlHeight = $("html").height();
	$headerHeight = $(".headerWrapper").height();
	$navHeight = $(".navWrapper").height();
	$footerHeight = $(".footerWrapper").height();
	
	$(".container-fluid .noticeWrapper").css("min-height", $htmlHeight - $headerHeight - $navHeight - $footerHeight - 61 + "px");
}
</script>
<style>
.noticeWrapper {
	display: flex;
	align-items: center;
	margin: 10px 0;
}
.noticeWrapper .noticeInner {
	flex-grow: 1;
	max-width: 800px;
}
.noticeWrapper .noticeInner .notice-title {
	font-size: 25pt;
	font-weight: bold;
	text-align: center;
}
.noticeWrapper .noticeInner .notice-title-sub {
	color: gray;
	text-align: center;
}
.noticeWrapper .noticeInner .notice-tab {
	display: flex;
	margin-top: 5px;
}
.noticeWrapper .noticeInner .notice-tab div {
	margin-right: 3px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 5px;
	color: rgba(17, 135, 207, 0.7);
}
.noticeWrapper .noticeInner .notice-tab .last {
	margin-right: 0;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner {
	list-style-type: none;
	margin: 0;
	margin-top: 3px;
	padding: 0;
	border-top: 2px solid rgba(17, 135, 207, 0.4);
	border-bottom: 1px solid rgba(17, 135, 207, 0.4);
	overflow: hidden;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .number {
	width: 50px;
	padding: 5px;
	text-align: center;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .type {
	width: 45px;
	padding: 5px;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .type .normal {
	border: 1px solid #B7F0B1;
	border-radius: 5px;
	background-color: #B7F0B1;
	color: white;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .subject {
	padding: 5px;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .regdate {
	width: 100px;
	padding: 5px;
	text-align: center;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .viewCount {
	width: 70px;
	padding: 5px;
	text-align: center;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-title {
	display: flex;
	border-bottom: 1px solid rgba(17, 135, 207, 0.4);
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-title .subject {
	flex-grow: 1;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list {
	border-bottom: 1px dotted #EAEAEA;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .list-inner {
	display: flex;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .list-inner.m {
	display: none;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list.last {
	border-bottom: none;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list:hover {
	background-color: rgba(246, 246, 246, 0.4);	
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .subject-box {
	display: flex;
	align-items: center;
	flex-grow: 1;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .subject-box div {
	padding: 5px;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .subject-box .subject {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	cursor: pointer;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .subject-box .subImage {
	padding: 0;
	color: rgba(17, 135, 207, 0.4);
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .regdate {
	color: gray;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .viewCount {
	color: gray;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .regdate-m {
	padding: 0 5px;	
	font-size: 10pt;
	color: gray;
}
.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .viewCount-m {
	font-size: 10pt;
	color: gray;
}
.noticeWrapper .noticeInner .notice-function {
	margin-top: 5px;
}
.noticeWrapper .noticeInner .notice-function {
	text-align: right;
}
.noticeWrapper .noticeInner .notice-function .btn-write {
	border: 1px solid rgba(17, 135, 207, 0.4);
	color: rgba(17, 135, 207, 0.7);
}
.noticeWrapper .noticeInner .notice-pagination {
	margin-top: 5px;
}
.noticeWrapper .noticeInner .notice-pagination .pagination-box {
	display: flex;
	justify-content: center;
	list-style-type: none;
	margin: 0;
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
	padding: 0;
	overflow: hidden;
}
.noticeWrapper .noticeInner .notice-pagination .pagination-box li {
	min-width: 30px;
	padding: 3px;
	text-align: center;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-right: none;
	background-color: white;
	color: rgba(17, 135, 207, 0.4);
	cursor: pointer;
}
.noticeWrapper .noticeInner .notice-pagination .pagination-box li:hover {
	background-color: rgba(246, 246, 246, 0.5);
}
.noticeWrapper .noticeInner .notice-pagination .pagination-box li.pagination-last {
	border-right: 1px solid rgba(17, 135, 207, 0.4);
}
.noticeWrapper .noticeInner .notice-pagination .pagination-box li.active {
	border: 1px solid transparent;
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
	cursor: default;
}
.noticeWrapper .noticeInner .notice-pagination .pagination-box li.next {
	border-left: none;
}
.noticeWrapper .noticeInner .notice-search {
	margin-top: 5px;
}
.noticeWrapper .noticeInner .notice-search .search-box {
	display: flex;
	max-width: 310px;
	margin: auto;
}
.noticeWrapper .noticeInner .notice-search .search-box select {
	margin-right: 5px;
	border: 1px solid #D5D5D5;
}
.noticeWrapper .noticeInner .notice-search .search-box input {
	flex-grow: 1;
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.noticeWrapper .noticeInner .notice-search .search-box .btn-search {
	padding: 10px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-left: none;
	color: rgba(17, 135, 207, 0.7);
}
@media (max-width:1000px) {
 	.noticeWrapper .noticeInner .notice-content .notice-content-inner .subject {
		flex-grow: unset;
		width: 400px;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-title .subject {
		flex-grow: unset;
		width: 400px;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .subject-box {
		flex-grow: unset;
		width: 400px;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .subject-box .subImage {
		width: 50px;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .regdate {
		flex-grow: 1;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .viewCount {
		flex-grow: 1;
	}
}
@media (max-width:800px) {
 	.noticeWrapper .noticeInner .notice-content .notice-content-inner .subject {
		flex-grow: unset;
		width: 200px;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-title .subject {
		flex-grow: unset;
		width: 200px;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .subject-box {
		flex-grow: unset;
		width: 200px;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .subject-box .subImage {
		width: 50px;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .regdate {
		flex-grow: 1;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .viewCount {
		flex-grow: 1;
	}
	.noticeWrapper .noticeInner {
		max-width: 500px;
	}
	.noticeWrapper .noticeInner .noticeInner-wrapper {
		margin: 0 10px;
	}
}
@media (max-width:500px) {
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .number, .viewCount {
		display: none;
	}
}
@media (max-width:370px) {
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .regdate {
		display: none;
	}
	#notice-search {
		flex-grow: unset;
		width: 100px;
	}
	#notice-title {
		display: none;
	}
	.noticeWrapper .noticeInner .notice-search .search-box {
		justify-content: center;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .list-inner.m {
		display: flex;
	}
 	.noticeWrapper .noticeInner .notice-content .notice-content-inner .subject {
		flex-grow: 1;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-title .subject {
		flex-grow: 1;
	}
	.noticeWrapper .noticeInner .notice-content .notice-content-inner .notice-content-list .subject-box {
		flex-grow: 1;
	}
}
</style>
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
			<div class="w3-button">전체</div>
			<div class="w3-button">일반</div>
			<div class="w3-button last">이벤트</div>
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
				<li class="notice-content-list">
					<div class="list-inner">
						<div class="number">
							1
						</div>
						<div class="type">
							<span class="normal">일반</span>
						</div>
						<div class="subject-box">
							<div class="subject">
								제목입니다.
							</div>
							<div class="subImage">
								<i class="fas fa-image"></i> <i class="fab fa-youtube"></i>
							</div>
						</div>
						<div class="regdate">
							2019-06-07
						</div>
						<div class="viewCount">
							1
						</div>
					</div>
					<div class="list-inner m">
						<span class="regdate-m">2019-06-01</span> <span class="viewCount-m">조회 <span class="count">1</span></span>
					</div>
				</li>
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
				<li class="active">1</li>
			</ul>
		</div>
		<div class="notice-search">
			<div class="search-box">
				<select>
					<option>제목</option>
				</select>
				<input id="notice-search" type="text"/><div class="w3-button btn-search">검색</div>
			</div>
		</div>
	</div>
	</div>
</div>