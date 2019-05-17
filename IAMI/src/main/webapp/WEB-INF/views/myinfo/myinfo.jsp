<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(window).resize(resize);
function resize() {
	$htmlHeight = $("html").height();
	$headerHeight = $(".headerWrapper").height();
	$navHeight = $(".navWrapper").height();
	$footerHeight = $(".footerWrapper").height();
	
	$(".container-fluid .infoWrapper").css("min-height", $htmlHeight - $headerHeight - $navHeight - $footerHeight - 41 + "px");
}
function updateProfile(obj) {
	var fileName = obj.files[0].name;
	var fileSize = obj.files[0].size;
	var maxSize = 10 * 1024 * 1024;
	var ext = fileName.substr(fileName.lastIndexOf(".")+1, fileName.length);
	var mem_no = "${empty sessionScope.mem_no? 0:sessionScope.mem_no}";
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	if(mem_no == 0) {
		alert("로그인이 필요합니다.");
		location.href = "${pageContext.request.contextPath}/login";
		return false;
	}
	
	if(!($.inArray(ext.toLowerCase(), ["jpg", "jpeg", "jpe", "png", "git"]) >= 0)) {
		alert("이미지 파일을 업로드해주세요.");
		return false;
	}
	if(fileSize > maxSize) {
		alert("10MB 이하의 이미지 파일만 허용됩니다.");
		return false;
	}
	
	var formData = new FormData();
	formData.append("profile", obj.files[0]);
	formData.append("mem_no", mem_no);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/upload/profile",
		type: "POST",
		cache: false,
		data: formData,
		processData: false,
		contentType: false,
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data.uploaded) {
					alert("변경되었습니다.");
					location.reload();
/* 					$("#mem_profile").attr("src", "${pageContext.request.contextPath}/resources/upload/" + data.name);
					$("#mem_profile").removeClass("img-none");
					$("#mem_profile").addClass("img"); */
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});
}
function openNicknameUpdate(obj) {
	var tempNickname = $("#nickname").html().trim();
	$("#nickname").html("<input id='nickname-update-value' class='nickname-input' type='text' value='" + tempNickname + "'/>");
	$(obj).toggle();
	$("#nickname-update-ok").attr("onclick", "nicknameUpdate()");
	$("#nickname-update-cancle").attr("onclick", "cancleNicknameUpdate('" + $(obj).attr("id") + "', '" + tempNickname + "');");
	$(".nickname-update-btn").toggle();
}
function nicknameUpdate() {
	var nickname = $("#nickname-update-value").val();
	var no = "${empty sessionScope.mem_no? 0:sessionScope.mem_no}";
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	if(no == 0) {
		alert("로그인이 필요합니다.");
		location.href = "${pageContext.request.contextPath}/login";
		return false;
	}
	if(nickname == null || nickname.length < 3 || nickname.length > 7) {
		alert("닉네임은 3자 이상 7자 이하로 입력해주세요.");
		return false;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/myinfo/update/nickname",
		type: "POST",
		data: {
			"mem_no" : no,
			"mem_nickname" : nickname
		},
		cache: false,
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data != "Fail") {
					alert("변경되었습니다.");
					location.reload();
				} else {
					alert("알 수 없는 오류입니다.")
				}
			}
		}
	});
}
function cancleNicknameUpdate(id, nickname) {
	$("#nickname").html(nickname);
	$(".nickname-update-btn").toggle();
	$("#" + id).toggle();
}
function openEmailUpdate() {
	$(".email-update-box").toggle();
}
function requestEmailAccess(obj) {
	var $pattern = /^(([a-zA-Z\d][-_]?){3,15})@([a-zA-z\d]{5,15})\.([a-z]{2,3})$/;
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	if(new RegExp($pattern).test(obj.val())) {
		$.ajax({
			url: "${pageContext.request.contextPath}/member/myinfo/update/emailAccess",
			type: "POST",
			data: {
				"mem_email" : obj.val()
			},
			cache: false,
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
				$("#email-access").html("<div class='spinner-border spinner-border-sm'></div>");
				$("#email-access").removeAttr("onclick");
			},
			complete: function() {
				$("#email-access").html("요청");
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Overlap") {
						alert("이미 사용 중인 이메일입니다.");
						$("#email-access").attr("onclick", "requestEmailAccess($('#email-input'));");
					} else if(data == "Fail") {
						alert("알 수 없는 오류입니다.");
						$("#email-access").attr("onclick", "requestEmailAccess($('#email-input'));");
					} else {
						$(obj).attr("disabled", "disabled");
						$("#email-access").attr("disabled", "disabled");
						$("#email-access-input").removeAttr("disabled");
						$("#email-access-ok").removeAttr("disabled");
						$("#email-access-ok").attr("onclick", "requestEmailAccessOk(" + data + ")");
					}
				}
			}
		});
	} else {
		alert("이메일 형식이 올바르지 않습니다.");
		return false;
	}
}
function requestEmailAccessOk(no) {
	var mem_no = "${empty sessionScope.mem_no? 0:sessionScope.mem_no}";
	var email = $("#email-input").val();
	var accessKey = $("#email-access-input").val();
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";

	if(mem_no == 0) {
		alert("로그인이 필요합니다.")
		location.href = "${pageContext.request.contextPath}/login";
		return false;
	}
	if(accessKey == null || accessKey.length == 0) {
		alert("이메일 인증키를 입력해주세요.");
		return false;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/myinfo/update/emailAccessOk",
		type: "POST",
		data: {
			"mem_no" : mem_no,
			"mem_email" : email,
			"key_no" : no,
			"key_accessKey" : accessKey
		},
		cache: false,
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Wrong") {
					alert("인증키가 올바르지 않습니다.");
				} else if(data == "Fail") {
					alert("알 수 없는 오류입니다.");
				} else if(data == "Ok") {
					alert("변경되었습니다.");
					location.reload();
				} else {					
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});
}
function passwordChange() {
	var no = "${empty sessionScope.mem_no? 0:sessionScope.mem_no}";
	var password_now = $("#password-now").val();
	var password_new = $("#password-new").val();
	var password_new_re = $("#password-new-re").val();
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	var $pattern = /^(?=.*\d)(?=.*\W)(?=.*[a-zA-Z]).{8,20}$/;
	
	if(no == 0) {
		alert("로그인이 필요합니다.")
		location.href = "${pageContext.request.contextPath}/login";
		return false;
	}
	if(!new RegExp($pattern).test(password_new)) {
		alert("영문, 숫자, 특수문자 포함 8자 이상 20자 이하로 입력해주세요.");
		return false;
	}
	if(password_new != password_new_re) {
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/myinfo/update/password",
		type: "POST",
		data: {
			"mem_no" : no,
			"password_now" : password_now,
			"password_new" : password_new_re
		},
		cache: false,
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Wrong") {
					alert("현재 비밀번호가 일치하지 않습니다.");
				} else if(data == "Fail") {
					alert("알 수 없는 오류입니다.");
				} else if(data == "Same") {
					alert("현재 비밀번호와 동일하게 설정할 수 없습니다.");	
				} else if(data == "Ok") {
					alert("변경되었습니다.");
					location.reload();
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});
}
</script>
<style>
.infoWrapper {
	display: flex;
	align-items: center;
}
.infoWrapper input {
	padding: 5px;
}
.infoWrapper .infoInner {
	flex-grow: 1;
	max-width: 1000px;
	margin: auto;
	text-align: center;
}
.infoWrapper .infoInner button {
	width: 100px;
	margin-top: 7.5px;
	background-color: rgba(17, 135, 207, 0.4);
	border: 1px solid rgba(17, 135, 207, 0.4);
	color: white;
}
.infoWrapper .infoInner .profile-box .profile {
	padding: 15px;
	height: 300px;
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.infoWrapper .infoInner .profile-box .profile label {
	width: 100px;
	margin-top: 7.5px;
	background-color: rgba(17, 135, 207, 0.4);
	border: 1px solid rgba(17, 135, 207, 0.4);
	color: white;
}
.infoWrapper .infoInner .profile-box .profile input[type="file"] {
	display: none;
}
.infoWrapper .infoInner .profile-box .profile:hover {
	border: 1px solid rgb(17, 135, 207);
}
.infoWrapper .infoInner .profile-box .profile .profile-member {
	padding: 15px 0;
	text-align: center;
}
.infoWrapper .infoInner .profile-box .profile .profile-member .img {
	width: 100px;
	height: 100px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 50%;
}
.infoWrapper .infoInner .profile-box .profile .profile-member .img-none {
	width: 100px;
	height: 100px;
}
.infoWrapper .infoInner .info-box .info {
	padding: 15px;
	min-height: 300px;
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.infoWrapper .infoInner .info-box .info:hover {
	border: 1px solid rgb(17, 135, 207);
}
.infoWrapper .infoInner .info-box .info table {
	width: 100%;
	border-collapse: collapse;
}
.infoWrapper .infoInner .info-box .info table td {
	padding: 5px;
	border: 1px solid #D5D5D5;
}
.infoWrapper .infoInner .info-box .info table td #nickname .nickname-input {
	width: 106px;
	height: 35px;
}
.infoWrapper .infoInner .info-box .info table .head {
	min-width: 90px;
	background-color: rgba(246, 246, 246, 0.4);
}
.infoWrapper .infoInner .info-box .info input {
	border: 1px solid #D5D5D5;
}
.infoWrapper .infoInner .info-box .info table td button {
	width: 50px;
	padding: 2px;
}
.infoWrapper .infoInner .info-box .info .nickname-update-btn {
	display: none;
}
.infoWrapper .infoInner .info-box .info .email-update-box {
	display: none;
	margin-top: 5px;
	padding: 15px;
	border: 1px solid #D5D5D5;
	background-color: rgba(246, 246, 246, 0.4);
}
.infoWrapper .infoInner .info-box .info .email-update-box input {
	flex-grow: 1;
	height: 35px;
}
.infoWrapper .infoInner .info-box .info .email-update-box .title {
	font-weight: bold;
	margin-bottom: 5px;
}
.infoWrapper .infoInner .info-box .info .email-update-box .content {
	display: flex;
	justify-content: center;
}
.infoWrapper .infoInner .info-box .info .email-update-box .content .spinner-border {
	color: white;
}
.infoWrapper .infoInner .info-box .info .email-update-box .access {
	display: flex;
	justify-content: center;
	margin-top: 5px;
}
.infoWrapper .infoInner .info-box .info .email-update-box button {
	max-width: 50px;
	margin: 0;
	padding: 0;
}
.infoWrapper .infoInner .password-box .password {
	margin-top: 10px;
	padding: 15px;
	min-height: 300px;
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.infoWrapper .infoInner .password-box .password .password-input.now {
	margin-bottom: 5px;
}
.infoWrapper .infoInner .password-box .password .password-input input {
	width: 100%;
	height: 35px;
	border: 1px solid #D5D5D5;
}
.infoWrapper .infoInner .password-box .password .password-input.new input {
	border-bottom: none;
}
.infoWrapper .infoInner .password-box .password .password-input button {
	width: 100%;
}
.infoWrapper .infoInner .password-box .password:hover {
	border: 1px solid rgb(17, 135, 207);
}
.infoWrapper .infoInner .profile-box, .info-box, .password-box {
	padding: 0 10px;
}
@media (max-width:767px) {
	.infoWrapper .infoInner {
		margin-top: 10px !important;
		margin-bottom: 10px !important;
	}
	.info-box .info {
		margin-top: 10px;
	}
}
@media (min-width:768px) {
	.infoWrapper .infoInner .info-box {
		padding-left: 0;
	}
}
</style>
<div class="infoWrapper">
	<div class="infoInner row">
		<div class="profile-box col-sm-12 col-md-6">
			<div class="profile">
				<h3>프로필</h3>
				<div class="profile-member">
					<c:choose>
						<c:when test="${not empty member.mem_profile}">
							<img id="mem_profile" class="img" src="${pageContext.request.contextPath}/resources/upload/${member.mem_profile}"/>
						</c:when>
						<c:otherwise>
							<img id="mem_profile" class="img-none" src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
						</c:otherwise>
					</c:choose>
				</div>
				<label for="profile" class="w3-button">수정</label>
				<input id="profile" type="file" onchange="updateProfile(this);"/>
			</div>
		</div>
		<div class="info-box col-sm-12 col-md-6">
			<div class="info">
				<h3>내 정보</h3>
				<table>
					<tr>
						<td class="head">아이디</td><td>${member.mem_id}</td>
					</tr>
					<tr>
						<td class="head">닉네임</td>
						<td>
							<div id="nickname">${member.mem_nickname}</div>
							<div class="nickname-update-btn">
								<button id="nickname-update-ok" class="w3-button">확인</button>
								<button id="nickname-update-cancle" class="w3-button">취소</button>
							</div>
							<button id="nickname-update" class="w3-button" onclick="openNicknameUpdate(this);">수정</button>
						</td>
					</tr>
					<tr>
						<td class="head">이메일</td>
						<td>
							<div>${member.mem_email}</div>
							<button class="w3-button" onclick="openEmailUpdate();">수정</button>
						</td>
					</tr>
				</table>
				<div class="email-update-box">
					<div class="title">이메일 변경</div>
					<div class="content">
						<input id="email-input" type="text" placeholder="변경할 이메일"/><button id="email-access" class="w3-button" onclick="requestEmailAccess($('#email-input'));">요청</button>
					</div>
					<div class="access">
						<input id="email-access-input" type="text" disabled="disabled" placeholder="이메일 인증키"/><button id="email-access-ok" class="w3-button" disabled="disabled">확인</button>
					</div>
				</div>
			</div>
		</div>
		<div class="password-box col-sm-12 col-md-6">
			<div class="password">
				<h3>비밀번호 변경</h3>
				<div class="password-input now">
					<input id="password-now" type="password" placeholder="현재 비밀번호"/>
				</div>
				<div class="password-input new">
					<input id="password-new" type="password" placeholder="새 비밀번호"/>
				</div>
				<div class="password-input new-re">
					<input id="password-new-re" type="password" placeholder="새 비밀번호 확인"/>
				</div>
				<div class="password-button">
					<button class="w3-button" onclick="passwordChange();">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>