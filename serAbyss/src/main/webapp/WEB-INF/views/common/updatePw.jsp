<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<section class="page-section">
	<div class = "container">
	<h3>비밀번호 변경</h3>
	<hr>
	<h5>기존 비밀번호를 입력하세요</h5>
		<form method = "post">
			<input type = "hidden" name = "person_id" value = "${login.person_id }">
			<input type = "password" name = "person_pw" class= "form-control" style = "width: 15%; display: inline;">
			<input type = "submit" value = "다음" id = "submitBtn" class = "btn btn-primary btn-sm" style = "height: 40px; margin-bottom: 3px;" disabled="disabled">
		</form>
	</div>
</section>

<script>
let pwFlag = false
const submitBtn = document.getElementById('submitBtn')
const pw = document.querySelector('input[name="person_pw"]')
pw.onkeyup = function(event){
	if(pw.value) pwFlag = true
	else pwFlag = false
	check()
}
function check(event){
	if(pwFlag) submitBtn.disabled = false
	else submitBtn.disabled = true
}
</script>

<%@ include file="../layout/footer.jsp" %>
