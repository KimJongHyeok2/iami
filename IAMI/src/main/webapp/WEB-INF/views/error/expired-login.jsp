<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
alert("중복 로그인이 발생하여 로그아웃됩니다.")
location.href = "${pageContext.request.contextPath}/login";
</script>