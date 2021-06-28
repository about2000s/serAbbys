<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<section class="page-section">
<%-- 	<c:if test="${login.person_check == 'n' }"><c:set var = "k" value = "cust"/></c:if> --%>
<%-- 	<c:if test="${login.person_check != 'n' }"><c:set var = "k" value = "engi"/></c:if> --%>
	<div class="card mb-4 container">
<%-- 	<button onclick = "location.href='${cpath}/reserve/reserve_new_for_${k }'" class = "btn btn-primary btn-sm">예약하기</button> --%>
		<div class="card-body">
			<table class = "table dataTable-table" id="datatablesSimple">
				<thead>
					<tr>
						<th>예약번호</th>
	                    <th>제목</th>
	                    <th>작성자</th>
	                    <th>담당기사</th>
	                    <th>조회수</th>
	                    <th>작성날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${map.list }">
						<tr>
							<td>${dto.reserve_idx }</td>
							<td><a href="${cpath }/reserve/read/${dto.reserve_idx}?page=${map.page}&type=${map.type}&keyword=${map.keyword}&reserve_status=${map.reserve_status}">${dto.reserve_title }</a>[${dto.reserve_status }]</td>
							
							<td>
								<c:if test="${dto.reserve_custId != null }">${dto.reserve_custId }</c:if>
								<c:if test="${dto.reserve_custId == null }">${dto.reserve_engiId }</c:if>
							</td>
							<td>${dto.reserve_engiId }</td>
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
				<c:forEach var = "status" items = "${statusList }">
					<label><input type = "radio" name = "reserve_status" value = "${status }" class = "form-check-input">${status }</label>
				</c:forEach>
				<br>
				<select name="type" class = "form-control" style = "width: 10%; display: inline;">
					<option value="reserve_title">제목</option>
					<option value="reserve_content">내용</option>
					<option value="both">제목+내용</option>
				</select>
				<input type="text" name="keyword" value="${map.keyword }" placeholder="검색어를 입력하세요" class = "form-control" style = "width: 30%; display: inline;">
				<button type = "submit" class = "btn btn-primary btn-sm" style = "height: 38px; margin-bottom: 3px;">검색</button>
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
				<a class="arrow next" href="${cpath}/reserve/statusList?page=${map.paging.endNum + 1 }&type=${map.type}&keyword=${map.keyword}&reserve_status=${map.reserve_status}"></a>
			</c:if>
		</div>
	</div>
</section>
<script>
const all = document.querySelector('input[value="전체"]')
	window.onload = function(){
		all.setAttribute('checked', 'checked')
		if(${map.reserve_status != ''}){
			const status = document.querySelector('input[value=${map.reserve_status}]')
			status.setAttribute('checked', 'checked')
		}
	}
	
</script>

<script>
const type = document.querySelector('option[value="${map.type}"]')
type.setAttribute('selected', 'selected')


</script>

<%@ include file="../layout/footer.jsp" %>