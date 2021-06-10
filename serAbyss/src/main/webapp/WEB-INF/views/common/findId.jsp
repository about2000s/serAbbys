<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>아이디 찾는 곳입니다</h2>

<div>
<h2>개인회원, 기업회원을 선택해 주세요</h2>
	<label><input type = "radio" name = "">개인회원</label>
	<label><input type = "radio" name = "">기업회원</label>
</div>

<div>
	<label><input type = "radio" name = "">회원정보에 등록한 휴대전화로 인증</label><br>
</div>

<div class = "phone main hidden">
	<h2>회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야, 인증번호를 받을 수 있습니다.</h2>
	<form method = "post" action = "${cpath }/common/findIdByPhone">
		<p>이름: <input type = "text" name = "member_name"></p>
		<p>휴대전화: <input type = "text" name = "member_phone"> <button>인증번호 받기</button></p>
		<p><input type = "text" name = "???" placeholder="인증번호 입력"></p>
		<input type = "submit" value = "다음">
	</form>
</div>

<div>
	<label><input type = "radio" name = "">본인확인 이메일로 인증</label><br>
</div>

<div class = "email main hidden">
	<h2>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</h2>
	<form method = "post" action = "${cpath }/common/findIdByEmail">
		<p>이름: <input type = "text" name = "member_name"></p>
		<p>이메일: <input type = "text" name = "member_email"> <button>인증번호 받기</button></p>
		<p><input type = "text" name = "???" placeholder="인증번호 입력"></p>
		<input type = "submit" value = "다음">
	</form>
</div>

<%@ include file="../layout/footer.jsp" %>