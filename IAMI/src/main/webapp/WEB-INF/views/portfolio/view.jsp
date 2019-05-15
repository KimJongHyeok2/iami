<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {
	$(".btn-add").remove();
});
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
	left: -25px;
	font-size: 8pt;
}
.dev-list .dev-list-content .date-badge.start {
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 5px;
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.dev-list .dev-list-content .date-badge.end {
	border: 1px solid rgba(204, 61, 61, 0.4);
	border-radius: 5px;
	background-color: rgba(204, 61, 61, 0.4);
	color: white;
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
.container .dev-card {
	position: relative;
	padding: 5px;
	border: 1px solid #D5D5D5;
	cursor: pointer;
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
	border: 1px solid rgba(17, 135, 207, 0.4) !important;
	background-color: rgba(17, 135, 207, 0.4) !important;
	color: white !important;
}
.recomment-write {
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
	border: 1px solid rgba(17, 135, 207, 0.4) !important;
	background-color: rgba(17, 135, 207, 0.4) !important;
	color: white !important;
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
	color: rgba(17, 135, 207, 0.5);
	padding-right: 5px;
}
.comment-list .comment .comment-content .regdate {
	color: gray;
	font-size: 10pt;
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
	padding: 10px;
}
.comment-list .comment .comment-ellipsis i {
	color: gray;
	text-align: center;
	cursor: pointer;
}
.comment-list .comment .comment-content .function button {
	width: 70px;
	height: 30px;
	padding: 0;
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
	color: rgba(17, 135, 207, 0.5);
	padding-right: 5px;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .regdate {
	color: gray;
	font-size: 10pt;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .content {
	margin-top: 5px;
	word-break: break-all;
	word-wrap: break-word;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis {
	padding: 10px;
	text-align: center;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis i {
	color: gray;
	cursor: pointer;
}
@media (max-width:767px) {
	.recomment-write .row .nonmember-nickname .wrapper {
		margin-right: 0;
	}
	.recomment-write .row .nonmember-password .wrapper {
		margin-left: 0;
	}
}
</style>
<div class="viewWrapper">
	<div class="subject">
		<h3>TBP PLACE</h3>
	</div>
	<div class="description">
		중고거래 사이트입니다.
	</div>
	<hr>
	<ul class="dev-list">
		<li><h5>개발기간</h5></li>
		<li>
			<ul class="dev-list-content">
				<li class="start">
				<span class="date-badge start">시작</span>
					2019-05-01
				</li>
				<li class="end">
				<span class="date-badge end">종료</span>
					2019-05-15
				</li>
			</ul>
		</li>
	</ul>
	<ul class="dev-list w3-margin-top">
		<li><h5>주요기능</h5></li>
		<li>
			<ul class="dev-list-content">
				<li>
					Spring Security Custom<br>
					Spring Security Custom<br>
					Spring Security Custom<br>
				</li>
			</ul>
		</li>
	</ul>
	<ul class="dev-list w3-margin-top">
		<li><h5>주요환경</h5></li>
		<li>
			<ul class="row">
				<li>
					<div id="pot_environment" class="environment">
						<div class="environment-title">
							<div>배포환경</div><div class="btn-add" onclick="openModal('war');"><i class="fas fa-plus"></i></div>
						</div>
						<div id="war_environment" class="environment-input">
							<div class="container">
								<div class="row">
									<div class="empty col-12">
										등록이 필요합니다.
									</div>
								</div>
							</div>
						</div>
						<div class="environment-title margin-title">
							<div>개발환경</div><div class="btn-add" onclick="openModal('dev');"><i class="fas fa-plus"></i></div>
						</div>
						<div id="dev_environment" class="environment-input">
							<div class="container">
								<div class="row">
									<div class="empty col-12">
										등록이 필요합니다.
									</div>
								</div>
							</div>
						</div>
						<div class="environment-title margin-title">
							<div>실행환경</div><div class="btn-add" onclick="openModal('run');"><i class="fas fa-plus"></i></div>
						</div>
						<div id="run_environment" class="environment-input">
							<div class="container">
								<div class="row">
									<div class="empty col-12">
										등록이 필요합니다.
									</div>
								</div>
							</div>
						</div>
						<div class="environment-title margin-title">
							<div>언어</div><div class="btn-add" onclick="openModal('lan');"><i class="fas fa-plus"></i></div>
						</div>
						<div id="lan_environment" class="environment-input">
							<div class="container">
								<div class="row">
									<div class="empty col-12">
										등록이 필요합니다.
									</div>
								</div>
							</div>
						</div>
						<div class="environment-title margin-title">
							<div>라이브러리</div><div class="btn-add" onclick="openModal('lib');"><i class="fas fa-plus"></i></div>
						</div>
						<div id="lib_environment" class="environment-input">
							<div class="container">
								<div class="row">
									<div class="empty col-12">
										등록이 필요합니다.
									</div>
								</div>
							</div>
						</div>
						<div class="environment-title margin-title">
							<div>프레임워크</div><div class="btn-add" onclick="openModal('fra');"><i class="fas fa-plus"></i></div>
						</div>
						<div id="fra_environment" class="environment-input">
							<div class="container">
								<div class="row">
									<div class="empty col-12">
										등록이 필요합니다.
									</div>
								</div>
							</div>
						</div>
						<div class="environment-title margin-title">
							<div>데이터베이스</div><div class="btn-add" onclick="openModal('dba');"><i class="fas fa-plus"></i></div>
						</div>
						<div id="dba_environment" class="environment-input">
							<div class="container">
								<div class="row">
									<div class="empty col-12">
										등록이 필요합니다.
									</div>
								</div>
							</div>
						</div>
						<div class="environment-title margin-title">
							<div>사용기술 / API</div><div class="btn-add" onclick="openModal('api');"><i class="fas fa-plus"></i></div>
						</div>
						<div id="api_environment" class="environment-input">
							<div class="container">
								<div class="row">
									<div class="empty col-12">
										등록이 필요합니다.
									</div>
								</div>
							</div>
						</div>
					</div>				
				</li>				
			</ul>
		</li>
	</ul>
<ul class="dev-list w3-margin-top">
	<li><h5>동영상</h5></li>
	<li>
		<ul class="dev-list-content">
			<li>
				동영상
			</li>
		</ul>
	</li>
</ul>
<ul class="dev-list w3-margin-top">
	<li><h5>Demo</h5></li>
	<li>
		<ul class="row">
			<li>
				<div id="dem_environment" class="environment">
					<div id="war_environment" class="environment-input">
						<div class="container">
							<div class="row">
								<div class="empty col-12">
									등록이 필요합니다.
								</div>
							</div>
						</div>
					</div>
				</div>
			</li>
		</ul>
	</li>
</ul>
<ul class="dev-list w3-margin-top">
	<li><h5>GitHub</h5></li>
	<li>
		<ul class="row">
			<li>
				<div id="dem_environment" class="environment">
					<div id="war_environment" class="environment-input">
						<div class="container">
							<div class="row">
								<div class="empty col-12">
									등록이 필요합니다.
								</div>
							</div>
						</div>
					</div>
				</div>
			</li>
		</ul>
	</li>
</ul>
</div>
<div class="recommend-box">
	<button id="btn-next" class="w3-button w3-white w3-border"><i class="far fa-thumbs-up"></i> <span>0</span></button>
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
		<button class="w3-button w3-white w3-border">작성</button>
	</div>
</div>
<ul class="comment-list">
	<li class="comment">
		<div class="comment-profile">
			<img class="profile" src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
		</div>
		<div class="comment-content">
			<span class="nickname">테스트</span><span class="regdate">2019-05-16 02:36</span>
			<div class="content">
				dwqhdwquhwdqiuhdqwuihdqwuidwqhuiwdqhuiwdqhuiwhqdiuhqwduihquiwhdiuwqhdiuqwhouidhwquiohdiuoqwhuiowdqhiouhqwdiouhqwduiohwdqouihwqdiouhdwqdwqdwqdwqdwqqwddqw
			</div>
			<div class="function">
				<button class="w3-button w3-white w3-border">답글 (<span>0</span>)</button>
				<div class="recomment-write">
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
					<button class="w3-button w3-white w3-border">취소</button>
					<button class="w3-button w3-white w3-border">작성</button>
					</div>
				</div>
			</div>
		</div>
		<div class="comment-ellipsis">
			<i class="fas fa-ellipsis-v"></i>
		</div>
	</li>
	<li>
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
						<span class="nickname">테스트</span><span class="regdate">2019-05-16 02:36</span>
						<div class="content">
							안녕입니다.
						</div>
					</div>
					<div class="recomment-ellipsis">
						<i class="fas fa-ellipsis-v"></i>
					</div>
				</div>
			</li>
		</ul>
	</li>
</ul>