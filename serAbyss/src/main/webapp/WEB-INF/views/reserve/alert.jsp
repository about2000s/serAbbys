<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<c:set var = "cpath" value = "${pageContext.request.contextPath }"/>
<script>
alert('${msg}')
if('${msg}' == '예약 성공' || '${msg}' == '예약시간 변경 성공') location.replace('${cpath}/reserve/read/${reserve_idx}?page=1&status=')
if('${msg}' == '예약 실패' || '${msg}' == '예약시간 변경 실패') location.replace('history.go(-1)')
if('${msg}' == '예약이 취소됨') location.replace('${cpath}')
</script>