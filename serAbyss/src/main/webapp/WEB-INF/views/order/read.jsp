<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>
<style>
.serviceRead {width:890px; padding:5px; font-size:12px; }
.serviceRead tr th{height:50px;background-color:#ececec;border:1px solid dcdcdc;}
.serviceRead tr td {padding-left:50px; border:1px solid #dcdcdc; }
</style>
	<div class = "container">
		<div class="card-body">
			<!-- 그 서비스글에 해당하는 고객만이 리뷰글을 작성하는 권한이 있다!! -->
			<c:if test="${flag == true }">
				<h2>이 글에 리뷰는 이미 작성되었습니다.</h2>
				<button onclick = "location.href='${cpath}/board/reviewRead/${dto.service_idx }?page=1'" class = "btn btn-primary btn-xl">작성된 리뷰글 보러가기!</button>
			</c:if>
			<c:if test="${flag == false && login.person_id == dto.service_custId && dto.service_status == '모든 처리 완료' }">
				<button onclick = "location.href='${cpath}/board/reviewWrite?service_idx=${dto.service_idx }'" class = "btn btn-primary btn-xl">리뷰 작성하러 가기!</button>
			</c:if>
			<table class = "table dataTable-table">
				<tr>
					<td colspan="4">${dto.service_title }</td>
				</tr>
				<tr>
					<td>${dto.service_custId }</td>
					<td>${dto.service_reg }</td>
					<td>조회수: ${dto.service_viewCount }</td>
					<td>${dto.service_status }</td>
				</tr>
				<tr>
					<td colspan="4" height="500px">
						<pre>${dto.service_content }</pre>
					</td>
				</tr>
				<tr>
					<td align="right" colspan="4">
			 			<c:if test="${login.person_check eq 'y'}">
							<form method="get" id="statusChange" action="${cpath}/order/statusChange">
								<button>status 바꾸기</button>
							</form>
			 			</c:if>
			 			<button onclick = "location.href='${cpath }/order/statusList?page=${map.page }&type=${map.type }&keyword=${map.keyword}&service_status=${map.service_status}'" class = "btn btn-primary btn-xl">목록</button>
			 			<button onclick = "location.href='${cpath }/order/modify/${dto.service_idx}?page=${map.page }&type=${map.type }&keyword=${map.keyword}&service_status=${map.service_status}'" class = "btn btn-primary btn-xl">수정</button>
						<button id = "deleteBtn" class = "btn btn-primary btn-xl">예약취소</button>
					</td>
				</tr>
			</table>
		</div>
	</div>

<script>
	const deleteUrl = '${cpath }/order/delete/${dto.service_idx}';
	document.getElementById('deleteBtn').onclick = function(event) {
		if(confirm("정말 예약을 취소하시겠습니까?") == true) {
			location.href = deleteUrl + "?" + '${login.person_check}';
		} else {
			return;
		}
	}
</script>
<%@ include file="../layout/footer.jsp" %>