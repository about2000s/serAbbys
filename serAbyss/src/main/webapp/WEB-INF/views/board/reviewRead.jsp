<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<table>
	<tr class = "serviceRead">
		<th>리뷰 번호</th>
		<td colspan="3">No. ${dto.review_idx }</td></tr>
	<tr>
		<th>제목 </th>
		<td colspan="3"><b>${dto.review_title }</b></td></tr>
	<tr>
		<th width="150px">작성자 아이디</th>
		<td colspan="3">${dto.review_custId }</td>
	</tr>
	<tr>
		<th>글 쓴 날짜</th>
		<td>${dto.review_reg } </td></tr>
		<th>조회수</th>
		<td>${dto.review_viewCount }</td>
	<tr>
		<th width="150px">내용</th>
		<td colspan="3" height="500px">
		<pre>${dto.review_content }</pre>
		<c:if test="${not empty dto.review_uploadFile1 }">
		<div><img src="${cpath }/upload/${dto.review_uploadFile1 }" height="300px"></div>
		</c:if>
		</td>
	</tr>
</table>
<div>
	<button onclick = "location.href='${cpath}/board/reviewUpdate?review_idx=${dto.review_idx }'">수정</button> | 
	<button id = "deleteBtn">삭제</button> | 
	<button onclick = "">목록으로</button><!-- 나중에 페이징 구현하면 page를 매개변수로 써야 한다!! -->
</div>

<%@ include file="../layout/footer.jsp" %>