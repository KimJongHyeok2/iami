<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 삭제</title>
<jsp:include page="/resources/common/common.jsp"/>
<script type="text/javascript">
function deleteComment() {
	var password = $("#password").val();
	var no = "${param.no}";
	var type = "${param.type}";
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	if(password == null || password.length == 0) {
		alert("비밀번호를 입력해주세요.");
		return false;
	}
	
	var confirms = confirm("정말 삭제하시겠습니까?");
	if(confirms) {
		if(type == 1) {
			$.ajax({
				url: "${pageContext.request.contextPath}/portfolio/comment/delete",
				type: "POST",
				cache: false,
				data: {
					"com_no" : no,
					"com_pw" : password,
					"com_type" : 1
				},
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success: function(data, status) {
					if(status == "success") {
						if(data == "Ok") {
							alert("삭제되었습니다.");
							opener.deleteCommentOk("Ok");
							window.close();
						} else if(data == "Wrong") {
							alert("비밀번호가 일치하지 않습니다.");
						} else {
							alert("알 수 없는 오류입니다.");
						}
					}
				}
			});
		} else {
			$.ajax({
				url: "${pageContext.request.contextPath}/portfolio/recomment/delete",
				type: "POST",
				cache: false,
				data: {
					"rcom_no" : no,
					"rcom_pw" : password,
					"rcom_type" : 1
				},
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success: function(data, status) {
					if(status == "success") {
						if(data == "Ok") {
							alert("삭제되었습니다.");
							opener.deleteCommentOk("Ok");
							window.close();
						} else if(data == "Wrong") {
							alert("비밀번호가 일치하지 않습니다.");
						} else {
							alert("알 수 없는 오류입니다.");
						}
					}
				}
			});
		}
	}
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/delete.css">
</head>
<body>
<div class="container-fluid">
	<div class="container-inner">
		<div class="row">
			<div class="content col-12">
				<input type="password" id="password" placeholder="비밀번호"/>
			</div>
			<div class="content col-6">
				<button class="w3-button delete" onclick="deleteComment();">삭제</button>
			</div>
			<div class="content col-6">
				<button class="w3-button cancle" onclick='window.close();'>닫기</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>