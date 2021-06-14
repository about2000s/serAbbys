<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<h2>내 아이디 접수목록입니다</h2>
<div>
	<table border = "1">
		<tr>
			<th>engiId</th>
			<th>title</th>
			<th>status</th>
			<th>viewCount</th>
			<th>compBelong</th>
		</tr>
		<c:forEach var = "dto" items = "${list }">
			<tr>
				<td>${dto.service_engiId }</td>
				<td>${dto.service_title }</td>
				<td>${dto.service_status }</td>
				<td>${dto.service_viewCount }</td>
				<td>${dto.service_compBelong }</td>
			</tr>
		</c:forEach>
	</table>
</div>

<%@ include file="../layout/footer.jsp" %>