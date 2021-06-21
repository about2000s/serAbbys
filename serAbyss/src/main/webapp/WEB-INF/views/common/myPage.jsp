<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>마이페이지 입니다</h2>
<div class="container">
	<table>
		<tr>
			<th width="100px"><p>아이디: </p></th>
			<td>${login.person_id }</td>
		</tr>
		<tr>
			<th>이메일: </th>
			<td>${login.person_email }</td>
		</tr>
		<tr>
			<th>주소:</th>
			<td>${login.person_address }</td>
		</tr>
		<tr>
			<th>폰번호: </th>
			<td>${login.person_phone }</td>
		</tr>
		<tr>
			<th>주소:</th>
			<td>${login.person_address }</td>
		</tr>
		<tr>
			<c:if test="${login.person_call != null }">
			<th>유선전화번호:<th>
			<td>${login.person_call }</td></c:if>
		</tr>
		<tr>
			<c:if test="${login.person_fax != null }">
			<th>팩스:</th>
			<td>${login.person_fax }</td></tr></c:if>
		<tr>
			<td colspan="2">
			<button id="btn-summit" onclick = "location.href='${cpath }/common/updateInfo'">개인정보 수정</button> | 
			<button id="btn-summit" onclick = "location.href='${cpath }/common/updatePw'">비밀번호 변경</button></td></tr>
	</table>
</div>

<%@ include file="../layout/footer.jsp" %>