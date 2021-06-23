<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<!-- <h2>자주 묻는 질문(FAQ)</h2> -->
<!-- <div> -->
<!-- 	<table border = "1"> -->
<!-- 		<tr> -->
<!-- 			<th>번호</th> -->
<!-- 			<th>제목</th> -->
<!-- 			<th>글쓴이</th> -->
<!-- 			<th>날짜</th> -->
<!-- 			<th>조회</th> -->
<!-- 		</tr> -->
<%-- 		<c:forEach var = "dto" items = "${list }"> --%>
<!-- 			<tr> -->
<%-- 				<td>${dto.serCen_idx }</td> --%>
<%-- 				<td><a href = "${cpath }/board/serCenRead?serCen_idx=${dto.serCen_idx}&serCen_belong=${dto.serCen_belong}">${dto.serCen_title }</a></td> --%>
<%-- 				<td>${dto.serCen_id }</td> --%>
<%-- 				<td>${dto.serCen_reg }</td> --%>
<%-- 				<td>${dto.serCen_viewCount }</td> --%>
<!-- 			</tr> -->
<%-- 		</c:forEach> --%>
<!-- 	</table> -->
<!-- </div> -->
<h2>FAQ</h2>
<div class="card mb-4 container">
	<div class="card-body">
		<table class = "table dataTable-table">
			<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th><!-- 제목 옆에 숫자로 댓글 수 띄우기 -->
				<th>작성자</th>
				<th>조회수</th>
				<th>등록일자</th>
			</tr>
			</thead>
			<tbody>
			<c:if test="${empty list}">
				<tr>
					<td>일치하는 검색결과가 없습니다.</td>
				</tr>
			</c:if>
				<c:forEach var = "dto" items = "${list }">
					<tr>
						<td>${dto.serCen_idx }</td>
						<td><a>${dto.serCen_title }</a></td>
						<td>${dto.serCen_id }</td>
						<td>${dto.serCen_viewCount }</td>
						<td>${dto.serCen_reg }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div>
		<form>
			<input type = "hidden" name = "page" value = "1">
			<select name = "type" class = "form-control" style = "width: 10%; display: inline;">
				<option value = "serCen_title" selected>제목</option>
				<option value = "serCen_content">내용</option>
			</select>
			<input type = "text" name = "keyword" value = "${keyword }" placeholder = "검색" class = "form-control" style = "width: 30%; display: inline;">
			<button type = "submit" class = "btn btn-primary btn-xl">검색</button>
		</form>
		<button onclick = "location.href='${cpath }/board/writeFaq?page=${page }'" class = "btn btn-primary btn-xl">새 글 작성</button>
	</div>
</div>

<c:if test="${page > paging.pageD }">
	<button onclick = "location.href='${cpath}/board/serCen?page=${paging.startNum - 1 }&type=${type }&keyword=${keyword }'">이전</button>
</c:if>

<c:forEach var = "i" begin="${paging.startNum }" end="${paging.endNum }">
	<c:if test="${page == i }"> <b></c:if>
	<a href = "${cpath }/board/serCen?page=${i }&type=${type }&keyword=${keyword }">[${i }]</a>
	<c:if test="${page == i }"> </b></c:if>
</c:forEach>

<c:if test="${paging.endNum < paging.pageCount }">
	<button onclick = "location.href='${cpath }/board/serCen?page=${paging.endNum + 1 }&type=${type }&keyword=${keyword }'">다음</button>
</c:if>


<%@ include file="../layout/footer.jsp" %>