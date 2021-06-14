<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>공지사항(Notice)</h2>
<div>
	<table border = "1">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>날짜</th>
			<th>조회</th>
		</tr>
		<c:forEach var = "dto" items = "${list }">
			<tr>
				<td>${dto.serCen_idx }</td>
				<td><a href = "${cpath }/board/serCenRead?serCen_idx=${dto.serCen_idx}&serCen_belong=${dto.serCen_belong}">${dto.serCen_title }</a></td>
				<td>${dto.serCen_id }</td>
				<td>${dto.serCen_reg }</td>
				<td>${dto.serCen_viewCount }</td>
			</tr>
		</c:forEach>
	</table>
</div>
<%@ include file="../layout/footer.jsp" %>