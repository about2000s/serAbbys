<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

	<div class="sb">

	</div>


<div class="card mb-4 container">
	<div class="card-body">
		<table class = "table dataTable-table" id="datatablesSimple">
			<thead>
				<tr>
					<th>글번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${map.list }">
					<tr>
						<td>${dto.reserve_idx }</td>
						<td><a href="${cpath }/reserve/read/${dto.reserve_idx}?page=${map.page}&type=${map.type}&keyword=${map.keyword}&reserve_status=${map.reserve_status}">${dto.reserve_title }</a></td>
						<td>${dto.reserve_custId }</td>
						<td>${dto.reserve_viewCount }</td>
						<td>${dto.reserve_reg }</td>
					</tr>
					</c:forEach>
					<c:if test="${empty map.list }">
						<tr style="text-align: center;">
						<td colspan="5">내용이 없습니다.</td>
					</tr>
					</c:if>
			</tbody>
		</table>
	</div>
	<div>
		<form>
			<input type="hidden" name="page" value="1">
			<select name="type" class = "form-control" style = "width: 10%; display: inline;">
				<option value="reserve_title">제목</option>
				<option value="reserve_content">내용</option>
				<option value="both">제목+내용</option>
			</select>
			<input type="text" name="keyword" value="${map.keyword }" placeholder="검색어를 입력하세요" class = "form-control" style = "width: 30%; display: inline;">
			<input type="hidden" name="reserve_status" value="${map.reserve_status}">
			<button type = "submit" class = "btn btn-primary btn-xl">검색</button>
		</form>
	</div>
</div>

<div class="page_wrap">
	<div class="page_nation">
		<c:if test="${map.page > map.paging.pageD }">
			<a class="arrow prev" href="${cpath}/reserve/statusList?page=${paging.startNum - 1 }&type=${map.type}&keyword=${map.keyword }&reserve_status=${map.reserve_status }"></a>
		</c:if>
		<c:forEach var = "i" begin="${map.paging.startNum }" end="${map.paging.endNum }">
			<c:if test="${map.page == i }"> <b> </c:if>
				<a href = "${cpath }/reserve/statusList?page=${i }&type=${map.type}&keyword=${map.keyword}&reserve_status=${map.reserve_status}">${i }</a>
			<c:if test="${map.page == i }"> </b> </c:if>
		</c:forEach>
		<c:if test="${map.paging.endNum < map.paging.pageCount }">
			<a class="arrow next" href="${cpath}/reserve/statusList?page=${map.paging.EndNum + 1 }&type=${map.type}&keyword=${map.keyword}&reserve_status=${map.reserve_status}"></a>
		</c:if>
	</div>
</div>

<script>
const type = document.querySelector('option[value="${map.type}"]')
type.setAttribute('selected', 'selected')
</script>

<%@ include file="../layout/footer.jsp" %>