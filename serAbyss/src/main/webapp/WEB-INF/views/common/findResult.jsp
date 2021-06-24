<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<div>
	<p>${msg }</p>
	<button onclick = "history.go(-1)">다시 돌아가기</button>
	<button onclick = "location.href='${cpath}/common/login'">로그인하러 가기</button>
</div>
<%@ include file="../layout/footer.jsp" %>
