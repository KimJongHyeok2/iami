<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {
	$(".find-tab li").click(function() {
		var type = $(this).attr("value"); 
		
		if(type == "id") {
			$("#find-pw").removeClass("active");
			$("#find-id").removeClass("none-id");
			$("#find-id").addClass("active");
			$("#find-pw").addClass("none-pw");
			$("#find-pw-form").removeClass("on");
			$("#find-id-form").addClass("on");
			$(".find-title h2").html("아이디 찾기");
			$("#find-span").attr("onclick", "findPW()");
			$("#find-span").html("비밀번호를 잊으셨나요?");
		} else {
			$("#find-id").removeClass("active");
			$("#find-pw").removeClass("none-pw");
			$("#find-pw").addClass("active");
			$("#find-id").addClass("none-id");
			$("#find-id-form").removeClass("on");
			$("#find-pw-form").addClass("on");
			$(".find-title h2").html("비밀번호 찾기");
			$("#find-span").attr("onclick", "findID()");
			$("#find-span").html("아이디를 잊으셨나요?");
		}
	});
	resize();
});
$(window).resize(resize);
function resize() {
	$htmlHeight = $("html").height();
	$headerHeight = $(".headerWrapper").height();
	$navHeight = $(".navWrapper").height();
	$footerHeight = $(".footerWrapper").height();
	
	$(".container-fluid .findWrapper").css("min-height", $htmlHeight - $headerHeight - $navHeight - $footerHeight - 61 + "px");
}
function findID() {
	$("#find-pw").removeClass("active");
	$("#find-id").removeClass("none-id");
	$("#find-id").addClass("active");
	$("#find-pw").addClass("none-pw");
	$("#find-pw-form").removeClass("on");
	$("#find-id-form").addClass("on");
	$(".find-title h2").html("아이디 찾기");
	$("#find-span").attr("onclick", "findPW()");
	$("#find-span").html("비밀번호를 잊으셨나요?");
}
function findPW() {
	$("#find-id").removeClass("active");
	$("#find-pw").removeClass("none-pw");
	$("#find-pw").addClass("active");
	$("#find-id").addClass("none-id");
	$("#find-id-form").removeClass("on");
	$("#find-pw-form").addClass("on");
	$(".find-title h2").html("비밀번호 찾기");
	$("#find-span").attr("onclick", "findID()");
	$("#find-span").html("아이디를 잊으셨나요?");
}
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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/findInfo.css">
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
		<div id="find-399" class="find-399">
			<span id="find-span" onclick="findPW();">비밀번호를 잊으셨나요?</span>
		</div>
	</div>
</div>