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
	$(".dateSelector").flatpickr({ 
		dateFormat: "Y-m-d",
	});
	$(".ck-editor__editable[role='textbox']").on("keyup", function() {
		myEditor.setData("");
	});
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
		$("#btn-writeOk").css("display", "none");
		prevProgress();
	}
}
function next() {
	/* button_delay(); */
	if($currContent == 1) {
		if(!step1Valid()) {
			return false;
		}
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
		if(!step2Valid()) {
			return false;
		}
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
		if(!step3Valid()) {
			return false;
		}
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
		if(!step4Valid()) {
			return false;
		}
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
		$("#btn-writeOk").css("display", "inline-block");
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
	$("#" + type + "-modal").css("display", "block");
}
function cardSelected(card) {
	var $isSelected = $(card).parent(".card-box");
	$(card).find(".fa-check").toggle();
	if($isSelected.attr("class").indexOf("select") == -1) {
		$isSelected.addClass("select");
	} else {
		$isSelected.removeClass("select");
	}
}
function addEnvironment(obj, type) {
	var $parentObject = $(obj).parent("div").parent("div").find(".container-inner");
	var $findObject = $parentObject.find(".dev-card").parent(".card-box.select").find(".dev-card");
	var $selectCount = $parentObject.find(".dev-card").parent(".card-box.select").length;
	var $emptyFlag = false;
	var $addCount = 1;
	$("#" + type + "-environment .container .row").html("");
	
	$($findObject).each(function(index) {
		var $isSelected = $(this).parent(".card-box");
		var $column = $(this).parent(".card-box").attr("class").replace("card-box ", "").replace("margin-card ", "").replace(" select", "").replace("margin-top", "");
		if($isSelected.attr("class").indexOf("select") != -1) {
			$emptyFlag = true;
			
 			if($selectCount > 1) {
 				if((index+1)%$selectCount != 0) {
					$(this).addClass("margin-card");
				} else {
					$(this).addClass("last");
				}
 				if($addCount > 3) {
					$(this).addClass("margin-top");
				}
 			}
 			
			$(this).addClass($column);
			$(this).removeAttr("onclick");
  			if(type == "dem" || type == "git") {
 				$(this).attr("onclick", "location.href='" + $(this).find('input[type=hidden]').val() + "'");
 			}
			$("#" + type + "-environment .container .row").append($isSelected.html());
			$(this).attr("onclick", "cardSelected(this);"); 
			$(this).removeClass($column);
			$(this).removeClass("margin-card");
			$addCount += 1;
		}
		
	});
	if(!$emptyFlag) {
		$("#" + type + "-environment .container .row").html("<div class='empty col-12'>등록이 필요합니다.</div>");
	}
	resize_next_res();
	$("#" + type + "-modal").css("display", "none");
}
function addApiName(obj) {
	var $value = obj.val();
	var $html = "";
	var $count = $(obj).parent("div").parent("div").find(".row").find(".card-box").length;
	
	if($count >= 8) {
		alert("더 이상 등록할 수 없습니다.");
		return false;
	}
	if($value == null || $value.length == 0 || $value.length > 15) {
		alert("3자 이상 15자 이하로 입력해주세요.");
		return false;
	} else {
		$html += "<div class='card-box margin-card " + ($count >= 3? 'margin-top':'') + " col-sm-12 col-md-3'>";
			$html += "<div class='dev-card' onclick='cardSelected(this);'>";
				$html += "<div class='dev-card-text api'>";
					$html += $value;
				$html += "</div>";
				$html += "<i class='fas fa-check'></i>";
			$html += "</div>";
		$html += "</div>";
		$(obj).parent("div").parent("div").find(".row").append($html);
	}
}
function addDemoUrl(obj) {
	var $value = obj.val();
	var $html = "";
	var $pattern = /(http(s)?:\/\/)([a-z0-9\w]+\.*)+[a-z0-9]{2,4}/gi
	var $count = $(obj).parent("div").parent("div").find(".row").find(".card-box").length;
	
	if($count >= 1) {
		alert("더 이상 등록할 수 없습니다.");
		return false;
	}
	if(!new RegExp($pattern).test($value)) {
		alert("입력하신 URL을 다시 한번 확인해주세요.");
		return false;
	} else {
		$html += "<div class='card-box margin-card " + ($count >= 3? 'margin-top':'') + " col-sm-12 col-md-3'>";
			$html += "<div class='dev-card' onclick='cardSelected(this);'>";
				$html += "<div class='dev-card-text api'>";
					$html += "<i class='fas fa-link'></i>";
					$html += " Demo";
				$html += "<input type='hidden' value='" + $value + "' />";
				$html += "</div>";
				$html += "<i class='fas fa-check'></i>";
			$html += "</div>";
		$html += "</div>";
		$(obj).parent("div").parent("div").find(".row").append($html);
	}
}
function addGitUrl(obj) {
	var $value = obj.val();
	var $html = "";
	var $pattern = /(http(s)?:\/\/)([a-z0-9\w]+\.*)+[a-z0-9]{2,4}/gi
	var $count = $(obj).parent("div").parent("div").find(".row").find(".card-box").length;
	
	if($count >= 1) {
		alert("더 이상 등록할 수 없습니다.");
		return false;
	}
	if(!new RegExp($pattern).test($value) || $value.indexOf("github.com") == -1) {
		alert("GitHub URL을 입력해주세요.");
		return false;
	} else {
		$html += "<div class='card-box margin-card " + ($count >= 3? 'margin-top':'') + " col-sm-12 col-md-3'>";
			$html += "<div class='dev-card' onclick='cardSelected(this);'>";
				$html += "<div class='dev-card-text api'>";
					$html += "<i class='fab fa-github-square'></i>";
					$html += " GitHub";
				$html += "<input type='hidden' value='" + $value + "' />";
				$html += "</div>";
				$html += "<i class='fas fa-check'></i>";
			$html += "</div>";
		$html += "</div>";
		$(obj).parent("div").parent("div").find(".row").append($html);
	}
}
function step1Valid() {
	var $subject = $("#pot-subject").val();
	var $description = $("#pot-description").val();
	
	if($subject.length < 5 || $subject.length > 20) {
		alert("제목은 5자 이상 10자 이하로 입력해주세요.");
		return false;
	}
	if($description.length < 5 || $description.length > 30) {
		alert("설명은 5자 이상 30자 이하로 입력해주세요.");
		return false;
	}
	
	return true;
}
function step2Valid() {
	var $summary = $("#pot-summary").val();
	var $startDate = $("#pot-startDate").val();
	var $endDate = $("#pot-endDate").val();

	if($summary.length < 5 || $summary.length > 20) {
		alert("개요는 5자 이상 150자 이하로 입력해주세요.");
		return false;
	}
	if($startDate.length == 0 || $endDate.length == 0) {
		alert("기간을 선택해주세요.");
		return false;
	}
	
	return true;
}
function step3Valid() {
	var $warEnvCount = $("#war-environment").find(".empty").length;
	var $devEnvCount = $("#dev-environment").find(".empty").length;
	var $runEnvCount = $("#run-environment").find(".empty").length;
	var $lanEnvCount = $("#lan-environment").find(".empty").length;
	var $libEnvCount = $("#lib-environment").find(".empty").length;
	var $fraEnvCount = $("#fra-environment").find(".empty").length;
	var $dbaEnvCount = $("#fra-environment").find(".empty").length;

	if($warEnvCount != 0) {
		alert("배포환경 항목을 선택해주세요.");
		return false;
	} else if($devEnvCount != 0) {
		alert("개발환경 항목을 선택해주세요.");
		return false;
	} else if($runEnvCount != 0) {
		alert("실행환경 항목을 선택해주세요.");
		return false;
	} else if($lanEnvCount != 0) {
		alert("언어 항목을 선택해주세요.");
		return false;
	} else if($libEnvCount != 0) {
		alert("라이브러리 항목을 선택해주세요.");
		return false;
	} else if($fraEnvCount != 0) {
		alert("프레임워크 항목을 선택해주세요.");
		return false;
	} else if($dbaEnvCount != 0) {
		alert("데이터베이스 항목을 선택해주세요.");
		return false;
	}
	
	return true;
}
function step4Valid() {
	var $media = myEditor.getData();

	if($media.indexOf("oembed") == -1) {
		alert("동영상을 업로드해주세요.");
		return false;
	}
	
	return true;
}
function step5Valid() {
	var $demoEnvCount = $("#dem-environment").find(".empty").length;
	var $gitEnvCount = $("#git-environment").find(".empty").length;

	if($demoEnvCount != 0) {
		alert("Demo URL을 입력해주세요.");
		return false;
	} else if($gitEnvCount != 0) {
		alert("GitHub URL을 입력해주세요.");
		return false;		
	}
	
	return true;
}
function writeOk() {
	if(step1Valid() && step2Valid() && step3Valid() && step4Valid() && step5Valid()) {
		alert("성공");
	} else {
		alert("실패");
	}
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
.contentWrapper .contentInner .content .margin-top {
	margin-top: 5px;
}
.contentWrapper .contentInner .content .margin-title {
	margin-top: 5px;
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
.contentWrapper .contentInner .content .summary-input .container {
	max-width: 100% !important;
	padding: 0 !important;
}
.contentWrapper .contentInner .content .summary-input .container .row {
	margin: 0 !important;
}
.contentWrapper .contentInner .content .summary-input .container .row .start {
	border-right: none;
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
	margin-right: 5px;
}
.contentWrapper .contentInner .content .environment-input .container .row .dev-card {
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.contentWrapper .contentInner .content:not(#one) {
	display: none;
}
.functionWrapper {
	margin-top: 15px;
	margin-bottom: 15px; 
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
.functionWrapper .functionInner #btn-writeOk {
	display: none;
}
.w3-modal .w3-container {
	background-color: rgba(17, 135, 207, 0.4); 
	color: white;
}
.w3-modal .margin-top {
	margin-top: 5px;
}
.w3-modal .margin-left {
	margin-left: 5px;
}
.w3-modal .margin-card {
	margin-right: 5px;
}
.w3-modal .margin-card-api {
	
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
.w3-modal .container .container-inner .api-input {
	display: flex;
}
.w3-modal .container .container-inner .api-input input {
	flex-grow: 1;
	padding: 5px;
	border: 1px solid #D5D5D5;
}
.w3-modal .container .container-inner .api-input button {
	border: 1px solid #D5D5D5 !important;
	border-left: none !important;
}
.w3-modal .container .container-inner .row {
	max-width: 100% !important;
	margin: 0 !important;
	box-sizing: border-box !important;
}
.w3-modal .container .container-inner .row .card-box {
	padding: 0;
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
.ck-editor__editable[role='textbox'] {
	height: 500px;
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
}
@media (max-width:575px) {
	.start {
		border-right: 1px solid #D5D5D5 !important;
	}
	.end {
		margin-top: 5px;
	}
}
@media (max-width:414px) {
	.progressWrapper {
		display: none;
	}
	.progressWrapper-m {
		display: block;
	}
}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
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
					<textarea id="pot-description" name="pot-description" placeholder="5자 이상 30자 이하"></textarea>
				</div>
			</div>
		</div>
		<div id="two" class="content">
			<div class="title">
				<h5>개요 및 기간을 입력해주세요.</h5>
			</div>
			<div class="summary">
				<div class="summary-title">
					<h6>개요</h6>
				</div>
				<div class="summary-input">
					<textarea id="pot-summary" name="pot-summary" placeholder="5자 이상 150자 이하"></textarea>
				</div>
			</div>
			<div class="summary">
				<div class="summary-title">
					<h6>기간</h6>
				</div>
				<div class="summary-input">
					<div class="container">
						<div class="row">
							<input type="text" id="pot-startDate" name="pot-startDate" class="dateSelector start col-sm-6" placeholder="시작일"/><input type="text" id="pot-endDate" name="pot-endDate" class="dateSelector end col-sm-6" placeholder="종료일"/>
						</div>
					</div>
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
				<div class="environment-title margin-title">
					<div>개발환경</div><div class="btn-add" onclick="openModal('dev');"><i class="fas fa-plus"></i></div>
				</div>
				<div id="dev-environment" class="environment-input">
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
				<div id="run-environment" class="environment-input">
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
				<div id="lan-environment" class="environment-input">
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
				<div id="lib-environment" class="environment-input">
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
				<div id="fra-environment" class="environment-input">
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
				<div id="dba-environment" class="environment-input">
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
				<div id="api-environment" class="environment-input">
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
			<div class="title">
				<h5>동영상을 업로드해주세요.</h5>
			</div>
			<div class="environment">
				<div class="environment-title">
					<h6>동영상</h6>
				</div>
				<div class="environment-input">
					<textarea id="media"></textarea>
				</div>
			</div>
		</div>
		<div id="five" class="content">
			<div class="title">
				<h5>Demo와 GitHub URL을 추가해주세요.</h5>
			</div>
			<div class="environment">
				<div class="environment-title">
					<div>Demo</div><div class="btn-add" onclick="openModal('dem');"><i class="fas fa-plus"></i></div>
				</div>
				<div id="dem-environment" class="environment-input">
					<div class="container">
						<div class="row">
							<div class="empty col-12">
								등록이 필요합니다.
							</div>
						</div>
					</div>
				</div>
				<div class="environment-title margin-title">
					<div>GitHub</div><div class="btn-add" onclick="openModal('git');"><i class="fas fa-plus"></i></div>
				</div>
				<div id="git-environment" class="environment-input">
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
	</div>
</div>
<div class="functionWrapper">
	<div class="functionInner">
		<button id="btn-prev" class="w3-button w3-white w3-border" onclick="prev();">이전</button>
		<button id="btn-next" class="w3-button w3-white w3-border" onclick="next();">다음</button>
		<button id="btn-writeOk" class="w3-button w3-white w3-border" onclick="writeOk();">완료</button>
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
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/window10_2.png"/>
							</div>
							<div class="dev-card-text">
								Window10
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
				</div>
				<h5 class="w3-margin-top">서버</h5>
				<div class="row">
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
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
			</div>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border margin-left" onclick="$('#war-modal').css('display', 'none');">닫기</button>
				<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'war');">확인</button>
			</div>
		</div>
	</div>
</div>
<div id="dev-modal" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-bottom">
		<div class="w3-container">
			<h2>개발환경</h2>
		</div>
		<div class="container">
			<div class="container-inner">
				<h5>운영체제</h5>
				<div class="row">
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/window10_2.png"/>
							</div>
							<div class="dev-card-text">
								Window10
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
				</div>
				<h5 class="w3-margin-top">서버</h5>
				<div class="row">
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
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
				<h5 class="w3-margin-top">개발툴</h5>
				<div class="row">
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/eclipse.png"/>
							</div>
							<div class="dev-card-text">
								Eclipse
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border margin-left" onclick="$('#dev-modal').css('display', 'none');">닫기</button>
				<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'dev');">확인</button>
			</div>
		</div>
	</div>
</div>
<div id="run-modal" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-bottom">
		<div class="w3-container">
			<h2>실행환경</h2>
		</div>
		<div class="container">
			<div class="container-inner">
				<h5>브라우저</h5>
				<div class="row">
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/edge.png"/>
							</div>
							<div class="dev-card-text">
								Edge
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/chrome.png"/>
							</div>
							<div class="dev-card-text">
								Chrome
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border margin-left" onclick="$('#run-modal').css('display', 'none');">닫기</button>
				<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'run');">확인</button>
			</div>
		</div>
	</div>
</div>
<div id="lan-modal" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-bottom">
		<div class="w3-container">
			<h2>언어</h2>
		</div>
		<div class="container">
			<div class="container-inner">
				<h5>클라이언트</h5>
				<div class="row">
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/html5_css3.png"/>
							</div>
							<div class="dev-card-text">
								HTML5<br>CSS3
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/javascript.png"/>
							</div>
							<div class="dev-card-text">
								JavaScript
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
				</div>
				<h5 class="w3-margin-top">서버</h5>
				<div class="row">
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/java.png"/>
							</div>
							<div class="dev-card-text">
								Java
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border margin-left" onclick="$('#lan-modal').css('display', 'none');">닫기</button>
				<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'lan');">확인</button>
			</div>
		</div>
	</div>
</div>
<div id="lib-modal" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-bottom">
		<div class="w3-container">
			<h2>라이브러리</h2>
		</div>
		<div class="container">
			<div class="container-inner">
				<h5>라이브러리</h5>
				<div class="row">
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/jquery.png"/>
							</div>
							<div class="dev-card-text">
								JQuery
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border margin-left" onclick="$('#lib-modal').css('display', 'none');">닫기</button>
				<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'lib');">확인</button>
			</div>
		</div>
	</div>
</div>
<div id="fra-modal" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-bottom">
		<div class="w3-container">
			<h2>프레임워크</h2>
		</div>
		<div class="container">
			<div class="container-inner">
				<h5>클라이언트</h5>
				<div class="row">
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/bootstrap.png"/>
							</div>
							<div class="dev-card-text">
								Bootstrap4
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
				</div>
				<h5 class="w3-margin-top">서버</h5>
				<div class="row">
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/spring.png"/>
							</div>
							<div class="dev-card-text">
								Spring
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/mybatis.png"/>
							</div>
							<div class="dev-card-text">
								Mybatis
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border margin-left" onclick="$('#fra-modal').css('display', 'none');">닫기</button>
				<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'fra');">확인</button>
			</div>
		</div>
	</div>
</div>
<div id="dba-modal" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-bottom">
		<div class="w3-container">
			<h2>데이터베이스</h2>
		</div>
		<div class="container">
			<div class="container-inner">
				<h5>데이터베이스</h5>
				<div class="row">
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/oracle.png"/>
							</div>
							<div class="dev-card-text">
								Oracle
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border margin-left" onclick="$('#dba-modal').css('display', 'none');">닫기</button>
				<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'dba');">확인</button>
			</div>
		</div>
	</div>
</div>
<div id="api-modal" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-bottom">
		<div class="w3-container">
			<h2>사용기술 / API</h2>
		</div>
		<div class="container">
			<div class="container-inner">
				<div class="api-input">
					<input id="api-name" type="text" placeholder="API명 또는 기술명 입력하세요."/>
					<button class="w3-button w3-right w3-white w3-border" onclick="addApiName($('#api-name'));">추가</button>
				</div>
				<hr>
				<div class="row">
<%-- 					<div class="card-box col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/oracle.png"/>
							</div>
							<div class="dev-card-text">
								Oracle
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div> --%>
				</div>
			</div>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border margin-left" onclick="$('#api-modal').css('display', 'none');">닫기</button>
				<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'api');">확인</button>
			</div>
		</div>
	</div>
</div>
<div id="dem-modal" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-bottom">
		<div class="w3-container">
			<h2>Demo</h2>
		</div>
		<div class="container">
			<div class="container-inner">
				<div class="api-input">
					<input id="demo-url" type="text" placeholder="URL을 입력하세요."/>
					<button class="w3-button w3-right w3-white w3-border" onclick="addDemoUrl($('#demo-url'));">추가</button>
				</div>
				<hr>
				<div class="row">
				</div>
			</div>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border margin-left" onclick="$('#dem-modal').css('display', 'none');">닫기</button>
				<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'dem');">확인</button>
			</div>
		</div>
	</div>
</div>
<div id="git-modal" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-bottom">
		<div class="w3-container">
			<h2>GitHub</h2>
		</div>
		<div class="container">
			<div class="container-inner">
				<div class="api-input">
					<input id="git-url" type="text" placeholder="URL을 입력하세요."/>
					<button class="w3-button w3-right w3-white w3-border" onclick="addGitUrl($('#git-url'));">추가</button>
				</div>
				<hr>
				<div class="row">
				</div>
			</div>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border margin-left" onclick="$('#git-modal').css('display', 'none');">닫기</button>
				<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'git');">확인</button>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
ClassicEditor
	.create( document.querySelector('#media'), {
		placeholder: '상단 툴바를 클릭하여 업로드해주세요.',
	    removePlugins: ['ImageUpload'],
	    toolbar: ['MediaEmbed']
	})
	.then( editor => {
	    myEditor = editor;
	})
	.catch( error => {
		console.error( error );
	})
</script>
</html>