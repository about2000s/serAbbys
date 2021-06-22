<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<div class="container">
	<table class="list">
		
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성날짜</th>
			<th>상태</th>
		</tr>
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
	</table>
	<div class="sb">
		<div>
			<form>
				<input type="hidden" name="page" value="1">
				<select name="type">
					<option value="service_title" selected>제목</option>
					<option value="service_content">내용</option>
					<option value="both">제목+내용</option>
				</select>
				<input type="text" name="keyword" value="${map.keyword }" placeholder="검색어를 입력하세요">
				<input type="hidden" name="service_status" value="${map.service_status}">
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
</div>


<div class="card2 mb-4">
           <div class="card2-header">
               <i class="fas fa-table me-1"></i>
               DataTable Example
           </div>
           <div class="card2-body">
               <table id="datatablesSimple" class = "">
                   <thead>
                       <tr>
                           <th>글번호</th>
                           <th>제목</th>
                           <th>작성자</th>
                           <th>조회수</th>
                           <th>Start date</th>
                           <th>Salary</th>
                       </tr>
                   </thead>
                   <tfoot>
                       <tr>
                           <th>Name</th>
                           <th>Position</th>
                           <th>Office</th>
                           <th>Age</th>
                           <th>Start date</th>
                           <th>Salary</th>
                       </tr>
                   </tfoot>
                   <tbody>
                       <tr>
                           <td>Tiger Nixon</td>
                           <td>System Architect</td>
                           <td>Edinburgh</td>
                           <td>61</td>
                           <td>2011/04/25</td>
                           <td>$320,800</td>
                       </tr>
                       <tr>
                           <td>Garrett Winters</td>
                           <td>Accountant</td>
                           <td>Tokyo</td>
                           <td>63</td>
                           <td>2011/07/25</td>
                           <td>$170,750</td>
                       </tr>
                   </tbody>
               </table>
           </div>
       </div>

<c:if test="${map.page > map.paging.pageD }">
	<button onclick = "location.href='${cpath}/order/statusList?page=${paging.startNum - 1 }&type=${map.type}&keyword=${map.keyword }&service_status=${map.service_status }'">이전</button>
</c:if>

<c:forEach var = "i" begin="${map.paging.startNum }" end="${map.paging.endNum }">
	<c:if test="${map.page == i }"> <b> </c:if>
	<a href = "${cpath }/order/statusList?page=${i }&type=${map.type}&keyword=${map.keyword}&service_status=${map.service_status}">[${i }]</a>
	<c:if test="${map.page == i }"> </b> </c:if>
</c:forEach>

<c:if test="${map.paging.endNum < map.paging.pageCount }">
	<button onclick = "location.href='${cpath}/order/statusList?page=${map.paging.EndNum + 1 }&type=${map.type}&keyword=${map.keyword}&service_status=${map.service_status}'">다음</button>
</c:if>

<%@ include file="../layout/footer.jsp" %>
