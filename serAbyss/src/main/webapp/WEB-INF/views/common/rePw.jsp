<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>비밀번호 재발급 페이지 입니다.</h2>
<h2>개인회원, 기업회원을 선택해 주세요</h2>
<label><input type = "radio" name = "???">개인회원</label>
<label><input type = "radio" name = "???">기업회원</label>

<label><input type = "radio" name = "???">회원정보에 등록한 휴대전화로 인증</label>

<div>
	<h2>회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야, 인증번호를 받을 수 있습니다.</h2>
	<form method = "post" action = "${cpath }/common/repwByPhone">
		<p><input type = "text" name = "person_id" placeholder="아이디"></p>
		<p><input type = "text" name = "person_phone" placeholder="전화번호"><button>인증번호 받기</button></p>
		<input type = "submit" value = "다음">
	</form>
</div>

<label><input type = "radio" name = "???">본인확인 이메일로 인증</label>

<div>
	<h2>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</h2>
	<form method = "post" action = "${cpath }/common/repwByEmail">
		<p><input type = "text" name = "person_id" placeholder="아이디"></p>
		<p><input type = "text" name = "person_phone" placeholder="전화번호"><button>인증번호 받기</button></p>
		<input type = "submit" value = "다음">
	</form>
</div>
<%@ include file="../layout/footer.jsp" %>
