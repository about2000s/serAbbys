<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<section class="page-section">
	<div class = "container">
		<h4><b>${msg }</b></h4>
		<button onclick = "location.href='${cpath}/common/login'" class = "btn btn-primary btn-lg">로그인하러 가기</button>
	</div>
</section>
<%@ include file="../layout/footer.jsp" %>
