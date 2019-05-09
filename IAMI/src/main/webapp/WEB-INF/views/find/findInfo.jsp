<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function validCheck1(obj) {
	var $nickname = obj["mem_nickname"].value;
	var $email = obj["mem_email"].value;
	var $pattern = /^(([a-zA-Z\d][-_]?){3,15})@([a-zA-z\d]{5,15})\.([a-z]{2,3})$/;
	
	if($nickname == null || $nickname.length == 0) {
		alert("닉네임을 입력해주세요.");
		return false;
	}
	if(!new RegExp($pattern).test($email)) {
		alert("이메일 형식이 올바르지 않습니다.");
		return false;
	}
	
	$(obj).find("button").html("<div class='spinner-border text-light'></div>");
}
function validCheck2(obj) {
	var $id = obj["mem_id"].value;
	var $nickname = obj["mem_nickname"].value;
	var $email = obj["mem_email"].value;
	var $pattern = /^(([a-zA-Z\d][-_]?){3,15})@([a-zA-z\d]{5,15})\.([a-z]{2,3})$/;
	
	if($id == null || $id.length == 0) {
		alert("아이디를 입력해주세요.");
		return false;
	}
	if($nickname == null || $nickname.length == 0) {
		alert("닉네임을 입력해주세요.");
		return false;
	}
	if(!new RegExp($pattern).test($email)) {
		alert("이메일 형식이 올바르지 않습니다.");
		return false;
	}
	
	$(obj).find("button").html("<div class='spinner-border text-light'></div>");
}
</script>
<style>
.contentWrapper .container-fluid .findWrapper {
	display: flex;
	align-items: center;
}
.contentWrapper .container-fluid .findWrapper .findInner {
	margin: auto;
}
.contentWrapper .container-fluid .findWrapper .findInner .find-title {
}
.contentWrapper .container-fluid .findWrapper .findInner .find-tab {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.contentWrapper .container-fluid .findWrapper .findInner .find-tab li {
	float: left;
	width: 200px;
	text-align: center;
	padding: 20px;
	border: 1px solid #D5D5D5;
	cursor: pointer;
}
.contentWrapper .container-fluid .findWrapper .findInner .find-tab li.active {
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-bottom-color: white;
	color: rgba(17, 135, 207, 0.4);
	font-weight: bold;
}
.contentWrapper .container-fluid .findWrapper .findInner .find-tab li.none-id {
	border-right: 1px solid transparent;
	border-bottom-color: rgba(17, 135, 207, 0.4); 
	color: black;
	font-weight: normal;
}
.contentWrapper .container-fluid .findWrapper .findInner .find-tab li.none-pw {
	border-left: 1px solid transparent;
	border-bottom-color: rgba(17, 135, 207, 0.4);
	color: black;
	font-weight: normal; 
}
.contentWrapper .container-fluid .findWrapper .findInner .find-content {
	margin-top: 5px;
}
.contentWrapper .container-fluid .findWrapper .findInner .find-content input {
	height: 50px;
	margin-bottom: 5px;
	border: 1px solid #D5D5D5;
}
.contentWrapper .container-fluid .findWrapper .findInner .find-content button {
	width: 100%;
	height: 50px;
	background-color: #1187CF;
	color: white;
}
.contentWrapper .container-fluid .findWrapper .findInner .find-content form {
	display: none;
}
.contentWrapper .container-fluid .findWrapper .findInner .find-content form.on {
	display: block;
}
</style>
<div class="findWrapper">
	<div class="findInner">
		<div class="find-title">
			<h2>아이디 찾기</h2>
		</div>
		<ul class="find-tab">
			<li id="find-id" class="active" value="id">아이디 찾기</li>
			<li id="find-pw" class="none-pw" value="pw">비밀번호 찾기</li>
		</ul>
		<div class="find-content">
			<form action="${pageContext.request.contextPath}/login/findID" id="find-id-form" class="on" onsubmit="return validCheck1(this);" method="post">
				<input id="mem_nickname" name="mem_nickname" class="w3-input input" type="text" placeholder="닉네임"/>
				<input id="mem_email" name="mem_email" class="w3-input input" type="text" placeholder="이메일"/>
				<button type="submit" class="w3-button">확인</button>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
			<form action="${pageContext.request.contextPath}/login/findPW" id="find-pw-form" onsubmit="return validCheck2(this);" method="post">
				<input id="mem_id" name="mem_id" class="w3-input input" type="text" placeholder="아이디"/>
				<input id="mem_nickname" name="mem_nickname" class="w3-input input" type="text" placeholder="닉네임"/>
				<input id="mem_email" name="mem_email" class="w3-input input" type="text" placeholder="이메일"/>
				<button type="submit" class="w3-button">확인</button>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
	</div>
</div>