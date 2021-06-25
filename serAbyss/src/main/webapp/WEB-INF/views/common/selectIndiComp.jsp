<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<div class = "container">
	<form method = "post">
	<h2>개인회원, 기업회원을 선택해 주세요</h2>
		<input type = "hidden" name = "say" value = ${say }>
		<label><input type = "radio" name = "person_check" value = "n" checked class = "form-check-input">개인회원</label>
		<label><input type = "radio" name = "person_check" value = "y" class = "form-check-input">기업회원</label>
		<input type = "submit" value = "다음" class = "btn btn-primary btn-lg">
	</form>
</div>
<%@ include file="../layout/footer.jsp" %>