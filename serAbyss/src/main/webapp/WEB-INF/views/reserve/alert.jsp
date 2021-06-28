<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<c:set var = "cpath" value = "${pageContext.request.contextPath }"/>
<script>
alert('${msg}')
if('${value}' == 'reserveSuccess' || '${value}' == 'reserveTimeChangeSuccess') location.replace('${cpath}/reserve/read/${reserve_idx}?page=1&reserve_status=')
if('${value}' == 'reserveFail' || '${value}' == 'reserveCancelFail') location.replace('history.go(-1)')
if('${value}' == 'reserveCancel') location.replace('${cpath}')
</script>