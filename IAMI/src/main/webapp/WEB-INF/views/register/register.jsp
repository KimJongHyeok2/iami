<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<jsp:include page="/resources/common/common.jsp"/>
<script type="text/javascript">
var $idFlag = false, $pwFlag = false, $pwFlag = false, $nicknameFlag = false, $emailFlag = false;
var header = '${_csrf.headerName}';
var token = '${_csrf.token}';
	
function vaildCheckID() {
	var $id = $("#mem_id").val();
	var $pattern = /^([a-zA-Z\d]{5,10})$/;
	
	if(new RegExp($pattern).test($id)) {
		$.ajax({
			url: "${pageContext.request.contextPath}/register/idOverlap",
			type: "POST",
			cache: false,
			data: {
				"id" : $id
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data != "Fail") {
						$("#mem_id").parent(".input-box").find("label").html("사용 가능한 아이디입니다.");
						$("#mem_id").parent(".input-box").find("label").removeClass("invalid");
						$("#mem_id").parent(".input-box").find("label").addClass("valid");
						$idFlag = true;						
					} else {
						$("#mem_id").parent(".input-box").find("label").html("이미 사용 중인 아이디입니다.");
						$("#mem_id").parent(".input-box").find("label").removeClass("valid");
						$("#mem_id").parent(".input-box").find("label").addClass("invalid");
						$idFlag = false;
					}
				}
			}
		});
	} else {
		$("#mem_id").parent(".input-box").find("label").html("영문, 숫자 5자 이상 10자 이하로 입력해주세요.");
		$("#mem_id").parent(".input-box").find("label").removeClass("valid");
		$("#mem_id").parent(".input-box").find("label").addClass("invalid");
		$idFlag = false;
	}
}
function vaildCheckPW() {
	var $pw = $("#mem_pw").val();
	var $pattern = /^(?=.*\d)(?=.*\W)(?=.*[a-zA-Z]).{8,20}$/;
	
	if(new RegExp($pattern).test($pw)) {
		$("#mem_pw").parent(".input-box").find("label").html("사용 가능한 비밀번호입니다.");
		$("#mem_pw").parent(".input-box").find("label").removeClass("invalid");
		$("#mem_pw").parent(".input-box").find("label").addClass("valid");
		$pwFlag = true;
	} else {
		$("#mem_pw").parent(".input-box").find("label").html("영문, 숫자, 특수문자 포함 8자 이상 20자 이하로 입력해주세요.");
		$("#mem_pw").parent(".input-box").find("label").removeClass("valid");
		$("#mem_pw").parent(".input-box").find("label").addClass("invalid");
		$pwFlag = false;
	}
}
function vaildCheckPW2() {
	var $pw = $("#mem_pw").val();
	var $pw2 = $("#mem_pw2").val();
	var $pattern = /^(?=.*\d)(?=.*\W)(?=.*[a-zA-Z]).{8,20}$/;
	
	if($pw == $pw2 && new RegExp($pattern).test($pw) && new RegExp($pattern).test($pw)) {
		$("#mem_pw2").parent(".input-box").find("label").html("사용 가능한 비밀번호입니다.");
		$("#mem_pw2").parent(".input-box").find("label").removeClass("invalid");
		$("#mem_pw2").parent(".input-box").find("label").addClass("valid");
		$pwFlag = true;
		$pw2Flag = true;		
	} else {
		$("#mem_pw2").parent(".input-box").find("label").html("비밀번호가 일치하지 않거나 올바르지 않습니다.");
		$("#mem_pw2").parent(".input-box").find("label").removeClass("valid");
		$("#mem_pw2").parent(".input-box").find("label").addClass("invalid");
		$pwFlag = false;
		$pw2Flag = false;
	}
}
function vaildCheckName() {
	var $name = $("#mem_nickname").val();
	var $pattern = /^[a-zA-Z가-힣]{3,10}$/;
	
	if(new RegExp($pattern).test($name)) {
		$("#mem_nickname").parent(".input-box").find("label").html("올바른 입력입니다.");
		$("#mem_nickname").parent(".input-box").find("label").removeClass("invalid");
		$("#mem_nickname").parent(".input-box").find("label").addClass("valid");
		$nicknameFlag = true;
	} else {
		$("#mem_nickname").parent(".input-box").find("label").html("한글 또는 영문 3자 이상 10자 이하로 입력해주세요.");
		$("#mem_nickname").parent(".input-box").find("label").removeClass("valid");
		$("#mem_nickname").parent(".input-box").find("label").addClass("invalid");
		$nicknameFlag = false;
	}
}
function birthSet() {
	var $nowDate = new Date();
	
	var $year = $nowDate.getFullYear();
	var $month = $nowDate.getMonth()+1;
	var $day = $nowDate.getDate();
 	
 	var $startYear = $year - 70;
 	
 	for(var i=0; i<=70; i++) {
 		$("#birth-year").append("<option value=" + ($startYear + i) + " selected>" + ($startYear + i) + "</option>");
 	}
 	for(var i=0; i<12; i++) {
 		$("#birth-month").append("<option value=" + (i + 1) + " selected>" + (i + 1) + "</option>");
 	}
 	
 	$("#birth-year").val($year);
 	$("#birth-month").val($month);
 	daySet();
 	$("#birth-day").val($day);
}
function daySet() {
	var $nowYear = $("#birth-year").val();
	var $nowMonth = $("#birth-month").val();
	var $nowDay = $("#birth-day").val();
	var $tempDay = [31,28,31,30,31,30,31,31,30,31,30,31];
	
	if(($nowYear % 4 == 0 && $nowYear % 100 != 0) || $nowYear % 400 == 0) {
		$tempDay[1] = 29;	
	}
	
	$("#birth-day").html("");
	for(var i=0; i<$tempDay[$nowMonth-1]; i++) {
		$("#birth-day").append("<option value=" + (i + 1) + " selected>" + (i + 1) + "</option>");
	}
	
	if($nowDay > $tempDay[$nowMonth-1]) {
		$("#birth-day").val($tempDay[$nowMonth-1]);
	} else {
		$("#birth-day").val($nowDay);
	}
}
function vaildCheckEmail() {
	var $email = $("#mem_email").val();
	var $pattern = /^(([a-zA-Z\d][-_]?){3,15})@([a-zA-z\d]{5,15})\.([a-z]{2,3})$/;
	
	if(new RegExp($pattern).test($email)) {
		$.ajax({
			url: "${pageContext.request.contextPath}/register/emailOverlap",
			type: "POST",
			cache: false,
			data: {
				"email" : $email
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data != "Fail") {
						$("#email-check-value").html("올바른 이메일입니다.");
						$("#email-check-value").removeClass("invalid");
						$("#email-check-value").addClass("valid");
						$("#req-access").removeClass("w3-disabled");
						$("#req-access").removeAttr("disabled");
						$("#req-access").attr("onclick", "requestAccessKey('" + $email + "');");						
					} else {
						$("#email-check-value").html("이미 등록된 이메일입니다.");
						$("#email-check-value").removeClass("valid");
						$("#email-check-value").addClass("invalid");
						$("#req-access").addClass("w3-disabled");
						$("#req-access").attr("disabled", "disabled");
					}
				}
			}
		});
	} else {
		$("#email-check-value").html("올바른 이메일을 입력해주세요.");
		$("#email-check-value").removeClass("valid");
		$("#email-check-value").addClass("invalid");
		$("#req-access").addClass("w3-disabled");
		$("#req-access").attr("disabled", "disabled");
	}
}
function requestAccessKey(email) {
	$.ajax({
		url: "${pageContext.request.contextPath}/register/sendEmail",
		type: "POST",
		cache: false,
		data: {
			"email" : email
		},
		beforeSend: function(xhr) {
			$("#req-access").html("<div class='spinner-border text-light'></div>");
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data != "Fail") {
					$("#key_no").val(data);
					$("#mem_email").attr("disabled", "disabled");
					$("#req-access").attr("disabled", "disabled");
					$("#req-access").removeAttr("onclick");
					$("#req-access").html("<div class='spinner-grow text-light'></div>");
					$("#email-access-modal").addClass("on");
				}
			}
		}
	});
}
function checkAccessKey() {
	var $no = $("#key_no").val();
	var $key = $("#key_accessKey").val();

	$.ajax({
		url: "${pageContext.request.contextPath}/register/accessOk",
		type: "POST",
		cache: false,
		data: {
			"key_no" : $no,
			"key_accessKey" : $key
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data != "Fail") {				
					$("#email-access-modal").removeClass("on");
					$("#req-access").html("완료");
					$emailFlag = true;
				} else {
					$("#email-check-accessKey").html("인증키가 올바르지 않습니다.");
					$("#email-check-accessKey").removeClass("off");
					$("#email-check-accessKey").addClass("invalid");
					$emailFlag = false;
				}
			}
		}
	});
}
function register() {
	vaildCheckID(); vaildCheckPW(); vaildCheckPW2(); vaildCheckName(); vaildCheckEmail();
 	if($idFlag && $pwFlag && $pw2Flag && $nicknameFlag && $emailFlag) {
		$.ajax({
			url: "${pageContext.request.contextPath}/register/registerOk",
			type: "POST",
			cache: false,
			data: {
				"mem_id" : $("#mem_id").val(),
				"mem_pw" : $("#mem_pw2").val(),
				"mem_nickname" : $("#mem_nickname").val(),
				"mem_gender" : $("#mem_gender").val(),
				"mem_birth" : $("#birth-year").val() + "-" + $("#birth-month").val() + "-" + $("#birth-day").val(),
				"mem_email" : $("#mem_email").val()
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data != "Fail") {
						location.href = "${pageContext.request.contextPath}/";
					} else {
						return false;
					}
				}
			}
		});
 	} 
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/register.css">
</head>
<body onload="birthSet();">
<div class="container">
	<div class="top">
		<a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/image/main/regLogo.png"/></a>
	</div>
	<div class="middle">
		<div class="input-box">
			<h5>아이디</h5>
			<input id="mem_id" class="w3-input input" type="text" onkeyup="vaildCheckID();"/>
			<label class="check-value"></label>
		</div> 
		<div class="input-box">
			<h5>비밀번호</h5>
			<input id="mem_pw" class="w3-input input" type="password" onkeyup="vaildCheckPW();"/>
			<label class="check-value"></label>
		</div> 
		<div class="input-box">
			<h5>비밀번호 재확인</h5>
			<input id="mem_pw2" class="w3-input input" type="password" onkeyup="vaildCheckPW2();"/>
			<label class="check-value"></label>
		</div> 
		<div class="input-box">
			<h5>닉네임</h5>
			<input id="mem_nickname" class="w3-input input" type="text" onkeyup="vaildCheckName();"/>
			<label class="check-value"></label>
		</div>
		<div class="input-box">
			<h5>생년월일</h5>
			<div class="w3-row-padding padding-box">
			  <div class="w3-third padding-year">
				  <select id="birth-year" class="w3-select w3-border select-height" name="option" onchange="daySet();">
				  </select>
			  </div>
			  <div class="w3-third padding-month">
				  <select id="birth-month" class="w3-select w3-border select-height" name="option" onchange="daySet();">
				  </select> 
			  </div>
			  <div class="w3-third padding-date">
				  <select id="birth-day" class="w3-select w3-border select-height" name="option">
				  </select>
			  </div>
			 </div>
			 <label class="check-value"></label>
		</div>
		<div class="input-box">
			<h5>성별</h5>
			<select id="mem_gender" class="w3-select w3-border select-height" name="option">
				<option value="1">남자</option>
				<option value="2">여자</option>
			</select>
			<label class="check-value"></label>
		</div>
		<div class="input-box">
			<div class="email-access-title">
				<div class="circle"><i class="far fa-envelope"></i></div><div class="title-text">이메일 인증</div>
			</div>
			<div class="w3-row-padding padding-box flex">
				<input id="mem_email" class="w3-input input" type="text" onkeyup="vaildCheckEmail(this);"/><button id="req-access" class="w3-button w3-disabled" disabled>요청</button>
			</div>
			<label id="email-check-value" class="check-value"></label>
		</div>
		<button class="w3-button reg-button" onclick="register();">가입하기</button>
	</div>
	<div id="email-access-modal" class="w3-modal">
	    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:500px">
	      <div class="w3-container">
	        <div class="w3-section">
	          <label><b>이메일 인증키 입력</b></label>
	          <input class="w3-input w3-border w3-margin-bottom" id="key_accessKey" type="text" placeholder="인증키를 입력하세요." name="usrname"/>
	          <input type="hidden" id="key_no"/>
	          <label id="email-check-accessKey" class="check-value off"></label>
	          <button class="w3-button w3-block w3-section w3-padding" type="submit" onclick="checkAccessKey();">인증</button>
	        </div>
	      </div>
	    </div>
	</div>
</div>
<jsp:include page="/resources/include/footer/footer.jsp"/>
</body>
</html>