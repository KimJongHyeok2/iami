<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {
	$("oembed[url]").each(function() {
		 const anchor = document.createElement("a");
		 anchor.setAttribute('href', $(this).attr("url"));
		 anchor.className = 'embedly-card';
		 $(this).css("width", "100%");
		 
		 $(this).append(anchor);
	});

	dateFormat();

	$("#summary").html($("#summary").html().trim().replace(/\n/g, "<br>"));
});
function dateFormat() {
	var dates = new Date($("#start-date").html().replace(/-/g, "/").replace(".0", ""));
	var year = dates.getFullYear();
	var month = dates.getMonth()+1;
	month = (month + "").length == 1? ("0" + month):month;
	var day = dates.getDate();
	day = (day + "").length == 1? ("0" + day):day;
	
	$("#start-date").html(year + "-" + month + "-" + day);
	
	dates = new Date($("#end-date").html().replace(/-/g, "/").replace(".0", ""));
	year = dates.getFullYear();
	month = dates.getMonth()+1;
	month = (month + "").length == 1? ("0" + month):month;
	day = dates.getDate();
	day = (day + "").length == 1? ("0" + day):day;
	
	$("#end-date").html(year + "-" + month + "-" + day);
	
	dates = new Date($("#regdate").html().replace(/-/g, "/").replace(".0", ""));
	year = dates.getFullYear();
	month = dates.getMonth()+1;
	month = (month + "").length == 1? ("0" + month):month;
	day = dates.getDate();
	day = (day + "").length == 1? ("0" + day):day;
	var hour = dates.getHours();
	hour = (hour + "").length == 1? ("0" + hour):hour;
	var minute = dates.getMinutes();
	minute = (minute + "").length == 1? ("0" + minute):minute;
	
	$("#regdate").html(year + "-" + month + "-" + day + " " + hour + ":" + minute);
}
function openRecomment(no) {
	$("#recomment-write-" + no).toggle();
	$("#recomment-list-" + no).toggle();
}
function openCommentDropdown(no) {
	$("#comment-dropdown-" + no).toggle();
}
function openReCommentDropdown(no) {
	$("#recomment-dropdown-" + no).toggle();
}
</script>
<style>
.viewWrapper {
	margin: 0 10px;
}
hr {
	margin: 16px 0;
}
.subject {
	margin-top: 10px;
}
.dev-list {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.dev-list h5 {
	font-weight: normal;
}
.dev-list .dev-list-content {
	list-style-type: none;
	margin: 0;
	overflow: hidden;	
}
.dev-list .dev-list-content .start, .end {
	position: relative;
}
.dev-list .dev-list-content .date-badge {
	position: absolute;
	top: 0;
	left: -27px;
	font-size: 8pt;
}
.dev-list .dev-list-content .date-badge.start {
	padding: 1px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 5px;
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.dev-list .dev-list-content .date-badge.end {
	padding: 1px;
	border: 1px solid rgba(204, 61, 61, 0.4);
	border-radius: 5px;
	background-color: rgba(204, 61, 61, 0.4);
	color: white;
}
.dev-list .dev-list-content .start, .end #start-date, #end-date {
	padding-left: 3px;
}
.dev-list .row {
	margin: 0;
	margin-bottom: 10px;
	box-sizing: border-box;
	list-style-type: none;
	overflow: hidden;
}
.dev-list .row li {
	width: 100%;
}
.margin-title {
	margin-top: 5px;
}
.environment-title div {
	display: inline-block;
	vertical-align: middle;
	text-align: center;
}
.environment-title .btn-add {
	display: none;
	width: 25px;
	margin-left: 5px;
	border: 1px solid rgba(17, 135, 207, 0.4) !important;
	background-color: rgba(17, 135, 207, 0.4) !important;
	color: white !important;
	cursor: pointer;
}
.environment-input {
	margin-top: 7.5px;
}
.environment-input .container {
	max-width: 100% !important;
	padding: 0 !important;
}
.environment-input .container .row {
	margin: 0 !important;
}
.environment-input .container .row .empty {
	padding: 30px;
	text-align: center;
	border: 1px solid #D5D5D5;
}
.environment-input .container .row .margin-card {
	margin-right: 5px;
}
.environment-input .container .row .dev-card {
	border: 1px solid rgba(17, 135, 207, 0.4);
}
#dem_environment, #git_environment .dev-card {
	cursor: pointer;
}
.container .dev-card {
	position: relative;
	padding: 5px;
	border: 1px solid #D5D5D5;
}
.container .card-box.select .dev-card {
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.container .dev-card:hover {
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.container .dev-card div {
	display: inline-block;
	vertical-align: middle;
}
.container .dev-card div.api {
	display: block;
	vertical-align: inherit;
	text-align: center;
}
.container .dev-card .dev-card-img {
	width: 50px;
	height: 50px;
}
.container .dev-card .dev-card-img img {
	width: 100%;
	height: 100%;
}
.container .dev-card .dev-card-text {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
.container .dev-card .fa-check {
	display: none;
	position: absolute;
	top: 0;
	right: 0;
	padding: 0;
	color: rgba(17, 135, 207, 0.4);
}
.container .dev-card .fa-link, .fa-github-square {
	color: rgba(17, 135, 207, 0.4);
}
.recommend-box {
	text-align: center;
	margin-bottom: 10px;
}
.recommend-box button {
	border: 1px solid rgba(17, 135, 207, 0.4) !important;
	color: rgba(17, 135, 207, 0.4) !important;
}
.profile-box {
	margin-bottom: 10px;
}
.profile-box .profile-inner {
	display: flex;
	align-items: center;
	margin: 0 10px;
	padding: 10px;
	border: 1px solid #D5D5D5;
	background-color: rgba(246, 246, 246, 0.4);
}
.profile-box .profile-inner .profile-image {
	position: relative;
}
.profile-box .profile-inner .profile-image .badge {
	position: absolute;
	top: 0;
	left: 0;
	padding: 1px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 5px;
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.profile-box .profile-inner .profile-image .profile {
	width: 70px;
	height: 70px;
}
.profile-box .profile-inner .profile-content {
	padding-left: 5px;
}
.profile-box .profile-inner .profile-content i {
	color: rgba(17, 135, 207, 0.4);
}
.profile-box .profile-inner .profile-content .content-1 .nickname {
	font-size: 13pt;
	font-weight: bold;
}
.profile-box .profile-inner .profile-content .content-1 .id {
	color: gray;
}
.profile-box .profile-inner .profile-content .content-2 .email {
	padding: 1px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 5px;
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
	font-size: 10pt;
}
.profile-box .profile-inner .profile-content .content-3 .regdate {
	padding: 1px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 5px;
	background-color: rgba(17, 135, 207, 0.4);
	font-size: 10pt;
	color: white;
}
.comment-title {
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 5px;
}
.comment-title i {
	color: rgba(17, 135, 207, 0.4); 
}
.comment-title .w3-badge {
	background-color: rgba(17, 135, 207, 0.4); 
}
.comment-write {
	margin-left: 10px;
	margin-bottom: 10px;
}
.comment-write .row {
	margin: 0;
}
.comment-write .row input {
	width: 100%;
	height: 35px;
	padding: 5px;
	border: 1px solid #D5D5D5;
}
.comment-write .row .nonmember-nickname {
	padding: 0;
}
.comment-write .row .nonmember-password {
	padding: 0;
}
.comment-write .row .wrapper {
	margin-right: 10px;
}
.comment-write .comment-write-input {
	display: flex;
	margin-top: 5px;
	margin-right: 10px;
}
.comment-write .comment-write-input textarea {
	flex-grow: 1;
	padding: 5px;
	height: 80px;
	border: 1px solid #D5D5D5;
}
.comment-write .comment-write-input button {
	width: 100px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.comment-write .comment-write-input-m {
	display: none;
	margin-top: 5px;
	margin-right: 10px;
}
.comment-write .comment-write-input-m #btn-comment-write-m {
	width: 100%;
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.recomment-write {
	display: none;
	margin-top: 5px;
}
.recomment-write .row {
	margin: 0;
}
.recomment-write .row input {
	width: 100%;
	height: 35px;
	padding: 5px;
	border: 1px solid #D5D5D5;
}
.recomment-write .row .nonmember-nickname {
	padding: 0;
}
.recomment-write .row .nonmember-password {
	padding: 0;
}
.recomment-write .row .nonmember-nickname .wrapper {
	margin-right: 5px;
}
.recomment-write .row .nonmember-password .wrapper {
	margin-left: 5px;
}
.recomment-write .recomment-write-input {
	margin-top: 5px;
}
.recomment-write .recomment-write-input textarea {
	width: 100%;
	padding: 5px;
	height: 80px;
	border: 1px solid #D5D5D5;
}
.recomment-write .recomment-write-button {
	display: flex;
	justify-content: space-between;
}
.recomment-write .recomment-write-button button {
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.comment-list {
	list-style-type: none;
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
	padding: 0;
	overflow: hidden;
}
.comment-list .comment {
	display: flex;
	min-height: 100px;
	padding: 10px;
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.comment-list .comment .comment-profile .profile {
	width: 50px;
	height: 50px;
}
.comment-list .comment .comment-content {
	padding: 10px;
	flex-grow: 1;
}
.comment-list .comment .comment-content .nickname {
	font-size: 13pt;
	font-weight: bold;
}
.comment-list .comment .comment-content .id {
	padding-right: 5px;
	color: gray;
}
.comment-list .comment .comment-content .regdate {
	color: gray;
	font-size: 10pt;
}
.comment-list .comment .comment-content .regdate-m {
	display: none;
}
.comment-list .comment .comment-content .content {
	margin-top: 5px;
	word-break: break-all;
	word-wrap: break-word;
}
.comment-list .comment .comment-content .function {
	margin-top: 5px;
}
.comment-list .comment .comment-ellipsis {
	position: relative;
	padding: 10px;
}
.comment-list .comment .comment-ellipsis i {
	color: gray;
	text-align: center;
	cursor: pointer;
}
.comment-list .comment .comment-ellipsis .dropdown {
	display: none;
	list-style-type: none;
	position: absolute;
	left: -1px;
	margin: 0;
	padding: 0;
	border: 1px solid #D5D5D5;
}
.comment-list .comment .comment-ellipsis .dropdown li {
	padding: 5px;
}
.comment-list .comment .comment-ellipsis .dropdown li i:hover {
	color: rgba(17, 135, 207, 0.4);
}
.comment-list .comment .comment-content .function button {
	width: 70px;
	height: 30px;
	padding: 0;
}
.comment-list .recomment-lists {
	display: none;
}
.comment-list .recomment-list {
	list-style-type: none;
	margin: 0;
	margin-top: 5px;
	padding: 0;
	overflow: hidden;
}
.comment-list .recomment-list .recomment {
	display: flex;
	min-height: 100px;
}
.comment-list .recomment-list .recomment .recomment-arrow {
	padding: 10px;
}
.comment-list .recomment-list .recomment .recomment-arrow i {
	color: rgba(17, 135, 207, 0.4);
}
.comment-list .recomment-list .recomment .recomment-box {
	display: flex;
	flex-grow: 1;
	padding: 10px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(246, 246, 246, 0.3);
}
.comment-list .recomment-list .recomment .recomment-box .recomment-profile .profile {
	width: 50px;
	height: 50px;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content {
	padding: 10px;
	flex-grow: 1;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .nickname {
	font-size: 13pt;
	font-weight: bold;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .id {
	padding-right: 5px;
	color: gray;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .regdate {
	color: gray;
	font-size: 10pt;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .regdate-m {
	display: none;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .content {
	margin-top: 5px;
	word-break: break-all;
	word-wrap: break-word;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis {
	position: relative;
	padding: 10px;
	text-align: center;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis i {
	color: gray;
	cursor: pointer;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis .dropdown {
	display: none;
	list-style-type: none;
	position: absolute;
	left: 0;
	margin: 0;
	padding: 0;
	border: 1px solid #D5D5D5;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis .dropdown li {
	padding: 5px;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis .dropdown li i:hover {
	color: rgba(17, 135, 207, 0.4);
}
figure {
	margin-bottom: 0;
}
figure .embedly-card-hug {
	max-width: 1000px !important;
	margin: 0 !important;
}
figure .embedly-card-hug iframe {
	width: 100% !important;
}
@media (max-width:767px) {
	.margin-top {
		margin-top: 0 !important;
	}
	.margin-card {
		margin-right: 0 !important;
		margin-bottom: 5px !important;
	}
	.last {
		margin-bottom: 5px !important;
	}
	#btn-comment-write {
		display: none;
	}
	.comment-write .comment-write-input-m {
		display: block;
	}
	.recomment-write .row .nonmember-nickname .wrapper {
		margin-right: 0;
	}
	.recomment-write .row .nonmember-password .wrapper {
		margin-left: 0;
	}
}
@media (max-width:438px) {
	.comment-list .comment .comment-content .regdate {
		display: none;
	}
	.comment-list .comment .comment-content .regdate-m {
		display: block;
	}
	.comment-list .comment .comment-content .regdate-m .regdate.m {
		display: block;
	}
	.comment-list .recomment-list .recomment .recomment-box .recomment-content .regdate {
		display: none;
	}
	.comment-list .recomment-list .recomment .recomment-box .recomment-content .regdate-m {
		display: block;
	}
	.comment-list .recomment-list .recomment .recomment-box .recomment-content .regdate-m .regdate.m {
		display: block;
	}
}
</style>
<script async charset="utf-8" src="//cdn.embedly.com/widgets/platform.js"></script>
<div class="viewWrapper">
	<div class="subject">
		<h2>${portfolio.pot_subject}</h2>
	</div>
	<div class="description">
		${portfolio.pot_description}
	</div>
	<hr>
	<ul class="dev-list">
		<li><h5>개발기간</h5></li>
		<li>
			<ul class="dev-list-content">
				<li class="start">
					<span class="date-badge start">시작</span>
					<span id="start-date">${portfolio.pot_startdate}</span>
				</li>
				<li class="end">
					<span class="date-badge end">종료</span>
					<span id="end-date">${portfolio.pot_enddate}</span>
				</li>
			</ul>
		</li>
	</ul>
	<ul class="dev-list w3-margin-top">
		<li><h5>주요기능</h5></li>
		<li>
			<ul class="dev-list-content">
				<li id="summary">
					${portfolio.pot_summary}
				</li>
			</ul>
		</li>
	</ul>
	<ul class="dev-list w3-margin-top">
		<li><h5>주요환경</h5></li>
		<li>
			<ul class="row">
				<li>
					${portfolio.pot_environment}		
				</li>
			</ul>
		</li>
	</ul>
<ul class="dev-list w3-margin-top">
	<li><h5>동영상</h5></li>
	<li>
		<ul class="dev-list-content">
			<li>
				${portfolio.pot_video}
			</li>
		</ul>
	</li>
</ul>
<ul class="dev-list w3-margin-top">
	<li><h5>Demo / GitHub</h5></li>
	<li>
		<ul class="row">
			<li>
				${portfolio.pot_source}
			</li>
		</ul>
	</li>
</ul>
</div>
<div class="recommend-box">
	<button id="btn-next" class="w3-button w3-white w3-border"><i class="far fa-thumbs-up"></i> <span>0</span></button>
</div>
<div class="profile-box">
	<div class="profile-inner">
		<div class="profile-image">
			<span class="badge">작성자</span>
			<img class="profile" src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
		</div>
		<div class="profile-content">
			<div class="content-1">
				<span class="nickname">${portfolio.mem_nickname}</span><span class="id">(${portfolio.mem_id})</span>
			</div>
			<div class="content-2">
				<i class="fas fa-envelope"></i> <span class="email">${portfolio.mem_email}</span>
			</div>
			<div class="content-3">
				<i class="fas fa-clock"></i> <span id="regdate" class="regdate">${portfolio.pot_regdate}</span>
			</div>
		</div>
	</div>
</div>
<div class="comment-title">
	<i class="far fa-comments"></i> 댓글 <span class="w3-badge">8</span>
</div>
<div class="comment-write">
	<div class="comment-write-nonmember">
		<div class="row">
			<div class="nonmember-nickname col-md-6">
				<div class="wrapper">
					<div>닉네임</div>
					<input type="text"/>
				</div>
			</div>
			<div class="nonmember-password col-md-6">
				<div class="wrapper">
					<div>비밀번호</div>
					<input type="text"/>
				</div>
			</div>
		</div>
	</div>
	<div class="comment-write-input">
		<textarea placeholder="내용을 입력해주세요."></textarea>
		<button id="btn-comment-write" class="w3-button">작성</button>
	</div>
	<div class="comment-write-input-m">
		<button id="btn-comment-write-m" class="w3-button">작성</button>
	</div>
</div>
<ul class="comment-list">
	<li class="comment">
		<div class="comment-profile">
			<img class="profile" src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
		</div>
		<div class="comment-content">
			<span class="nickname">테스트</span><span class="id">(test13585)</span><span class="regdate">2019-05-16 02:36</span>
			<div class="regdate-m">
				<span class="regdate m">2019-05-16 02:36</span>
			</div>
			<div class="content">
				테스트입니다.
			</div>
			<div class="function">
				<button class="w3-button w3-white w3-border" onclick="openRecomment(1);">답글 (<span>0</span>)</button>
				<div id="recomment-write-1" class="recomment-write">
					<div class="recomment-write-nonmember">
						<div class="row">
							<div class="nonmember-nickname col-md-6">
								<div class="wrapper">
									<div>닉네임</div>
									<input type="text"/>
								</div>
							</div>
							<div class="nonmember-password col-md-6">
								<div class="wrapper">
									<div>비밀번호</div>
									<input type="text"/>
								</div>
							</div>
						</div>
					</div>
					<div class="recomment-write-input">
						<textarea placeholder="내용을 입력해주세요."></textarea>
					</div>
					<div class="recomment-write-button">
						<button class="w3-button">취소</button>
						<button id="btn-recomment-write" class="w3-button">작성</button>
					</div>
				</div>
			</div>
		</div>
		<div class="comment-ellipsis">
			<i class="fas fa-ellipsis-v" onclick="openCommentDropdown(1);"></i>
			<ul id="comment-dropdown-1" class="dropdown">
				<li><i class="fas fa-pen"></i></li>
				<li><i class="fas fa-trash-alt"></i></li>
			</ul>
		</div>
	</li>
	<li id="recomment-list-1" class="recomment-lists">
		<ul class="recomment-list">
			<li class="recomment">
				<div class="recomment-arrow">
					<i class="fas fa-location-arrow fa-2x"></i>
				</div>
				<div class="recomment-box">
					<div class="recomment-profile">
						<img class="profile" src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
					</div>
					<div class="recomment-content">
						<span class="nickname">테스트</span><span class="id">(test13585)</span><span class="regdate">2019-05-16 02:36</span>
						<div class="regdate-m">
							<span class="regdate m">2019-05-16 02:36</span>
						</div>
						<div class="content">
							안녕입니다.
						</div>
					</div>
					<div class="recomment-ellipsis">
						<i class="fas fa-ellipsis-v" onclick="openReCommentDropdown(1);"></i>
						<ul id="recomment-dropdown-1" class="dropdown">
							<li><i class="fas fa-trash-alt"></i></li>
						</ul>
					</div>
				</div>
			</li>
		</ul>
	</li>
</ul>