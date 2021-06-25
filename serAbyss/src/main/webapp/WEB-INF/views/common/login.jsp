<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<section class = "page-section">
<div class="container">
<div class = "row">
	<h2>Log-in</h2>
	<hr>
	<div class = "col-md-6">
		<h3>개인회원 로그인</h3>
		<form method = "post" action = "${cpath }/common/personLogin">
			<input type = "text" name = "person_id" placeholder="아이디" required class = "form-control" style = "width: 30%;">
			<input type = "password" name = "person_pw" placeholder="비밀번호" required class = "form-control" style = "width: 30%;">
			<button class = "btn btn-primary btn-lg" type = "submit">로그인</button>
		</form>
	</div>
	<div class = "col-md-6">
		<h3>기업회원 로그인</h3>
		<form method = "post" action = "${cpath }/common/companyLogin">
			<input type = "text" name = "person_id" placeholder="아이디" required class = "form-control" style = "width: 30%;">
			<input type = "password" name = "person_pw" placeholder="비밀번호" required class = "form-control" style = "width: 30%;">
			<button class = "btn btn-primary btn-lg" type = "submit">로그인</button>
		</form>
	</div>
	<div style = "text-align: center;">
		<button onclick = "location.href='${cpath}/common/selectIndiComp?say=id'" class = "btn btn-primary btn-lg">ID 찾기</button>
		<button onclick = "location.href='${cpath}/common/selectIndiComp?say=pw'" class = "btn btn-primary btn-lg">비밀번호 재발급</button>
	</div>
	<div style = "text-align: center;">
		회원이 아니세요? <button onclick = "location.href='${cpath}/common/join'" class = "btn btn-primary btn-lg">회원가입</button>
	</div>
</div>
</div>
</section>



<%@ include file="../layout/footer.jsp" %>