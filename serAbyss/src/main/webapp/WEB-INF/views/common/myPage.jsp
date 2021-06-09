<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>마이페이지 입니다</h2>
<div>
	<p>아이디: </p>
	<p>이메일: </p>
	<p>주소: </p>
	<p>폰번호: </p>
	<p>유선전화번호: </p><!-- login.person_call != null일 때만 띄우기 -->
	<p>팩스: </p><!-- login.person_fax != null일 때만 띄우기 -->
</div>
<button onclick = "location.href='${cpath}/common/updateInfo">개인정보 수정</button> | 
<button onclick = "location.href='${cpath}/common/updatePw">비밀번호 변경</button>
<%@ include file="../layout/header.jsp" %>