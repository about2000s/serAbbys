<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>
<style>
.serviceRead {width:890px; padding:5px; font-size:12px; }
.serviceRead tr th{height:50px;background-color:#ececec;border:1px solid dcdcdc;}
.serviceRead tr td {padding-left:50px; border:1px solid #dcdcdc; }
</style>

	<!-- 그 서비스글에 해당하는 고객만이 리뷰글을 작성하는 권한이 있다!! -->
	<c:if test="${flag == true }">
		<h2>이 글에 리뷰는 이미 작성되었습니다.</h2>
		<button onclick = "location.href='${cpath}/board/reviewRead/${dto.service_idx }?page=1'">작성된 리뷰글 보러가기!</button>
	</c:if>
	<c:if test="${flag == false && login.person_id == dto.service_custId && dto.service_status == '모든 처리 완료' }">
		<button onclick = "location.href='${cpath}/board/reviewWrite?service_idx=${dto.service_idx }'">리뷰 작성하러 가기!</button>
	</c:if>
	<table class="serviceRead">
	<tr>
		<th>서비스고유번호</th>
		<td colspan="3">No. ${dto.service_idx }</td></tr>
	<tr>
	<tr>
		<th>처리 상태</th>
		<td colspan="3">${dto.service_status }</td></tr>
	<tr>
		<th>서비스 요청 내역 </th>
		<td colspan="3"><b>${dto.service_title }</b></td></tr>
	<tr>
		<th width="150px">주문자이름</th>
		<td colspan="3">${dto.service_custId }</td>
		</tr>
	<tr>
		<th>주문일시</th>
		<td>${dto.service_reg }</td></tr>
		<th>조회</th>
		<td>${dto.service_viewCount }</td>
	<tr>
		<th width="150px">내용</th>
		<td colspan="3" height="500px">
			<pre>${dto.service_content }</pre>
		</td>
		</tr>
	<tr>
		<td align="right" colspan="4">
			<a href="${cpath }/order/statusList?page=${map.page }&type=${map.type }&keyword=${map.keyword}&service_status=${map.service_status}"><button>목록</button></a>
			<a href="${cpath }/order/modify/${dto.service_idx}?page=${map.page }&type=${map.type }&keyword=${map.keyword}&service_status=${map.service_status}"><button>수정</button></a>
			<button id="deleteBtn">삭제</button>
		</td></tr>
	</table>

<script>
	const deleteUrl = '${cpath }/order/delete/${dto.service_idx}';
	document.getElementById('deleteBtn').onclick = function(event) {
		if(confirm("정말 삭제하시겠습니까?") == true) {
			location.href = deleteUrl + "?" + '${login.person_check}';
		} else {
			return;
		}
	}
</script>
<%@ include file="../layout/footer.jsp" %>