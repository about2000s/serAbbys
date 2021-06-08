<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>로그인하는 곳입니다.</h2>
<div class = "left-box">
	<h2>개인회원 로그인</h2>
	<form>
		<p><input type = "text" name = "person_id" placeholder="아이디" required></p>
		<p><input type = "password" name = "person_pw" placeholder="비밀번호" required></p>
		<input type = "submit" value = "로그인">
	</form>
</div>
<div class = "right-box">
	<h2>기업회원 로그인</h2>
	<form>
		<p><input type = "text" name = "admin_id" placeholder="아이디" required></p>
		<p><input type = "password" name = "admin_pw" placeholder="비밀번호" required></p>
		<input type = "submit" value = "로그인">
	</form>
</div>
<%@ include file="../layout/footer.jsp" %>