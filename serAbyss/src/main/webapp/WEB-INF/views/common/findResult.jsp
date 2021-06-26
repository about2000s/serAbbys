<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<div class = "container">
	<p>${msg }</p>
	<button onclick = "history.go(-1)" class = "btn btn-primary btn-xl">다시 돌아가기</button>
	<button onclick = "location.href='${cpath}/common/login'" class = "btn btn-primary btn-xl">로그인하러 가기</button>
</div>
<%@ include file="../layout/footer.jsp" %>
