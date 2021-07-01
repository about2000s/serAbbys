<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<section class = "page-section">
	<div class = "container" >
		<a href = "${cpath }/board/faq?page=1" class = "btn btn-primary btn-lg" style = "background-color: #490000">자주 묻는 질문</a>
		<a href = "${cpath }/board/notice?page=1" class = "btn btn-primary btn-lg">공지사항</a>
	</div>
	
	<div class="card mb-4 container" style = "margin-top: 20px;">
		<div class="card-body">
			<table class = "table dataTable-table">
				<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>등록일자</th>
				</tr>
				</thead>
				<tbody>
				<c:if test="${empty map.list }">
					<tr>
						<td>일치하는 검색결과가 없습니다.</td>
					</tr>
				</c:if>
					<c:forEach var = "dto" items = "${map.list }">
						<tr>
							<td>${dto.serCen_idx }</td>
							<td><a href = "${cpath }/board/serCenRead/${dto.serCen_idx }?page=${page}&type=${map.type}&keyword=${map.keyword}&serCen_belong=${dto.serCen_belong}">${dto.serCen_title }</a></td>
							<td>${dto.serCen_id }</td>
							<td>${dto.serCen_viewCount }</td>
							<td>${dto.serCen_reg }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div style = "margin-bottom: 10px;">
			<form>
				<input type = "hidden" name = "page" value = "1">
				<select name = "type" class = "form-control" style = "width: 10%; display: inline;">
					<option value = "serCen_title" selected>제목</option>
					<option value = "serCen_content">내용</option>
				</select>
				<input type = "text" name = "keyword" value = "${keyword }" placeholder = "검색" class = "form-control" style = "width: 30%; display: inline;">
				<button type = "submit" class = "btn btn-primary btn-sm" style = "height: 37px; margin-bottom: 3px;">검색</button>
			</form>
			<c:if test="${login.person_check == 'a' }">
				<button onclick = "location.href='${cpath }/board/serCenWrite?serCen_belong=faq'" class = "btn btn-primary btn-xl">새 글 작성</button>
			</c:if>
		</div>
	</div>
</section>

<div class="page_wrap">
	<div class="page_nation">
		<c:if test="${page > map.paging.pageD }">
			<a class="arrow prev" href="${cpath}/board/faq?page=${paging.startNum - 1 }&type=${map.type}&keyword=${map.keyword }">이전</a>
		</c:if>
		<c:forEach var = "i" begin="${map.paging.startNum }" end="${map.paging.endNum }">
			<c:if test="${map.page == i }"> <b> </c:if>
				<a href = "${cpath }/board/faq?page=${i }&type=${map.type}&keyword=${map.keyword}">${i }</a>
			<c:if test="${map.page == i }"> </b> </c:if>
		</c:forEach>
		<c:if test="${map.paging.endNum < map.paging.pageCount }">
			<a class="arrow next" href="${cpath}/board/faq?page=${map.paging.endNum + 1 }&type=${map.type}&keyword=${map.keyword}">다음</a>
		</c:if>
	</div>
</div>


<%@ include file="../layout/footer.jsp" %>