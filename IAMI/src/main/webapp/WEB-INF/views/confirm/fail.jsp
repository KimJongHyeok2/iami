<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	if("${type}" == "alreadyDelete") {
		alert("이미 삭제되었거나 존재하지 않는 글입니다.");
		history.back();
	} else {
		alert("알 수 없는 오류입니다.");
		history.back();
	}
</script>