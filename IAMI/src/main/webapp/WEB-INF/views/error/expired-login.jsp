<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
var $confirm_Flag = confirm("중복 로그인이 발생하여 로그아웃됩니다.");

if($confirm_Flag) {
	location.href = "${pageContext.request.contextPath}/login";
} else {
	location.href = "${pageContext.request.contextPath}/login";	
}
</script>