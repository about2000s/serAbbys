<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>비밀번호 수정하는 페이지!</h2>
<div>
	<form id = "repwCheck" method = "post" action = "pwUpdateResult">
		<p><input type = "hidden" name = "person_id" value = "${login.person_id }"></p>
		<p>새 비밀번호 입력: <input type = "password" name = "person_pw"></p>
		<p>새 비밀번호 확인: <input type = "password" name = "person_pw2"></p>
		<input type = "submit" value = "다음">
	</form>
</div>
<script>
	document.getElementById('repwCheck').onsubmit = function(event){
		event.preventDefault()
		const person_pw = event.target.querySelector('input[name="person_pw"]').value
		const person_pw2 = event.target.querySelector('input[name="person_pw2"]').value
		if(person_pw != person_pw2){
			alert('비밀번호가 일치하지 않습니다.')
		}
		else{
			event.target.submit()
		}
	}
</script>
<%@ include file="../layout/footer.jsp" %>