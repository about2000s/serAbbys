<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<style>
.list {
	width: 100%;
	display: flex;
	flex-flow: column;
	align-items: center;
	padding-top: 50px;
}
</style>

<div class="container">
	<div>
	<table>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성날짜</th>
		</tr>
		<c:forEach var="dto" items="${list }">
			<tr>
				<td>${dto.service_idx }</td>
				<td><a href="${cpath }/order/read/${dto.service_idx}">${dto.service_title }</a></td>
				<td>${dto.service_id }</td>
				<td>${dto.service_viewCount }</td>
				<td>${dto.service_reg }</td>
			</tr>
		</c:forEach>
		<c:if test="${empty list }">
			<tr style="text-align: center;">
				<td colspan="5">내용이 없습니다.</td>
			</tr>
		</c:if>
	</table>
	 </div>
 </div>
<%@ include file="../layout/footer.jsp" %>
