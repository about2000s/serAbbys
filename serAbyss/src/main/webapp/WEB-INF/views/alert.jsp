<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="layout/header.jsp" %>
<script>
	alert('${msg}')
	if('${msg}' == '회원가입 성공') location.replace('${cpath}')
	if('${msg}' == '회원가입 실패') history.go(-1)
</script>
</body>
</html>