<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../layout/header.jsp"%>

<section class="page-section">
	<h2>리뷰보기</h2>
	<div class="card mb-4 container">
		<div class="card-body">
			<table class = "table dataTable-table" id="datatablesSimple">
				<thead>
					<tr>
						<th width="10%">평점</th>
						<th width="50%">제목</th>
						<th width="10%">작성자(고객)</th>
						<th width="10%">날짜</th>
						<th width="10%">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var = "dto" items = "${map.mapList }">
						<tr>
							<td>${dto.review_star }</td>
							<td><a href="${cpath }/board/reviewRead/${dto.review_idx}?type=${map.type }&keyword=${map.keyword }&page=${map.page }">${dto.review_title}</a>&nbsp;[${dto.review_replyCount }]</td>
							<td>${dto.review_custId}</td>
							<td>${dto.review_reg }</td>
							<td>${dto.review_viewCount }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div><!-- 검색 -->
			<form>
				<input type = "hidden" name = "page" value = "1">
				<select name = "type" class = "form-control" style = "width: 10%; display: inline;">
					<option value = "review_title" selected>제목</option>
					<option value = "review_content">내용</option>
					<option value = "review_custId">글쓴이</option>
				</select>
				<input type = "text" name = "keyword" value = "${keyword }" placeholder = "검색" class = "form-control" style = "width: 30%; display: inline;">
				<button type = "submit" class = "btn btn-primary btn-xl">검색</button>
			</form>
		</div>
	</div>
</section>


<div class="page_wrap">
	<div class="page_nation">
		<c:if test="${map.page > map.paging.pageD }">
			<a class="arrow prev" href="${cpath}/board/review_list_all?page=${paging.startNum - 1 }&type=${map.type}&keyword=${map.keyword }"></a>
		</c:if>
		<c:forEach var = "i" begin="${map.paging.startNum }" end="${map.paging.endNum }">
			<c:if test="${map.page == i }"> <b> </c:if>
				<a href = "${cpath }/board/review_list_all?page=${i }&type=${map.type}&keyword=${map.keyword}">${i }</a>
			<c:if test="${map.page == i }"> </b> </c:if>
		</c:forEach>
		<c:if test="${map.paging.endNum < map.paging.pageCount }">
			<a class="arrow next" href="${cpath}/board/review_list_all?page=${map.paging.endNum + 1 }&type=${map.type}&keyword=${map.keyword}"></a>
		</c:if>
	</div>
</div>

<%@ include file="../layout/footer.jsp"%>
