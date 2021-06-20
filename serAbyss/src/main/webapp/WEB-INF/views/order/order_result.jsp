<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<script>
	alert("${msg}");
	if('${value}' == ('modify' or 'status_change')) location.href="${cpath}/order/select/${idx}?value=read"
		+ "&page=${param.page }&type=${param.type}&search=${param.search}&status=${param.status}";
	else location.href="${cpath }/order/statusList?page=${param.page }&type=${param.type}"
			+ "&search=${param.search}&status=${param.status}";
</script>

<%@ include file="../layout/footer.jsp" %>