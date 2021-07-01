<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<section class="page-section">
<div class="card mb-4 container">
	<div class="card-body">
		<h2>마이페이지</h2>
		<table class = "table dataTable-table" id="datatablesSimple">
			<tr>
				<td >아이디</td>
				<td>${login.person_id }</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td> ${login.person_email }</td>
			</tr>
			<tr>
				<td>주소</td>
				<td> ${login.person_address }</td>
			</tr>
			<tr>
				<td>휴대전화</td>
				<td> ${login.person_phone }</td>
			</tr>
			<tr>
				<c:if test="${login.person_call != null }">
					 <td>유선전화</td>
					 <td> ${login.person_call }</td>
				</c:if>
			</tr>
			<tr>
				<c:if test="${login.person_fax != null }">
					<td>팩스</td>
					<td> ${login.person_fax }</td>
				</c:if>
			<tr>
				<td colspan="2">
					<button onclick = "location.href='${cpath }/common/updateInfo'" class = "btn btn-primary btn-sm">개인정보 수정</button>
					<button onclick = "location.href='${cpath }/common/updatePw'" class = "btn btn-primary btn-sm">비밀번호 변경</button>
				</td>
			</tr>
		</table>
	</div>
</div>
</section>
<%@ include file="../layout/footer.jsp" %>