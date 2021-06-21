<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<script>
	alert("${msg}");
	if('${value}' == 'modify') location.href="${cpath }/order/select/${idx}?value=read";
	else location.href="${cpath }/order/statusList?page=1&service_status=";
</script>

<%@ include file="../layout/footer.jsp" %>