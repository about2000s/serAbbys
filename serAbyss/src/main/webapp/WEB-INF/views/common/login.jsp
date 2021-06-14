<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
  
<c:set var = "cpath" value = "${pageContext.request.contextPath }"/>
<link href = "${cpath }/resources/css/css.css" rel="stylesheet">

<div class="logincontainer">
	<h2>Log-in</h2>
	<hr/>
	<div class = "leftbox">
		<h3>개인회원 로그인</h3>
		<form method = "post" action = "${cpath }/common/personLogin">
			<p><input type = "text" name = "person_id" placeholder="아이디" required></p>
			<p><input type = "password" name = "person_pw" placeholder="비밀번호" required></p>
			<p><input type = "submit" value = "로그인"></p>
		</form>
	</div>
	<div class = "rightbox">
		<h3>기업회원 로그인</h3>
		<form method = "post" action = "${cpath }/common/companyLogin">
			<p><input type = "text" name = "person_id" placeholder="아이디" required></p>
			<p><input type = "password" name = "person_pw" placeholder="비밀번호" required></p>
			<p><input type = "submit" value = "로그인"></p>
		</form>
	</div>
	<div class="">
		<p><button>ID 찾기</button> | <button>비밀번호 재발급</button></p>
		<p>회원이 아니세요? <button onclick = "location.href='${cpath}/common/join'">회원가입</button></p>
	</div>

</div>



<%@ include file="../layout/footer.jsp" %>