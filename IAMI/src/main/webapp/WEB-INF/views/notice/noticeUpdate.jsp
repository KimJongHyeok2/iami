<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<script>
$(document).ready(function() {
	resize();
	$("input[type='radio'][name='type']").click(function() {
		$(".noticeWrapper .noticeInner .notice-tab label").attr("class", "w3-button");
		var value = $(this).val();
		if(value == 1) {
			$("#label-normal").addClass("activeNormal");
		} else if(value == 2) {
			$("#label-event").addClass("activeEvent");
		}
	});
	if("${dto.cnc_type}" == 1) {
		$("#normal").click();
	} else {
		$("#event").click();		
	}
});
$(window).resize(resize);
function resize() {
	$htmlHeight = $("html").height();
	$headerHeight = $(".headerWrapper").height();
	$navHeight = $(".navWrapper").height();
	$footerHeight = $(".footerWrapper").height();
	
	$(".container-fluid .noticeWrapper").css("min-height", $htmlHeight - $headerHeight - $navHeight - $footerHeight - 61 + "px");
}
function updateValid(obj) {
	var subject = obj["cnc_subject"].value;
	var content = myEditor.getData();
	var typeFlag = false;
	
	if(content.indexOf('<figure class="image">') != -1) {
		$("#cnc_hasImage").val(1);
	} else {
		$("#cnc_hasImage").val(0);
	}
	if(content.indexOf('<figure class="media">') != -1) {
		$("#cnc_hasVideo").val(1);
	} else {
		$("#cnc_hasVideo").val(0);
	}
	
	$(obj["type"]).each(function() {
		if($(this).is(":checked")) {
			typeFlag = true;
			$("#cnc_type").val($(this).val());
		}
	});
	
	if(!typeFlag) {
		alert("상단의 공지사항 타입을 선택해주세요.");
		return false;
	}
	
	if(subject.length < 5 || subject.length > 30) {
		alert("제목은 5자 이상 30자 이하로 입력해주세요.");
		return false;
	}
	if(content.length == 0) {
		alert("내용을 입력해주세요.");
		return false;
	}
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/noticeWrite.css">
<script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
<div class="noticeWrapper">
	<div class="noticeInner">
		<div class="noticeInner-wrapper">
			<form action="updateOk" method="post" onsubmit="return updateValid(this);">
			<div class="notice-title">
				공지사항 작성
			</div>
			<div class="notice-title-sub">
				<span class="site-name">IAMI</span> 메인 공지사항 작성입니다.
			</div>
			<div class="notice-tab">
				<label for="normal" id="label-normal" class="w3-button">일반</label>
				<input type="radio" id="normal" name="type" value="1"/>
				<label for="event" id="label-event" class="w3-button last">이벤트</label>
				<input type="radio" id="event" name="type" value="2"/>
				<input type="hidden" id="cnc_type" name="cnc_type" value="${dto.cnc_type}"/>
			</div>
			<div class="notice-content">
				<div class="notice-content-subject">
					<input type="text" id="cnc_subject" name="cnc_subject" value="${dto.cnc_subject}" placeholder="제목을 입력해주세요."/>
				</div>
				<div class="notice-content-content">
					<textarea id="cnc_content" name="cnc_content">${dto.cnc_content}</textarea>
				</div>
				<input type="hidden" id="cnc_no" name="cnc_no" value="${dto.cnc_no}"/>
				<input type="hidden" id="cnc_hasImage" name="cnc_hasImage" value="${dto.cnc_hasImage}"/>
				<input type="hidden" id="cnc_hasVideo" name="cnc_hasVideo" value="${dto.cnc_hasVideo}"/>
			</div>
			<s:csrfInput/>
			<div class="notice-function">
				<div class="w3-button btn-write" onclick="history.back();">
					이전
				</div>
				<button type="submit" class="w3-button btn-write">
					완료
				</button>
			</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
ClassicEditor
	.create( document.querySelector('#cnc_content'), {
		placeholder: '내용을 입력해주세요.',
		ckfinder: {
	        uploadUrl: '${pageContext.request.contextPath}/upload/notice/image?${_csrf.parameterName}=${_csrf.token}'
	    },
	})
	.then( editor => {
	    myEditor = editor;
	})
	.catch( error => {
		console.error( error );
	})
</script>