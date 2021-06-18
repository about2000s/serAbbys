<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<div class="container">

	<h1>서비스 신청</h1>

	<table class="list">
		
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
				<td><a href="${cpath }/order/select/${dto.service_idx}?page=${param.page}&type=${param.type}&search=${param.search}&status=${param.status}&value=read">${dto.service_title }</a></td>
				<td>${dto.service_custId }</td>
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
	<div class="sb">
		<div>
			<form method="post" action="${cpath}/order/statusList">
				<input type="hidden" name="page" value="1">
				<select name="type">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="both">제목+내용</option>
				</select>
				<input type="text" name="search" value="${param.search }" placeholder="검색어를 입력하세요">
				<input type="hidden" name="status" value="${param.status}">
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
</div>

<c:if test="${page > paging.pageD }">
	<button onclick = "location.href='${cpath}/order/statusList?page=${paging.startNum - 1 }&type=${param.type}&search=${param.search}&status=${param.status}'">이전</button>
</c:if>

<c:forEach var = "i" begin="${paging.startNum }" end="${paging.endNum }">
	<c:if test="${page == i }"> <b> </c:if>
	<a href = "${cpath }/order/statusList?page=${i }&type=${param.type}&search=${param.search}&status=${param.status}">[${i }]</a>
	<c:if test="${page == i }"> </b> </c:if>
</c:forEach>

<c:if test="${paging.endNum < paging.pageCount }">
	<button onclick = "location.href='${cpath}/order/statusList?page=${paging.EndNum + 1 }&type=${param.type}&search=${param.search}&status=${param.status}'">다음</button>
</c:if>

<%@ include file="../layout/footer.jsp" %>
