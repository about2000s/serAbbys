<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<script>
	alert('${msg}');
	
	if('${value}' == 'myPageUpdateSuccess') location.replace('${cpath}/common/myPage')
	if('${value}' == 'myPageUpdateFail' || '${value}' == 'loginFail' || '${value}' == 'joinFail') location.replace('javascript:history.go(-1)')
	if('${value}' == 'joinSuccess') location.replace('${cpath}')
	else location.replace('javascript:history.go(-1)')
</script>

<%@ include file="../layout/footer.jsp" %>