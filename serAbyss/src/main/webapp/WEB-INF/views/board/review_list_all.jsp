<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/reviewleftmenu.jsp"%>

<h2>리뷰보기</h2>
<div class="container">
		<table>
			<tr>
				<th width="5%">no</th>
				<th width="10%">평점</th>
				<th width="50%">제목</th>
				<th width="10%">담당 엔지니어</th>
				<th width="10%">날짜</th>
				<th width="10%">조회수</th>
			</tr>
			<c:forEach var = "dto" items = "${list }">
				<tr>
					<td>${dto.review_idx}</td>
					<td>${dto.star }</td>
					<td><a href="${cpath }/board/reviewRead?review_idx=${dto.review_idx}">${dto.review_title}</a></td>
					<td>${dto.review_engiId}</td>
					<td>${dto.review_reg }</td>
					<td>${dto.review_viewCount }</td>
				</tr>
			</c:forEach>
		</table>
</div>

<div><!-- 검색 -->
	<form>
		<input type = "hidden" name = "page" value = "1">
		<select name = "type">
			<option value = "review_title" selected>제목</option>
			<option value = "review_content">내용</option>
			<option value = "review_custId">글쓴이</option>
		</select>
		<input type = "text" name = "keyword" value = "${keyword }" placeholder = "검색">
		<input type = "submit" value = "검색">
	</form>
</div>

<c:if test="${page > 10}">
	<button onclick = "location.href='${cpath}/board/review_list_all?page=${paging.startNum - 1 }&type=${type}&keyword=${keyword }'">이전</button>
</c:if>

<c:forEach var = "i" begin="${paging.startNum }" end="${paging.endNum }">
	<c:if test="${page == i }"> <b></c:if>
	<a href = "${cpath }/board/review_list_all?page=${i}&type=${type}&keyword=${keyword }">[${i }]</a>
	<c:if test="${page == i }"> </b></c:if>
</c:forEach>

<c:if test="${paging.endNum < paging.pageCount}">
	<button onclick = "location.href='${cpath}/board/review_list_all?page=${paging.endNum + 1 }&type=${type}&keyword=${keyword }'">다음</button>
</c:if>

<%@ include file="../layout/footer.jsp"%>
