<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<jsp:include page="/resources/common/common.jsp"/>
<style type="text/css">
html, body {
	background-color: #f4f5f7;
}
.top {
	text-align: center;
}
.middle {
	max-width: 500px;
	margin: auto;
}
.middle .input-box {
	margin-bottom: 10px;
}
.middle .input-box .input {
	height: 50px;
	border: 1px solid #D5D5D5;
}
.middle .input-box .valid {
	color: #1187CF;
}
.middle .input-box .invalid {
	color: #CC3D3D;
}
.padding-box {
	padding: 0 !important;
}
.padding-year {
	padding: 0 !important;
}
.padding-month {
	padding: 0 !important;
	padding-left: 5px !important;
}
.padding-date {
	padding: 0 !important;
	padding-left: 5px !important;
}
.select-height {
	height: 50px;
}
.flex {
	display: flex;
}
.middle .input-box .email-access-title {
	text-align: center;
	padding: 10px;
	background-color: white;
	border: 1px solid #D5D5D5;
	border-bottom: none;
}
.middle .input-box .email-access-title div {
	display: inline-block;
}
.middle .input-box .email-access-title .circle {
	width: 40px;
	height: 40px;
	line-height: 40px;
	margin-right: 10px;
	border: 1px solid #D5D5D5;
	border-radius: 200px;
	background-color: #f4f5f7;
}
.middle .input-box .email-access-title .circle i {
	color: #1187CF;
}
.middle .input-box .email-access-title .title-text {
	font-size: 13pt;
}
.middle .input-box .w3-button {
	width: 100px;
	padding: 0;
	background-color: #1187CF;
	color: white;
}
.middle .w3-button.reg-button {
	width: 100%;
	height: 50px;
	background-color: #1187CF;
	color: white;
}
@media (max-width: 600px) {
	.padding-year {
		margin-bottom: 5px;
	}
	.padding-month {
		margin-bottom: 5px;
		padding-left: 0 !important;
	}
	.padding-date {
		padding-left: 0 !important;
	}
}
</style>
</head>
<body>
<div class="container">
	<div class="top">
		<a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/image/main/regLogo.png"/></a>
	</div>
	<div class="middle">
		<div class="input-box">
			<h5>아이디</h5>
			<input class="w3-input input" type="text">
			<label class="valid">테스트입니다.</label>
		</div> 
		<div class="input-box">
			<h5>비밀번호</h5>
			<input class="w3-input input" type="text">
			<label class="valid">테스트입니다.</label>
		</div> 
		<div class="input-box">
			<h5>비밀번호 재확인</h5>
			<input class="w3-input input" type="text">
			<label class="valid">테스트입니다.</label>
		</div> 
		<div class="input-box">
			<h5>이름</h5>
			<input class="w3-input input" type="text">
			<label class="valid">테스트입니다.</label>
		</div>
		<div class="input-box">
			<h5>생년월일</h5>
			<div class="w3-row-padding padding-box">
			  <div class="w3-third padding-year">
				  <select class="w3-select w3-border select-height" name="option">
				    <option value="" disabled selected>Year</option>
				    <option value="1">Option 1</option>
				    <option value="2">Option 2</option>
				    <option value="3">Option 3</option>
				  </select>
			  </div>
			  <div class="w3-third padding-month">
				  <select class="w3-select w3-border select-height" name="option">
				    <option value="" disabled selected>Month</option>
				    <option value="1">Option 1</option>
				    <option value="2">Option 2</option>
				    <option value="3">Option 3</option>
				  </select> 
			  </div>
			  <div class="w3-third padding-date">
				  <select class="w3-select w3-border select-height" name="option">
				  	<option value="" disabled selected>Date</option>
				    <option value="1">Option 1</option>
				    <option value="2">Option 2</option>
				    <option value="3">Option 3</option>
				  </select>
			  </div>
			 </div>
			 <label class="valid">테스트입니다.</label>
		</div>
		<div class="input-box">
			<h5>성별</h5>
			<select class="w3-select w3-border select-height" name="option">
				<option value="1">남자</option>
				<option value="2">여자</option>
			</select> 
			<label class="valid">테스트입니다.</label>
		</div>
		<div class="input-box">
			<div class="email-access-title">
				<div class="circle"><i class="far fa-envelope"></i></div><div class="title-text">이메일 인증</div>
			</div>
			<div class="w3-row-padding padding-box flex">
				<input class="w3-input input" type="text"><button class="w3-button w3-disabled" disabled>요청</button>
			</div>
			<label class="valid">테스트입니다.</label>
		</div>
		<button class="w3-button reg-button">가입하기</button>
	</div>
</div>
</body>
</html>