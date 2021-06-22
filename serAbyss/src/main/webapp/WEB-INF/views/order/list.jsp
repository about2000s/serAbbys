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
						<td>${dto.service_idx }</td>
						<td><a href="${cpath }/order/read/${dto.service_idx}?page=${map.page}&type=${map.type}&keyword=${map.keyword}&service_status=${map.service_status}">${dto.service_title }</a></td>
						<td>${dto.service_custId }</td>
						<td>${dto.service_viewCount }</td>
						<td>${dto.service_reg }</td>
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
				<option value="service_title" selected>제목</option>
				<option value="service_content">내용</option>
				<option value="both">제목+내용</option>
			</select>
			<input type="text" name="keyword" value="${map.keyword }" placeholder="검색어를 입력하세요" class = "form-control" style = "width: 30%; display: inline;">
			<input type="hidden" name="service_status" value="${map.service_status}">
			<button type = "submit" class = "btn btn-primary btn-xl">검색</button>
		</form>
	</div>
</div>

<div class="page_wrap">
	<div class="page_nation">
		<c:if test="${map.page > map.paging.pageD }">
			<a class="arrow prev" href="${cpath}/order/statusList?page=${paging.startNum - 1 }&type=${map.type}&keyword=${map.keyword }&service_status=${map.service_status }"></a>
		</c:if>
		<c:forEach var = "i" begin="${map.paging.startNum }" end="${map.paging.endNum }">
			<c:if test="${map.page == i }"> <b> </c:if>
				<a href = "${cpath }/order/statusList?page=${i }&type=${map.type}&keyword=${map.keyword}&service_status=${map.service_status}">${i }</a>
			<c:if test="${map.page == i }"> </b> </c:if>
		</c:forEach>
		<c:if test="${map.paging.endNum < map.paging.pageCount }">
			<a class="arrow next" href="${cpath}/order/statusList?page=${map.paging.EndNum + 1 }&type=${map.type}&keyword=${map.keyword}&service_status=${map.service_status}"></a>
		</c:if>
	</div>
</div>

<%@ include file="../layout/footer.jsp" %>