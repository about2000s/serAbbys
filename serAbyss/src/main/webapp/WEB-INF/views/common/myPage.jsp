<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>마이페이지 입니다</h2>
<div>
	<p>아이디: ${login.person_id }</p>
	<p>이메일: ${login.person_email }</p>
	<p>주소: ${login.person_address }</p>
	<p>폰번호: ${login.person_phone }</p>
	<c:if test="${login.person_call != null }">
		<p>유선전화번호: ${login.person_call }</p>
	</c:if>
	<c:if test="${login.person_fax != null }">
		<p>팩스: ${login.person_fax }</p>
	</c:if>
</div>
<button onclick = "location.href='${cpath }/common/updateInfo'">개인정보 수정</button> | 
<button onclick = "location.href='${cpath }/common/updatePw'">비밀번호 변경</button>
<%@ include file="../layout/footer.jsp" %>