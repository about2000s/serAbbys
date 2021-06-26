<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<section class="page-section">
<div class="card mb-4 container">
	<div class="card-body">
		<h2>마이페이지 입니다</h2>
		<table class = "table dataTable-table" id="datatablesSimple">
		<tr>
			<td>아이디: ${login.person_id }</td>
		</tr>
		<tr>
			<td>이메일: ${login.person_email }</td>
		</tr>
		<tr>
			<td>주소: ${login.person_address }</td>
		</tr>
		<tr>
			<td>휴대전화: ${login.person_phone }</td>
		</tr>
		<tr>
			<c:if test="${login.person_call != null }">
				 <td>유선전화: ${login.person_call }</td>
			</c:if>
		</tr>
		<tr>
			<c:if test="${login.person_fax != null }">
				<td>팩스: ${login.person_fax }</td>
			</c:if>
		<tr>
			<td colspan="2">
				<button onclick = "location.href='${cpath }/common/updateInfo'" class = "btn btn-primary btn-xl">개인정보 수정</button>
				<button onclick = "location.href='${cpath }/common/updatePw'" class = "btn btn-primary btn-xl">비밀번호 변경</button>
			</td>
		</tr>
		</table>
	</div>
</div>
</section>
<%@ include file="../layout/footer.jsp" %>