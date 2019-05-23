<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	$(".row").find(".regdate").each(function() {
		var dates = new Date($(this).html().trim().replace(/-/g, "/").replace(".0", ""));
		var year = dates.getFullYear();
		var month = dates.getMonth()+1;
		month = (month + "").length == 1? ("0" + month):month;
		var day = dates.getDate();
		day = (day + "").length == 1? ("0" + day):day;
		var hour = dates.getHours();
		hour = (hour + "").length == 1? ("0" + hour):hour;
		var minute = dates.getMinutes();
		minute = (minute + "").length == 1? ("0" + minute):minute;
		
		$(this).html(year + "-" + month + "-" + day + " " + hour + ":" + minute);
	});
});
function view(no) {
	location.href = "${pageContext.request.contextPath}/portfolio/view/" + no;
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
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
							<span class="rank ${type=='popular'? 'on':''}">${i.rnum}</span><i class="fas fa-comments"></i> <span>${i.commentCount}</span> <i class="fas fa-thumbs-up"></i> <span>${i.pot_recommend}</span>
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