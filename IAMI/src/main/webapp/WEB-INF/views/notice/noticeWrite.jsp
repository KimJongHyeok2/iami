<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {
	resize();
	$("input[type='radio'][name='cnc_type']").click(function() {
		$(".noticeWrapper .noticeInner .notice-tab label").attr("class", "w3-button");
		var value = $(this).val();
		if(value == 1) {
			$("#label-normal").addClass("activeNormal");
		} else if(value == 2) {
			$("#label-event").addClass("activeEvent");
		}
	});
});
$(window).resize(resize);
function resize() {
	$htmlHeight = $("html").height();
	$headerHeight = $(".headerWrapper").height();
	$navHeight = $(".navWrapper").height();
	$footerHeight = $(".footerWrapper").height();
	
	$(".container-fluid .noticeWrapper").css("min-height", $htmlHeight - $headerHeight - $navHeight - $footerHeight - 61 + "px");
}
</script>
<style>
.noticeWrapper {
	display: flex;
	align-items: center;
	margin: 10px 0;
}
.noticeWrapper .noticeInner {
	flex-grow: 1;
	max-width: 800px;
}
.noticeWrapper .noticeInner .noticeInner-wrapper {
	
}
.noticeWrapper .noticeInner .notice-title {
	font-size: 25pt;
	font-weight: bold;
	text-align: center;
}
.noticeWrapper .noticeInner .notice-title-sub {
	color: gray;
	text-align: center;
}
.noticeWrapper .noticeInner .notice-tab {
	display: flex;
	margin-top: 5px;
}
.noticeWrapper .noticeInner .notice-tab input[type="radio"] {
	display: none;
}
.noticeWrapper .noticeInner .notice-tab label {
	margin-right: 3px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 5px;
	color: rgba(17, 135, 207, 0.7);
}
.noticeWrapper .noticeInner .notice-tab label.activeNormal {
	border: 1px solid #B7F0B1;
	background-color: #B7F0B1;
	color: white;
}
.noticeWrapper .noticeInner .notice-tab label.activeEvent {
	border: 1px solid #F2CB61;
	background-color: #F2CB61;
	color: white;
}
.noticeWrapper .noticeInner .notice-content .notice-content-subject {
	margin-bottom: 7.5px;
}
.noticeWrapper .noticeInner .notice-content .notice-content-subject input[type="text"] {
	width: 100%;
	padding: 10px;
	border: 1px solid #D5D5D5;
}
.noticeWrapper .noticeInner .notice-function {
	margin-top: 5px;
}
.noticeWrapper .noticeInner .notice-function {
	text-align: right;
}
.noticeWrapper .noticeInner .notice-function .btn-write {
	border: 1px solid rgba(17, 135, 207, 0.4);
	color: rgba(17, 135, 207, 0.7);
}
.ck-editor__editable[role='textbox'] {
	min-height: 300px;
}
@media (max-width:800px) {
	.noticeWrapper .noticeInner .noticeInner-wrapper {
		margin: 0 10px;
	}
}
</style>
<script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
<div class="noticeWrapper">
	<div class="noticeInner">
		<div class="noticeInner-wrapper">
			<form>
			<div class="notice-title">
				공지사항 작성
			</div>
			<div class="notice-title-sub">
				<span class="site-name">IAMI</span> 메인 공지사항 작성입니다.
			</div>
			<div class="notice-tab">
				<label for="normal" id="label-normal" class="w3-button">일반</label>
				<input type="radio" id="normal" name="cnc_type" value="1"/>
				<label for="event" id="label-event" class="w3-button last">이벤트</label>
				<input type="radio" id="event" name="cnc_type" value="2"/>
			</div>
			<div class="notice-content">
				<div class="notice-content-subject">
					<input type="text" id="cnc_subject" name="cnc_subject" placeholder="제목을 입력해주세요."/>
				</div>
				<div class="notice-content-content">
					<textarea id="cnc_content"></textarea>
				</div>
			</div>
			<div class="notice-function">
				<div class="w3-button btn-write" onclick="history.back();">
					이전
				</div>
				<div class="w3-button btn-write">
					완료
				</div>
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