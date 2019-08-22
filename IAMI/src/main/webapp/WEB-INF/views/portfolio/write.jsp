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
var $thumb = "";
var $files = new Array();
$(document).ready(function() {
	resize_write();
	// 날짜 선택 오픈소스 flatpickr Set
	$(".dateSelector").flatpickr({ 
		dateFormat: "Y-m-d",
	});
	// CKEditor5 Set
	$(".ck-editor__editable[role='textbox']").on("keyup", function() {
		myEditor.setData("");
	});
});
$(window).resize(function()	{
	resize_html();
	resize_next_res();
});
function resize_write() {
	var $htmlHeight = $("html").height();
	var $headerHeight = $(".header").height();
	var $footerHeight = $(".footerWrapper").height();
	var $contentHeight = $("#one").height();
	$(".allWrapper").css("min-height", $htmlHeight - $headerHeight - $footerHeight - 41 + "px");
	$(".contentInner").css("min-height", $contentHeight + 30 + "px");
}
function resize_html() {
	var $htmlHeight = $("html").height();
	var $headerHeight = $(".header").height();
	var $footerHeight = $(".footerWrapper").height();
	$(".allWrapper").css("min-height", $htmlHeight - $headerHeight - $footerHeight - 41 + "px");
}
// 이전/다음 버튼 클릭 시 3초 딜레이
function button_delay() {
	$("#btn-prev").attr("disabled", "disabled");
	$("#btn-next").attr("disabled", "disabled");
	$("#btn-writeOk").attr("disabled", "disabled");
	$("#btn-prev").html("<div class='spinner-border spinner-border-sm text-iami'></div>")
	$("#btn-next").html("<div class='spinner-border spinner-border-sm text-iami'></div>")
	$("#btn-writeOk").html("<div class='spinner-border spinner-border-sm text-iami'></div>")
	setTimeout(function() {
		$("#btn-prev").removeAttr("disabled", "disabled");
		$("#btn-next").removeAttr("disabled", "disabled");
		$("#btn-writeOk").removeAttr("disabled", "disabled");
		$("#btn-prev").html("이전");
		$("#btn-next").html("다음");
		$("#btn-writeOk").html("완료");
	}, 3000);
}
//자식 div (position:absoulte) 높이에 따른 부모 div 크기 조정
function resize_next_res() {
	if($currContent == 2) {
		var contentHeight = $("#two").height();
		$(".contentInner").css("min-height", contentHeight + 30 + "px");
	} else if($currContent == 3) {
		var contentHeight = $("#three").height();
		$(".contentInner").css("min-height", contentHeight + 30 + "px");		
	} else if($currContent == 4) {
		var contentHeight = $("#four").height();
		$(".contentInner").css("min-height", contentHeight + 30 + "px");		
	} else if($currContent == 5) {
		var contentHeight = $("#five").height();
		$(".contentInner").css("min-height", contentHeight + 30 + "px");		
	}
}
// 자식 div (position:absoulte) 높이에 따른 부모 div 크기 조정  
function resize_prev_res() {
	if($currContent == 4) {
		var contentHeight = $("#four").height();
		$(".contentInner").css("min-height", contentHeight + 30 + "px");
	} else if($currContent == 3) {
		var contentHeight = $("#three").height();
		$(".contentInner").css("min-height", contentHeight + 30 + "px");		
	} else if($currContent == 2) {
		var contentHeight = $("#two").height();
		$(".contentInner").css("min-height", contentHeight + 30 + "px");		
	} else if($currContent == 1) {
		var contentHeight = $("#one").height();
		$(".contentInner").css("min-height", contentHeight + 30 + "px");		
	}
}
// 이전 버튼 클릭 시
function prev() {
	button_delay();
	if($currContent == 1) {
		return false;
	} else if($currContent == 2){
		$("#two").removeClass("animated fadeInRightBig");
		$("#two").addClass("animated fadeOutRightBig");
		$("#one").removeClass("animated fadeOutLeftBig");		
		$("#one").addClass("animated fadeInLeftBig");
		$("#circle-2").removeClass("spinner-grow spinner");
		$("#circle-2").addClass("normal-circle");
		$("#circle-1").removeClass("normal-circle clear");
		$("#circle-1").addClass("spinner-grow spinner");
		$("#hr-1").removeClass("clear");
		$("#btn-prev").css("display", "none");
		prevProgress();
	} else if($currContent == 3) {
		$("#three").removeClass("animated fadeInRightBig");
		$("#three").addClass("animated fadeOutRightBig");
		$("#two").removeClass("animated fadeOutLeftBig");		
		$("#two").addClass("animated fadeInLeftBig");
		$("#circle-3").removeClass("spinner-grow spinner");
		$("#circle-3").addClass("normal-circle");
		$("#circle-2").removeClass("normal-circle clear");
		$("#circle-2").addClass("spinner-grow spinner");
		$("#hr-2").removeClass("clear");
		prevProgress();
	} else if($currContent == 4) {
		$("#four").removeClass("animated fadeInRightBig");
		$("#four").addClass("animated fadeOutRightBig");
		$("#three").removeClass("animated fadeOutLeftBig");		
		$("#three").addClass("animated fadeInLeftBig");
		$("#circle-4").removeClass("spinner-grow spinner");
		$("#circle-4").addClass("normal-circle");
		$("#circle-3").removeClass("normal-circle clear");
		$("#circle-3").addClass("spinner-grow spinner");
		$("#hr-3").removeClass("clear");
		prevProgress();
	} else if($currContent == 5) {
		$("#five").removeClass("animated fadeInRightBig");
		$("#five").addClass("animated fadeOutRightBig");
		$("#four").removeClass("animated fadeOutLeftBig");		
		$("#four").addClass("animated fadeInLeftBig");
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
// 다음 버튼 클릭 시
function next() {
	button_delay()
	if($currContent == 1) {
		if(!step1Valid()) {
			return false;
		}
		$("#one").removeClass("animated fadeInLeftBig");
		$("#one").removeClass("animated fadeInRightBig");
		$("#one").addClass("animated fadeOutLeftBig");
		$("#two").css("display", "block");
		$("#two").removeClass("animated fadeOutRightBig");
		$("#two").removeClass("animated fadeOutLeftBig");
		$("#two").addClass("animated fadeInRightBig");
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
		$("#two").removeClass("animated fadeInLeftBig");
		$("#two").removeClass("animated fadeInRightBig");
		$("#two").addClass("animated fadeOutLeftBig");
		$("#three").css("display", "block");
		$("#three").removeClass("animated fadeOutRightBig");
		$("#three").removeClass("animated fadeOutLeftBig");
		$("#three").addClass("animated fadeInRightBig");
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
		$("#three").removeClass("animated fadeInLeftBig");
		$("#three").removeClass("animated fadeInRightBig");
		$("#three").addClass("animated fadeOutLeftBig");
		$("#four").css("display", "block");
		$("#four").removeClass("animated fadeOutRightBig");
		$("#four").removeClass("animated fadeOutLeftBig");
		$("#four").addClass("animated fadeInRightBig");
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
		$("#four").removeClass("animated fadeInLeftBig");
		$("#four").removeClass("animated fadeInRightBig");
		$("#four").addClass("animated fadeOutLeftBig");
		$("#five").css("display", "block");
		$("#five").removeClass("animated fadeOutRightBig");
		$("#five").removeClass("animated fadeOutLeftBig");
		$("#five").addClass("animated fadeInRightBig");
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
//모바일용 ProgressBar(다음 클릭 시)
function nextProgress() {
	var $start = setInterval(onProgress, 20);
	function onProgress() {
		if($currContent == 1) {
			if($width >= 40) {
				clearInterval($start);
				$currContent += 1;
				resize_next_res();
				$("#one").css("display", "none");
			} else {
				$width++;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 2) {
			if($width >= 60) {
				clearInterval($start);
				$currContent += 1;
				resize_next_res();
				$("#two").css("display", "none");
			} else {
				$width++;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 3) {
			if($width >= 80) {
				clearInterval($start);
				$currContent += 1;
				resize_next_res();
				$("#three").css("display", "none");
			} else {
				$width++;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 4) {
			if($width >= 100) {
				clearInterval($start);
				$currContent += 1;
				resize_next_res();
				$("#four").css("display", "none");
			} else {
				$width++;
				$("#bar").css("width", $width + "%");
			}
		}
	}
}
// 모바일용 ProgressBar(이전 클릭 시) 
function prevProgress() {
	var $start = setInterval(onProgress, 10);
	function onProgress() {
		if($currContent == 5) {
			if($width == 80) {
				clearInterval($start);
				$currContent -= 1;
				resize_prev_res();
				$("#five").css("display", "none");
				$("#four").css("display", "block");
			} else {
				$width--;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 4) {
			if($width == 60) {
				clearInterval($start);
				$currContent -= 1;
				resize_prev_res();
				$("#four").css("display", "none");
				$("#three").css("display", "block");
			} else {
				$width--;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 3) {
			if($width == 40) {
				clearInterval($start);
				$currContent -= 1;
				resize_prev_res();
				$("#three").css("display", "none");
				$("#two").css("display", "block");
			} else {
				$width--;
				$("#bar").css("width", $width + "%");
			}
		} else if($currContent == 2) {
			if($width == 20) {
				clearInterval($start);
				$currContent -= 1;
				resize_prev_res();
				$("#two").css("display", "none");
				$("#one").css("display", "block");
			} else {
				$width--;
				$("#bar").css("width", $width + "%");
			}
		}
	}
}
// 주요환경 모달 띄우기
function openModal(type) {
	$("#" + type + "-modal").css("display", "block");
}
// 주요환경 항목 카드 클릭 시
function cardSelected(card) {
	var $isSelected = $(card).parent(".card-box");
	$(card).find(".fa-check").toggle();
	if($isSelected.attr("class").indexOf("select") == -1) {
		$isSelected.addClass("select");
	} else {
		$isSelected.removeClass("select");
	}
}
// 섬네일 업로드
function addThumbnail(obj) {
	var fileName = obj.files[0].name;
	var fileSize = obj.files[0].size;
	var maxSize = 10 * 1024 * 1024;
	var ext = fileName.substr(fileName.lastIndexOf(".")+1, fileName.length);
	
	if(!($.inArray(ext.toLowerCase(), ["jpg", "jpeg", "jpe", "png", "git"]) >= 0)) {
		alert("이미지 파일을 업로드해주세요.");
		return false;
	}
	
	if(fileSize > maxSize){
		alert("10MB 이하의 이미지 파일만 허용됩니다.");
		return false;
	}
	
	var formData = new FormData();
	formData.append("thumbnail", obj.files[0]);
	
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	$.ajax({
		url: "${pageContext.request.contextPath}/upload/thumbnail",
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
					$(".thumbnail").html("<img class='tempThumb' src='${pageContext.request.contextPath}/resources/upload/" + data.name + "' />");
					$thumb = data.name;
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});
}
// 주요환경 항목 추가
function addEnvironment(obj, type) {
	var $parentObject = $(obj).parent("div").parent("div").find(".container-inner");
	var $findObject = $parentObject.find(".dev-card").parent(".card-box.select").find(".dev-card");
	var $selectCount = $parentObject.find(".dev-card").parent(".card-box.select").length;
	var $emptyFlag = false;
	var $addCount = 1;
	$("#" + type + "_environment .container .row").html("");
	
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
			$("#" + type + "_environment .container .row").append($isSelected.html());
			$(this).attr("onclick", "cardSelected(this);"); 
			$(this).removeClass($column);
			$(this).removeClass("margin-card");
			$addCount += 1;
		}
		
	});
	if(!$emptyFlag) {
		if(type == "api") {
			$("#" + type + "_environment .container .row").html("<div class='empty col-12'>등록이 필요합니다.(선택)</div>");			
		} else if(type == "file") {
			$files = new Array();
			$("#" + type + "_environment .container .row").html("<div class='empty col-12'>등록이 필요합니다.(선택)</div>");
		} else {
			$("#" + type + "_environment .container .row").html("<div class='empty col-12'>등록이 필요합니다.</div>");						
		}
	}

	resize_next_res();
	$("#" + type + "-modal").css("display", "none");
}
// 사용기술 / API명 추가
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
// 데모 사이트 URL 추가
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
// GitHub URL 추가
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
// 첨부파일 추가
function addFile(obj) {
	var fileName = obj.files[0].name;
	var fileSize = obj.files[0].size;
	var maxSize = 10 * 1024 * 1024;
	
	if(fileSize > maxSize){
		alert("10MB 이하의 파일만 허용됩니다.");
		return false;
	}
	
	var formData = new FormData();
	formData.append("file", obj.files[0]);
	
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	var count = $("#file").parent("div").parent("div").find(".row").find(".card-box").length;
	
	if(count >= 3  || $files.length >= 3) {
		alert("더 이상 등록할 수 없습니다.");
		return false;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/upload/file",
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
				if(data != "Fail") {
					$files.push(data);
					var html = "";
					var ext = data.substr(data.lastIndexOf(".")+1, data.length);
					
					html += "<div class='card-box margin-card " + (count >= 3? 'margin-top':'') + " col-sm-12 col-md-3'>";
						html += "<div class='dev-card' onclick='cardSelected(this);'>";
							html += "<div class='dev-card-text api'>";
								if($.inArray(ext.toLowerCase(), ["jpg", "jpeg", "jpe", "png", "git"]) >= 0) {									
									html += "<i class='far fa-image'></i>";
								} else {
									html += "<i class='far fa-file'></i>";
								}
								html += " " + data;
							html += "<input type='hidden' value='" + data + "' />";
							html += "</div>";
							html += "<i class='fas fa-check'></i>";
						html += "</div>";
					html += "</div>";
					
					$("#file").parent("div").parent("div").find(".row").append(html);
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});

}
//스텝1 유효성 검사
function step1Valid() {
	var $subject = $("#pot_subject").val();
	var $description = $("#pot_description").val();
	
	if($subject.length < 5 || $subject.length > 20) {
		alert("제목은 5자 이상 20자 이하로 입력해주세요.");
		return false;
	}
	if($description.length < 10) {
		alert("설명은 10자 이상으로 입력해주세요.");
		return false;
	}
	
	return true;
}
//스텝2 유효성 검사
function step2Valid() {
	var $summary = $("#pot_summary").val();
	var $startDate = $("#pot_startDate").val();
	var $endDate = $("#pot_endDate").val();

	if($summary.length < 10) {
		alert("주요기능은 10자 이상으로 입력해주세요.");
		return false;
	}
	if($startDate.length == 0 || $endDate.length == 0) {
		alert("기간을 선택해주세요.");
		return false;
	}
	
	return true;
}
//스텝3 유효성 검사
function step3Valid() {
	var $warEnvCount = $("#war_environment").find(".empty").length;
	var $devEnvCount = $("#dev_environment").find(".empty").length;
	var $runEnvCount = $("#run_environment").find(".empty").length;
	var $lanEnvCount = $("#lan_environment").find(".empty").length;
	var $libEnvCount = $("#lib_environment").find(".empty").length;
	var $fraEnvCount = $("#fra_environment").find(".empty").length;
	var $dbaEnvCount = $("#dba_environment").find(".empty").length;

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
// 스텝4 유효성 검사
function step4Valid() {
	var $thumb2 = $(".thumbnail").find(".tempThumb").length;
	var $media = myEditor.getData();
	
	if($thumb2 == 0) {
		alert("섬네일을 업로드해주세요.");
		return false;
	}

	if($media.indexOf("oembed") == -1) {
		alert("동영상을 업로드해주세요.");
		return false;
	}
	
	return true;
}
// 스텝5 유효성 검사
function step5Valid() {
	var $demoEnvCount = $("#dem_environment").find(".empty").length;
	var $gitEnvCount = $("#git_environment").find(".empty").length;

	if($demoEnvCount != 0) {
		alert("Demo URL을 입력해주세요.");
		return false;
	} else if($gitEnvCount != 0) {
		alert("GitHub URL을 입력해주세요.");
		return false;		
	}
	
	return true;
}
// 포트폴리오 업로드
function writeOk() {
	if(step1Valid() && step2Valid() && step3Valid() && step4Valid() && step5Valid()) {
		var $subject = $("#pot_subject").val();
		var $description = $("#pot_description").val();
		var $summary = $("#pot_summary").val();
		var $startdate = $("#pot_startDate").val();
		var $enddate = $("#pot_endDate").val();
		var $environment = $("#pot_environment").html();
		var $video = myEditor.getData();
		var $source = $("#pot_source").html();
		var header = "${_csrf.headerName}";
		var token = "${_csrf.token}";
		
		$.ajax({
			url: "${pageContext.request.contextPath}/portfolio/writeOk",
			type: "POST",
			cache: false,
			data: {
				"mem_no" : ${empty sessionScope.mem_no? 0:sessionScope.mem_no},
				"pot_subject" : $subject,
				"pot_description" : $description,
				"pot_summary" : $summary,
				"pot_startdate" : $startdate,
				"pot_enddate" : $enddate,
				"pot_environment" : $environment,
				"pot_thumbnail" : $thumb,
				"pot_video" : $video,
				"pot_source" : $source,
				"files" : JSON.stringify($files).slice(1).slice(0, -1).replace(/\"/g, "")
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data != "Fail") {
						alert("업로드되었습니다.");
						location.href = "${pageContext.request.contextPath}/";
					} else {
						alert("알 수 없는 오류입니다.");
					}
				}
			}
		});
	}
}
</script>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/image/main/icon.ico">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/write.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
</head>
<body>
<div class="header w3-animate-top">
	<a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/image/main/logo.png"/></a>
</div>
<div class="allWrapper">
	<div class="allWrapperInner">
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
							<input id="pot_subject" name="pot_subject" type="text" placeholder="5자 이상 20자 이하"/>
						</div>
					</div>
					<div class="description">
						<div class="description-title">
							<h6>설명</h6>
						</div>
						<div class="description-input">
							<textarea id="pot_description" name="pot_description" placeholder="5자 이상 30자 이하"></textarea>
						</div>
					</div>
				</div>
				<div id="two" class="content">
					<div class="title">
						<h5>주요기능 및 기간을 입력해주세요.</h5>
					</div>
					<div class="summary">
						<div class="summary-title">
							<h6>주요기능</h6>
						</div>
						<div class="summary-input">
							<textarea id="pot_summary" name="pot_summary" placeholder="10자 이상"></textarea>
						</div>
					</div>
					<div class="date">
						<div class="date-title">
							<h6>기간</h6>
						</div>
						<div class="date-input">
							<div class="container">
								<div class="row">
									<input type="text" id="pot_startDate" name="pot_startDate" class="dateSelector start col-sm-6" placeholder="시작일"/><input type="text" id="pot_endDate" name="pot_endDate" class="dateSelector end col-sm-6" placeholder="종료일"/>
								</div>
							</div>
						</div>
					</div>
					<div style="margin-bottom: 5px;"></div>
				</div>
				<div id="three" class="content">
					<div class="title">
						<h5>주요환경을 선택해주세요.</h5>
					</div>
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
										등록이 필요합니다.(선택)
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="four" class="content">
					<div class="title">
						<h5>섬네일과 동영상을 업로드해주세요.</h5>
					</div>
					<div class="environment">
						<div class="environment-title">
							<h6>섬네일</h6>
						</div>
						<div class="environment-input">
							<label class="thumbnail" for="thumbnail"><i class="far fa-image fa-5x"></i></label>
							<input type="file" id="thumbnail" onchange="addThumbnail(this);"/>
						</div>
					</div>
					<div class="environment">
						<div class="environment-title margin-title">
							<h6>동영상</h6>
						</div>
						<div class="environment-input">
							<textarea id="media"></textarea>
						</div>
					</div>
				</div>
				<div id="five" class="content">
					<div class="title">
						<h5>Demo와 GitHub URL 또는 첨부파일을 추가해주세요.</h5>
					</div>
					<div id="pot_source" class="environment">
						<div class="environment-title">
							<div>Demo</div><div class="btn-add" onclick="openModal('dem');"><i class="fas fa-plus"></i></div>
						</div>
						<div id="dem_environment" class="environment-input">
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
						<div id="git_environment" class="environment-input">
							<div class="container">
								<div class="row">
									<div class="empty col-12">
										등록이 필요합니다.
									</div>
								</div>
							</div>
						</div>
						<div id="file_environment_title" class="environment-title margin-title">
							<div>첨부파일</div><div class="btn-add" onclick="openModal('file');"><i class="fas fa-plus"></i></div>
						</div>
						<div id="file_environment" class="environment-input">
							<div class="container">
								<div class="row">
									<div class="empty col-12">
										등록이 필요합니다.(선택)
									</div>
								</div>
							</div>
						</div>
					</div>
					<div style="margin-bottom: 5px;"></div>
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
	</div>
</div>
<jsp:include page="/resources/include/footer/footer.jsp"/>
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
								Windows Server 2016
							</div>
							<i class="fas fa-check"></i>
						</div>
					</div>
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/ubuntu.png"/>
							</div>
							<div class="dev-card-text">
								Ubuntu 18.04 LTS
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
					<div class="card-box margin-card col-sm-12 col-md-3">
						<div class="dev-card" onclick="cardSelected(this);">
							<div class="dev-card-img">
								<img src="${pageContext.request.contextPath}/resources/image/write/mysql.png"/>
							</div>
							<div class="dev-card-text">
								MySQL
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
<div id="file-modal" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-bottom">
		<div class="w3-container">
			<h2>첨부파일</h2>
		</div>
		<div class="container">
			<div class="container-inner">
				<div class="api-input">
					<label for="file" class="file-upload-btn"><i class="fas fa-file-upload fa-2x"></i></label>
					<input type="file" id="file" onchange="addFile(this);"/>
<!-- 					<button class="w3-button w3-right w3-white w3-border" onclick="addGitUrl($('#git-url'));"><i class="fas fa-search"></i></button> -->
				</div>
				<hr>
				<div class="row">
				</div>
			</div>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border margin-left" onclick="$('#file-modal').css('display', 'none');">닫기</button>
				<button class="w3-button w3-right w3-white w3-border" onclick="addEnvironment(this, 'file');">확인</button>
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