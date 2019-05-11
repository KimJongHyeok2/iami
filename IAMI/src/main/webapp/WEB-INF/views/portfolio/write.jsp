<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포트폴리오 작성</title>
<jsp:include page="/resources/common/common.jsp"/>
<script type="text/javascript">
var $currContent = 1;
var $width = 20;
$(document).ready(function() {
	resize();
});
$(window).resize(resize_next_res);
function resize() {
	var contentHeight = $("#one").height();
	$(".contentInner").css("height", contentHeight + 30 + "px");
}
function button_delay() {
	$("#btn-prev").attr("disabled", "disabled");
	$("#btn-next").attr("disabled", "disabled");
	setTimeout(function() {
		$("#btn-prev").removeAttr("disabled", "disabled");
		$("#btn-next").removeAttr("disabled", "disabled");		
	}, 3000);
}
function resize_next_res() {
	if($currContent == 2) {
		var contentHeight = $("#two").height();
		$(".contentInner").css("height", contentHeight + 30 + "px");
	} else if($currContent == 3) {
		var contentHeight = $("#three").height();
		$(".contentInner").css("height", contentHeight + 30 + "px");		
	} else if($currContent == 4) {
		var contentHeight = $("#four").height();
		$(".contentInner").css("height", contentHeight + 30 + "px");		
	} else if($currContent == 5) {
		var contentHeight = $("#five").height();
		$(".contentInner").css("height", contentHeight + 30 + "px");		
	}
}
function resize_prev_res() {
	if($currContent == 4) {
		var contentHeight = $("#four").height();
		$(".contentInner").css("height", contentHeight + 30 + "px");
	} else if($currContent == 3) {
		var contentHeight = $("#three").height();
		$(".contentInner").css("height", contentHeight + 30 + "px");		
	} else if($currContent == 2) {
		var contentHeight = $("#two").height();
		$(".contentInner").css("height", contentHeight + 30 + "px");		
	} else if($currContent == 1) {
		var contentHeight = $("#one").height();
		$(".contentInner").css("height", contentHeight + 30 + "px");		
	}
}
function prev() {
	button_delay();
	if($currContent == 1) {
		return false;
	} else if($currContent == 2){
		$("#two").removeClass("animated fadeInRight");
		$("#two").addClass("animated fadeOutRight");
/* 		$("#two").css("display", "none");
		$("#one").css("display", "block"); */
		$("#one").removeClass("animated fadeOutLeft");		
		$("#one").addClass("animated fadeInLeft");
		$("#circle-2").removeClass("spinner-grow spinner");
		$("#circle-2").addClass("normal-circle");
		$("#circle-1").removeClass("normal-circle clear");
		$("#circle-1").addClass("spinner-grow spinner");
		$("#hr-1").removeClass("clear");
		$("#btn-prev").css("display", "none");
		prevProgress();
	} else if($currContent == 3) {
		$("#three").removeClass("animated fadeInRight");
		$("#three").addClass("animated fadeOutRight");
/* 		$("#three").css("display", "none");
		$("#two").css("display", "block"); */
		$("#two").removeClass("animated fadeOutLeft");		
		$("#two").addClass("animated fadeInLeft");
		$("#circle-3").removeClass("spinner-grow spinner");
		$("#circle-3").addClass("normal-circle");
		$("#circle-2").removeClass("normal-circle clear");
		$("#circle-2").addClass("spinner-grow spinner");
		$("#hr-2").removeClass("clear");
		prevProgress();
	} else if($currContent == 4) {
		$("#four").removeClass("animated fadeInRight");
		$("#four").addClass("animated fadeOutRight");
/* 		$("#four").css("display", "none");
		$("#three").css("display", "block"); */
		$("#three").removeClass("animated fadeOutLeft");		
		$("#three").addClass("animated fadeInLeft");
		$("#circle-4").removeClass("spinner-grow spinner");
		$("#circle-4").addClass("normal-circle");
		$("#circle-3").removeClass("normal-circle clear");
		$("#circle-3").addClass("spinner-grow spinner");
		$("#hr-3").removeClass("clear");
		prevProgress();
	} else if($currContent == 5) {
		$("#five").removeClass("animated fadeInRight");
		$("#five").addClass("animated fadeOutRight");
/* 		$("#five").css("display", "none");
		$("#four").css("display", "block"); */
		$("#four").removeClass("animated fadeOutLeft");		
		$("#four").addClass("animated fadeInLeft");
		$("#circle-5").removeClass("spinner-grow spinner");
		$("#circle-5").addClass("normal-circle");
		$("#circle-4").removeClass("normal-circle clear");
		$("#circle-4").addClass("spinner-grow spinner");
		$("#hr-4").removeClass("clear");
		$("#btn-next").css("display", "inline-block");
		prevProgress();
	}
}
function next() {
	/* button_delay(); */
	if($currContent == 1) {
		$("#one").removeClass("animated fadeInLeft");
		$("#one").removeClass("animated fadeInRight");
		$("#one").addClass("animated fadeOutLeft");
		/* $("#one").css("display", "none"); */
		$("#two").css("display", "block");
		$("#two").removeClass("animated fadeOutRight");
		$("#two").removeClass("animated fadeOutLeft");
		$("#two").addClass("animated fadeInRight");
		$("#circle-1").removeClass("spinner-grow spinner");
		$("#circle-1").addClass("normal-circle clear");
		$("#circle-2").removeClass("normal-circle");
		$("#circle-2").addClass("spinner-grow spinner");
		$("#hr-1").addClass("clear");
		$("#btn-prev").css("display", "inline-block");
		nextProgress();
	} else if($currContent == 2) {
		$("#two").removeClass("animated fadeInLeft");
		$("#two").removeClass("animated fadeInRight");
		$("#two").addClass("animated fadeOutLeft");
		/* $("#two").css("display", "none"); */
		$("#three").css("display", "block");
		$("#three").removeClass("animated fadeOutRight");
		$("#three").removeClass("animated fadeOutLeft");
		$("#three").addClass("animated fadeInRight");
		$("#circle-2").removeClass("spinner-grow spinner");
		$("#circle-2").addClass("normal-circle clear");
		$("#circle-3").removeClass("normal-circle");
		$("#circle-3").addClass("spinner-grow spinner");
		$("#hr-2").addClass("clear");
		nextProgress();
	} else if($currContent == 3) {
		$("#three").removeClass("animated fadeInLeft");
		$("#three").removeClass("animated fadeInRight");
		$("#three").addClass("animated fadeOutLeft");
		/* $("#three").css("display", "none"); */
		$("#four").css("display", "block");
		$("#four").removeClass("animated fadeOutRight");
		$("#four").removeClass("animated fadeOutLeft");
		$("#four").addClass("animated fadeInRight");
		$("#circle-3").removeClass("spinner-grow spinner");
		$("#circle-3").addClass("normal-circle clear");
		$("#circle-4").removeClass("normal-circle");
		$("#circle-4").addClass("spinner-grow spinner");
		$("#hr-3").addClass("clear");
		nextProgress();
	} else if($currContent == 4) {
		$("#four").removeClass("animated fadeInLeft");
		$("#four").removeClass("animated fadeInRight");
		$("#four").addClass("animated fadeOutLeft");
		/* $("#four").css("display", "none"); */
		$("#five").css("display", "block");
		$("#five").removeClass("animated fadeOutRight");
		$("#five").removeClass("animated fadeOutLeft");
		$("#five").addClass("animated fadeInRight");
		$("#circle-4").removeClass("spinner-grow spinner");
		$("#circle-4").addClass("normal-circle clear");
		$("#circle-5").removeClass("normal-circle");
		$("#circle-5").addClass("spinner-grow spinner");
		$("#hr-4").addClass("clear");
		$("#btn-next").css("display", "none");
		nextProgress();
	} else if($currContent == 5) {
		return false;
	}
}
function nextProgress() {
	var $start = setInterval(onProgress, 20);
	function onProgress() {
		if($currContent == 1) {
			if($width >= 40) {
				clearInterval($start);
				$currContent += 1;
				resize_next_res();
			} else {
				$width++;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 2) {
			if($width >= 60) {
				clearInterval($start);
				$currContent += 1;
				resize_next_res();
			} else {
				$width++;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 3) {
			if($width >= 80) {
				clearInterval($start);
				$currContent += 1;
				resize_next_res();
			} else {
				$width++;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 4) {
			if($width >= 100) {
				clearInterval($start);
				$currContent += 1;
				resize_next_res();
			} else {
				$width++;
				$("#bar").css("width", $width + "%");
			}
		}
	}
}
function prevProgress() {
	var $start = setInterval(onProgress, 10);
	function onProgress() {
		if($currContent == 5) {
			if($width == 80) {
				clearInterval($start);
				$currContent -= 1;
				resize_prev_res();
			} else {
				$width--;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 4) {
			if($width == 60) {
				clearInterval($start);
				$currContent -= 1;
				resize_prev_res();
			} else {
				$width--;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 3) {
			if($width == 40) {
				clearInterval($start);
				$currContent -= 1;
				resize_prev_res();
			} else {
				$width--;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 2) {
			if($width == 20) {
				clearInterval($start);
				$currContent -= 1;
				resize_prev_res();
			} else {
				$width--;
				$("#bar").css("width", $width + "%");
			}
		}
	}
}
function openModal(type) {
	if(type == "war") {
		$("#war-modal").css("display", "block");
	}
}
function cardSelected(card) {
	$(card).find(".fa-check").toggle();
	if($(card).attr("class").indexOf("select") == -1) {
		$(card).addClass("select");
	} else {
		$(card).removeClass("select");
	}
}
function addEnvironment(obj, type) {
	var $parentHTML = $(obj).parent("div").parent("div").find(".container-inner");
	var $findObject = $parentHTML.find(".dev-card");
	var $count = $parentHTML.find(".dev-card").length;
	var $emptyFlag = false;
	
	$("#" + type + "-environment .container .row").html("");
	
	$($findObject).each(function(index) {
		if($(this).attr("class").indexOf("select") != -1) {
			$emptyFlag = true;
			if(index > 0) {
				$(this).addClass("margin-card");
			}
			$("#" + type + "-environment .container .row").append($(this).parent(".row").html());
			$(this).removeClass("margin-card");
		}
	});
	if(!$emptyFlag) {
		$("#" + type + "-environment .container .row").html("<div class='empty col-12'>등록이 필요합니다.</div>");
	}
	resize_next_res();
	$("#" + type + "-modal").css("display", "none");
}
</script>
<style type="text/css">
.header {
	text-align: center;
	border-bottom: 1px solid #D5D5D5;
}
.progressWrapper .progressInner {
	max-width: 500px;
	margin: auto;
	margin-top: 15px;
	text-align: center;
}
.progressWrapper-m {
	display: none;
}
.progressWrapper-m .progressInner-m {
	max-width: 500px;
	margin: auto;
	margin-top: 15px;
	text-align: center;
}
.progressWrapper-m .progressInner-m .progressBar {
	width: 20%;
	height: 24px;
	background-color: rgba(17, 135, 207, 0.4);
}
.progressWrapper .progressInner div {
	display: inline-block;
	vertical-align: middle;
}
.progressWrapper .progressInner .normal-circle {
	padding: 10px;
	border: 1px solid #D5D5D5;
	border-radius: 50%;
}
.progressWrapper .progressInner .normal-circle.clear {
	background-color:  rgba(17, 135, 207, 0.4);
	border-color: rgba(17, 135, 207, 0.4);
}
.progressWrapper .progressInner .hr {
	width: 70px;
	border-top: 2px solid #EAEAEA;
}
.progressWrapper .progressInner .hr.clear{
	border-color: rgba(17, 135, 207, 0.4);
}
.progressWrapper .progressInner .spinner {
	color: rgba(17, 135, 207, 0.4) !important;
}
.contentWrapper {
	margin-top: 15px;
}
.contentWrapper .contentInner {
	position: relative;
	max-width: 800px;
	margin: auto;
}
.contentWrapper .contentInner .content {
	position: absolute;
	width: 100%;
	padding: 15px;
	border: 1px solid #D5D5D5;
}
.contentWrapper .contentInner .content .title {
	text-align: center;
}
.contentWrapper .contentInner .content input {
	width: 100%;
	height: 35px;
	padding: 5px;
	border: 1px solid #D5D5D5;
}
.contentWrapper .contentInner .content textarea {
	width: 100%;
	height: 150px;
	padding: 5px;
	border: 1px solid #D5D5D5;
}
.contentWrapper .contentInner .content .description {
	margin-top: 7.5px;
}
.contentWrapper .contentInner .content .environment-title div {
	display: inline-block;
	vertical-align: middle;
	text-align: center;
}
.contentWrapper .contentInner .content .environment-title .btn-add {
	width: 25px;
	margin-left: 5px;
	border: 1px solid rgba(17, 135, 207, 0.4) !important;
	background-color: rgba(17, 135, 207, 0.4) !important;
	color: white !important;
	cursor: pointer;
}
.contentWrapper .contentInner .content .environment-input {
	margin-top: 7.5px;
}
.contentWrapper .contentInner .content .environment-input .container {
	max-width: 100% !important;
	padding: 0 !important;
}
.contentWrapper .contentInner .content .environment-input .container .row {
	margin: 0 !important;
}
.contentWrapper .contentInner .content .environment-input .container .row .empty {
	padding: 30px;
	text-align: center;
	border: 1px solid #D5D5D5;
}
.contentWrapper .contentInner .content .environment-input .container .row .margin-card {
	margin-left: 5px;
}
.contentWrapper .contentInner .content:not(#one) {
	display: none;
}
.functionWrapper {
	margin-top: 15px;
}
.functionWrapper .functionInner {
	max-width: 800px;
	margin: auto;
	text-align: center;
}
.functionWrapper .functionInner button {
	border-color: rgba(17, 135, 207, 0.4) !important;
	color: rgba(17, 135, 207, 0.8) !important;
}
.functionWrapper .functionInner #btn-prev {
	display: none;
}
.w3-modal .w3-container {
	background-color: rgba(17, 135, 207, 0.4); 
	color: white;
}
.w3-modal .margin-left {
	margin-left: 5px;
}
.w3-modal .margin-card {
	margin-left: 5px;
}
.w3-modal .w3-container h2 {
	margin-top: 7.5px;
}
.w3-modal .container {
	max-width: 100% !important;
	padding: 0 !important;
}
.w3-modal .container .container-inner {
	margin: 10px;
}
.w3-modal .container .row {
	max-width: 100% !important;
	margin: 0 !important;
}
.container .dev-card {
	position: relative;
	padding: 5px;
	border: 1px solid #D5D5D5;
	cursor: pointer;
}
.container .dev-card.select {
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.container .dev-card:hover {
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.container .dev-card div {
	display: inline-block;
	vertical-align: middle;
}
.container .dev-card .dev-card-img {
	width: 50px;
	height: 50px;
}
.container .dev-card .dev-card-img img {
	width: 100%;
	height: 100%;
}
.container .dev-card .fa-check {
	display: none;
	position: absolute;
	top: 0;
	right: 0;
	padding: 0;
	color: rgba(17, 135, 207, 0.4);
}
@media (max-width:801px) {
	.progressWrapper-m {
		margin: 0 10px;
	}
	.contentWrapper {
		margin-right: 10px;
		margin-left: 10px;
	}
}
@media (max-width:767px) {
	.margin-card {
		margin-top: 5px !important;
		margin-left: 0 !important;
	}
}
@media (max-width:397px) {
	.progressWrapper {
		display: none;
	}
	.progressWrapper-m {
		display: block;
	}
}
</style>
</head>
<body>
<div class="header w3-animate-top">
	<a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/image/main/logo.png"/></a>
</div>
<div class="progressWrapper">
	<div class="progressInner">
		<div id="circle-1" class="spinner-grow spinner"></div><div id="hr-1" class="hr"></div><div id="circle-2" class="normal-circle"></div><div id="hr-2" class="hr"></div><div id="circle-3" class="normal-circle"></div><div id="hr-3" class="hr"></div><div id="circle-4" class="normal-circle"></div><div id="hr-4" class="hr"></div><div id="circle-5" class="normal-circle"></div>
	</div>
</div>
<div class="progressWrapper-m">
	<div class="progressInner-m">
	  <div class="w3-light-grey">
	    <div id="bar" class="progressBar"></div>
	  </div>
	</div>
</div>
<div class="contentWrapper">
	<div class="contentInner">
		<div id="one" class="content">
			<div class="title">
				<h5>제목과 간단한 설명을 입력해주세요.</h5>
			</div>
			<div class="subject">
				<div class="subject-title">
					<h6>제목</h6>
				</div>
				<div class="subject-input">
					<input id="pot-subject" name="pot-subject" type="text" placeholder="5자 이상 20자 이하"/>
				</div>
			</div>
			<div class="description">
				<div class="description-title">
					<h6>설명</h6>
				</div>
				<div class="description-input">
					<textarea id="pot-description" name="pot-description" placeholder="30자 이하"></textarea>
				</div>
			</div>
		</div>
		<div id="two" class="content">
			<div class="title">
				<h5>개요를 입력해주세요.</h5>
			</div>
			<div class="summary">
				<div class="summary-title">
					<h6>개요</h6>
				</div>
				<div class="summary-input">
					<textarea id="pot-summary" name="pot-summary" placeholder="5자 이상 150자 이하"></textarea>
				</div>
			</div>
		</div>
		<div id="three" class="content">
			<div class="title">
				<h5>주요환경을 선택해주세요.</h5>
			</div>
			<div class="environment">
				<div class="environment-title">
					<div>배포환경</div><div class="btn-add" onclick="openModal('war');"><i class="fas fa-plus"></i></div>
				</div>
				<div id="war-environment" class="environment-input">
					<div class="container">
						<div class="row">
							<div class="empty col-12">
								등록이 필요합니다.
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="four" class="content">
			4
		</div>
		<div id="five" class="content">
			5
		</div>
	</div>
</div>
<div class="functionWrapper">
	<div class="functionInner">
		<button id="btn-prev" class="w3-button w3-white w3-border" onclick="prev();">이전</button>
		<button id="btn-next" class="w3-button w3-white w3-border" onclick="next();">다음</button>
	</div>
</div>
<div id="war-modal" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-bottom">
		<div class="w3-container">
			<h2>배포환경</h2>
		</div>
		<div class="container">
			<div class="container-inner">
				<h5>운영체제</h5>
				<div class="row">
					<div class="dev-card col-sm-12 col-md-3" onclick="cardSelected(this);">
						<div class="dev-card-img">
							<img src="${pageContext.request.contextPath}/resources/image/write/window10_2.png"/>
						</div>
						<div class="dev-card-text">
							Window10
						</div>
						<i class="fas fa-check"></i>
					</div>
				</div>
				<h5 class="w3-margin-top">서버</h5>
				<div class="row">
					<div class="dev-card col-sm-12 col-md-3" onclick="cardSelected(this);">
						<div class="dev-card-img">
							<img src="${pageContext.request.contextPath}/resources/image/write/tomcat.png"/>
						</div>
						<div class="dev-card-text">
							Tomcat
						</div>
						<i class="fas fa-check"></i>
					</div>
				</div>
			</div>
		<div class="w3-container w3-light-grey w3-padding">
			<button class="w3-button w3-right w3-white w3-border margin-left" onclick="document.getElementById('war-modal').style.display='none'">닫기</button>
			<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'war');">확인</button>
		</div>
		</div>
	</div>
</div>
</body>
</html>