<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<script>
	alert("${msg}");
	if('${value}' == 'modify') location.href="${cpath }/reserve/select/${idx}?value=read";
	else location.href="${cpath }/reserve/statusList?page=1&reserve_status=";
</script>

<%@ include file="../layout/footer.jsp" %>