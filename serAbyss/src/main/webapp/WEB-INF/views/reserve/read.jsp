<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<style>
.reserveRead {width:890px; padding:5px; font-size:12px; }
.reserveRead tr th{height:50px;background-color:#ececec;border:1px solid dcdcdc;}
.reserveRead tr td {padding-left:50px; border:1px solid #dcdcdc; }
</style>
<section class="page-section">
	<div class = "container">
		<div class="card-body">
			<!-- 그 서비스글에 해당하는 고객만이 리뷰글을 작성하는 권한이 있다!! -->
			<c:set var = "reserve_idx" value = "${dto.reserve_idx }"/>
			<c:if test="${flag == true }">
				<h2>이 글에 리뷰는 이미 작성되었습니다.</h2>
				<button onclick = "location.href='${cpath}/board/reviewRead/${dto.reserve_idx }?page=1'" class = "btn btn-primary btn-lg">작성된 리뷰글 보러가기!</button>
			</c:if>
			<c:if test="${flag == false && login.person_id == dto.reserve_custId && dto.reserve_status == '처리완료' }">
				<button onclick = "location.href='${cpath}/board/reviewWrite?reserve_idx=${dto.reserve_idx }'" class = "btn btn-primary btn-lg">리뷰 작성하러 가기!</button>
			</c:if>
			<table class = "table dataTable-table">
				<tr>
					<td colspan="5">${dto.reserve_title }</td>
				</tr>
				<tr>
					<td>${dto.reserve_custId }</td>
					<td>${dto.reserve_reg }</td>
					<td>조회수: ${dto.reserve_viewCount }</td>
					<td>
						처리 상태: ${dto.reserve_status }
						<c:if test="${dto.reserve_status != '결제완료' && btnList.b1 != '' && login.person_check == 'y'}">
							<button class = "btn btn-primary btn-sm statusChange" value = "${btnList.b1 }">${btnList.b1 }${ment }</button>
						</c:if>
						<c:if test="${dto.reserve_status == '결제완료' }">
						<c:if test="${login.person_check == 'y' }">
							<button class = "btn btn-primary btn-sm statusChange" value = "${btnList.b1 }">${btnList.b1 }${ment }</button>
						</c:if>
						<c:if test="${!(dto.reserve_custId != null && login.person_check == 'y') }">
							<button class = "btn btn-primary btn-sm statusChange" value = "${btnList.b2 }">${btnList.b2 }${ment }</button>
						</c:if>
						</c:if>
					</td>
					<td>
						<c:if test="${dto.reserve_price != 0 }">
							결제 금액: ${dto.reserve_price }
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<pre>${dto.reserve_content }</pre>
					</td>
				</tr>
				
				<tr>
					<td align="right" colspan="5">
			 			<button onclick = "location.href='${cpath }/reserve/statusList?page=${map.page }&type=${map.type }&keyword=${map.keyword}&reserve_status=${map.reserve_status}'" class = "btn btn-primary btn-sm">목록</button>
			 			<c:if test="${dto.reserve_status == '예약완료' }">
				 			<button onclick = "location.href='${cpath }/reserve/modify/${dto.reserve_idx}?page=${map.page }&type=${map.type }&keyword=${map.keyword}&reserve_status=${map.reserve_status}'" class = "btn btn-primary btn-sm">수정</button>
							<button onclick = "location.href='${cpath }/reserve/changeReserveTime/${dto.reserve_idx }'" class = "btn btn-primary btn-sm">예약시간 변경</button>
							<button id = "deleteBtn" class = "btn btn-primary btn-sm">예약 취소</button>
						</c:if>
					</td>
				</tr>
			</table>
			<div style = "margin-top: 100px;">
				<h3>응대 기록</h3>
				<table class = "table dataTable-table">
					<tr>
						<th width="70%">코멘트</th>
						<th width="30%">작성날짜</th>
					</tr>
					<c:if test="${!empty list }">
						<c:forEach var = "memo" items = "${list }">
							<tr>
								<td><pre>${memo.custMemo_comments }</pre></td>
								<td align="right">${memo.custMemo_reg }</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty list }">
						<tr>
							<td align="center" colspan = "2">응대기록이 없습니다.</td>
						</tr>
					</c:if>
				</table>
			</div>
		</div>
	</div>
</section>
<script>

const btnList = document.getElementsByClassName('statusChange')
	for(let i=0;i<btnList.length;i++){
		btnList[i].onclick = function(event){
			event.preventDefault()
			const nextStatus = event.target.value
			console.log('nextStatus: ' + nextStatus)
			
			if(confirm('정말로 상태를 변경하시겠습니까?')){
				if(nextStatus == '결제완료'){
					const reserve_price = prompt('결제한 금액을 입력하세요')
					location.replace('${cpath}/reserve/statusChange/${reserve_idx}?nextStatus=' + nextStatus + '&reserve_price=' + reserve_price)
				}
				location.replace('${cpath}/reserve/statusChange/${reserve_idx}?nextStatus=' + nextStatus + '&reserve_price=0')
			}
			
			
			
		}
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