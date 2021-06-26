<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>
<style>
.reserveRead {width:890px; padding:5px; font-size:12px; }
.reserveRead tr th{height:50px;background-color:#ececec;border:1px solid dcdcdc;}
.reserveRead tr td {padding-left:50px; border:1px solid #dcdcdc; }
</style>
	<div class = "container">
		<div class="card-body">
			<!-- 그 서비스글에 해당하는 고객만이 리뷰글을 작성하는 권한이 있다!! -->
			<c:set var = "reserve_idx" value = "${dto.reserve_idx }"/>
			<c:if test="${flag == true }">
				<h2>이 글에 리뷰는 이미 작성되었습니다.</h2>
				<button onclick = "location.href='${cpath}/board/reviewRead/${dto.reserve_idx }?page=1'" class = "btn btn-primary btn-xl">작성된 리뷰글 보러가기!</button>
			</c:if>
			<c:if test="${flag == false && login.person_id == dto.reserve_custId && dto.reserve_status == '처리완료' }">
				<button onclick = "location.href='${cpath}/board/reviewWrite?reserve_idx=${dto.reserve_idx }'" class = "btn btn-primary btn-xl">리뷰 작성하러 가기!</button>
			</c:if>
			<table class = "table dataTable-table">
				<tr>
					<td colspan="4">${dto.reserve_title }</td>
				</tr>
				<tr>
					<td>${dto.reserve_custId }</td>
					<td>${dto.reserve_reg }</td>
					<td>조회수: ${dto.reserve_viewCount }</td>
					<td>
					처리 상태: ${dto.reserve_status }
					<c:if test="${login.person_check == 'r' || login.person_check == 'y' }">
						<c:if test="${b1 == '서비스중' || b1 == '서비스완료' || b1 == '결제완료' }">
							<button id = "statusChange" class = "btn btn-primary btn-xl">${b1 }${ment }</button>
						</c:if>
					</c:if>
					<c:if test="${login.person_check == 'n' }">
						<c:if test="${b1 == '환불신청' }">
							<button id = "statusChange" class = "btn btn-primary btn-xl">${b1 }${ment }</button>
						</c:if>
					</c:if>
					<c:if test="${login.person_check == 'r' || login.person_check == 'y' }">
						<c:if test="${b2 == '처리완료' }">
							<button id = "statusChange" class = "btn btn-primary btn-xl">${b2 }${ment }</button>
						</c:if>
					</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="4" height="500px">
						<pre>${dto.reserve_content }</pre>
					</td>
				</tr>
				<c:forEach var="memo" items="${list}">
					<tr>
						<td colspan="4" height="200px">
							<pre>${memo.custMemo_comments }</pre>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td align="right" colspan="4">
			 			<button onclick = "location.href='${cpath }/reserve/statusList?page=${map.page }&type=${map.type }&keyword=${map.keyword}&reserve_status=${map.reserve_status}'" class = "btn btn-primary btn-xl">목록</button>
			 			<button onclick = "location.href='${cpath }/reserve/modify/${dto.reserve_idx}?page=${map.page }&type=${map.type }&keyword=${map.keyword}&reserve_status=${map.reserve_status}'" class = "btn btn-primary btn-xl">수정</button>
						<button onclick = "location.href='${cpath }/reserve/changeReserveTime/${dto.reserve_idx }'" class = "btn btn-primary btn-xl">예약시간 변경</button>
						<button id = "deleteBtn" class = "btn btn-primary btn-xl">예약 취소</button>
					</td>
				</tr>
			</table>
		</div>
	</div>

<script>
document.getElementById('statusChange').onclick = function(event){
	console.log('sex')
	event.preventDefault()
	const cf = confirm('정말로 상태 변경시키겠습니까?')
	if(cf) location.replace('${cpath}/reserve/statusChange/${reserve_idx}?b1=${b1}&b2=${b2}')
}
</script>


<script>
	document.getElementById('deleteBtn').onclick = function(event) {
		if(confirm("정말 예약을 취소하시겠습니까?") == true) {
			location.href = '${cpath }/reserve/delete/${dto.reserve_idx}'
		} else {
			return;
		}
	}
</script>
<%@ include file="../layout/footer.jsp" %>