<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
function view(no) {
	location.href = "${pageContext.request.contextPath}/portfolio/view/" + no;
}
</script>
<style>
.list-title {
	margin-top: 10px;
	margin-left: 10px;
	margin-bottom: 0;
}
.row {
	margin: 0;
	margin-bottom: 10px;
	padding-left: 10px;
	list-style-type: none;
	overflow: hidden;
	box-sizing: border-box;
}
.row .empty-list {
	width: 100%;
	text-align: center;
	padding: 30px 0;
}
.row .portfolio-card-box {
	padding: 0;
	cursor: pointer;
}
.row .portfolio-card-box .portfolio-card {
	margin-top: 10px;
	margin-right: 10px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-top: 3px solid rgba(17, 135, 207, 0.4);
}
.row .portfolio-card-box .portfolio-card:hover {
	border: 1px solid rgba(17, 135, 207, 0.8);
	border-top: 3px solid rgba(17, 135, 207, 0.8);
}
.row .portfolio-card-box .portfolio-card .thumbnail {
	position: relative;
	border-bottom: 1px solid rgba(17, 135, 207, 0.4);
}
.row .portfolio-card-box .portfolio-card .thumbnail .img {
	width: 100%;
	height: 250px;
}
.row .portfolio-card-box .portfolio-card .thumbnail .icon-box {
	position: absolute;
	top: 0;
	right: 0;
	color: rgba(17, 135, 207, 0.4);
}
.row .portfolio-card-box .portfolio-card .subject {
	padding: 5px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
.row .portfolio-card-box .portfolio-card .ohter {
	display: flex;
	justify-content: space-between;
	padding: 5px;
}
.row .portfolio-card-box .portfolio-card .ohter .regdate {
	color: gray;
}
.row .portfolio-card-box .portfolio-card .ohter .recommend .w3-badge {
	background-color: rgba(17, 135, 207, 0.4) !important;
}
.row .btn-box {
	display: none;
	width: 100%;
	margin-top: 10px;
	margin-right: 10px;
}
.row .btn-box .btn-more {
	width: 100%;
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
</style>
<h3 class="list-title">
	<c:if test="${type == 'new'}">
		최신순
	</c:if>
	<c:if test="${type == 'popular'}">
		인기순
	</c:if>
</h3>
<ul class="row">
<c:choose>
	<c:when test="${not empty list && fn:length(list) != 0}">
		<c:forEach var="i" items="${list}">
			<li class="portfolio-card-box col-12 col-sm-6 col-md-4 col-lg-3" onclick="view(${i.pot_no});">
				<div class="portfolio-card">
					<div class="thumbnail">
						<img class="img" src="${pageContext.request.contextPath}/resources/upload/${i.pot_thumbnail}"/>
						<div class="icon-box">
							<i class="fas fa-link"></i>
							<i class="fab fa-github-square"></i>
						</div>
					</div>
					<div class="subject">
						${i.pot_subject}
					</div>
					<div class="ohter">
						<div class="regdate">
							${i.pot_regdate}
						</div>
						<div class="recommend">
							<span class="w3-badge w3-red">${i.pot_recommend}</span>
						</div>
					</div>
				</div>
			</li>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<li class="empty-list">
			등록된 포트폴리오가 없습니다.
		</li>
	</c:otherwise>
</c:choose>
	<li class="btn-box">
		<button class="w3-button btn-more">더 보기</button>
	</li>
</ul>