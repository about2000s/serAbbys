<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>아이디 찾는 곳입니다</h2>

	<label><input type = "radio" name = "any" class = "phone" checked>회원정보에 등록한 휴대전화로 인증</label>
	<label><input type = "radio" name = "any" class = "email">본인확인 이메일로 인증</label><br>

<hr>

<div class = "phone main">
	<h2>회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야, 인증번호를 받을 수 있습니다.</h2>
	<form method = "post" action = "${cpath }/common/findIdByPhone">
		<p><input type = "hidden" name = "person_check" value = "${person_check }"></p>
		<p>이름: <input type = "text" name = "person_name"></p>
		<p>휴대전화: <input type = "text" name = "person_phone"> <button>인증번호 받기</button></p>
		<p><input type = "text" name = "???" placeholder="인증번호 입력"></p>
		<input type = "submit" value = "다음">
	</form>
</div>

<div class = "email main hiddenNone">
	<h2>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</h2>
	<form method = "post" action = "${cpath }/common/findIdByEmail">
		<p><input type = "hidden" name = "person_check" value = "${person_check }"></p>
		<p>이름: <input type = "text" name = "person_name"></p>
		<p>이메일: <input type = "text" name = "person_email"> <button>인증번호 받기</button></p>
		<p><input type = "text" name = "???" placeholder="인증번호 입력"></p>
		<input type = "submit" value = "다음">
	</form>
</div>

<script>
	document.querySelectorAll('label > input').forEach(input => input.onclick = function(event){
		const className = event.target.className
		document.querySelectorAll('div.main').forEach(div => div.classList.add('hiddenNone'))
		document.querySelector('div.' + className).classList.remove('hiddenNone')
	})
</script>

<%@ include file="../layout/footer.jsp" %>