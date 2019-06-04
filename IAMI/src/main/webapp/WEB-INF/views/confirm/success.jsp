<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	if("${type}" == "update") {		
		alert("수정되었습니다.");
		location.href="${pageContext.request.contextPath}/notice/view/${no}";
	} else if("${type}" == "delete") {
		alert("삭제되었습니다.");
		location.href="${pageContext.request.contextPath}/notice";
	} else {
		alert("작성되었습니다.");
		location.href="${pageContext.request.contextPath}/notice/view/${no}";
	}
</script>