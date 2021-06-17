<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>
<style>
.serviceRead {width:890px; padding:5px; font-size:12px; }
.serviceRead tr th{height:50px;background-color:#ececec;border:1px solid dcdcdc;}
.serviceRead tr td {padding-left:50px; border:1px solid #dcdcdc; }

</style>



	<table class="serviceRead">
	<tr>
		<th>서비스고유번호 | </th>
		<td colspan="3">No. ${dto.service_idx }</td></tr>
	<tr>
		<th>서비스 요청 내역 </th>
		<td colspan="3"><b>${dto.service_title }</b></td></tr>
	<tr>
		<th width="150px">주문자이름</th>
		<td colspan="3">${dto.service_custid }</td>
		</tr>
	<tr>
		<th>주문일시</th>
		<td>${dto.service_reg } </td></tr>
		<th>조회</th>
		<td>${dto.service_viewCount }</td>
	<tr>
		<th width="150px">내용</th>
		<td colspan="3" height="500px">
		<pre>${dto.service_content }</pre>
			<c:if test="${not empty dto.service_uploadFile1 }">
			<div><img src="${cpath }/upload/${dto.service_uploadFile1 }" height="300px"></div>
			</c:if></td>
		</tr>
	<tr>
		<td align="right" colspan="4">
			<a href="${cpath }/order/statusList/?type=${param.type}&search=${param.search}&status=${param.status}"><button>목록</button></a>
			<a href="${cpath }/order/select/${dto.service_idx}?value=modify"><button>수정</button></a>
			<button id="deleteBtn">삭제</button>
		</td></tr>
		
	</table>
	
	<table>
		
	<tr>
		<td colspan="5">
			
			</td>
	</tr>
	</table>
	<table>
	<tr>
		<td></td></tr>
	<%-- 	<c:if test="${dto.service_id == (login.person_id or 'admin')}"> --%>
	<tr>
		<td>
		</td></tr>
	<%-- 	</c:if> --%>
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