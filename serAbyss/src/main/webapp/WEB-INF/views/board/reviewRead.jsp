<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<div class = "container">
	<div class="card-body">
		<table class = "table dataTable-table">
			<tr>
				<td colspan="3">${dto.review_title }</td>
			</tr>
			<tr>
				<td>${dto.review_custId }</td>
				<td>${dto.review_reg }</td>
				<td>조회수: ${dto.review_viewCount }</td>
			</tr>
			<tr>
				<td colspan="3" height="500px">
					<pre>${dto.review_content }</pre>
				</td>
			</tr>
			<tr>
				<td align="right" colspan="3">
		 			<button onclick = "location.href='${cpath }/board/review_list_all?page=${map.page }&type=${map.type }&keyword=${map.keyword}'" class = "btn btn-primary btn-xl">목록</button>
		 			<c:if test="${login.person_id == dto.review_custId }">
			 			<button onclick = "location.href='${cpath }/board/reviewModify/${dto.review_idx}?page=${map.page }&type=${map.type }&keyword=${map.keyword}'" class = "btn btn-primary btn-xl">수정</button>
						<button id = "deleteBtn" class = "btn btn-primary btn-xl">삭제</button>
					</c:if>
				</td>
			</tr>
		</table>
	</div>
	<div><!-- 댓글 기능을 구현해 봅시다. -->
		<form method = "post">
			<input type = "hidden" name = "page" value = "${map.page }">
			<input type = "hidden" name = "type" value = "${map.type }">
			<input type = "hidden" name = "keyword" value = "${map.keyword }">
			<input type = "hidden" name = "reply_bnum" value = "${dto.review_idx }">
			<input type = "hidden" name = "reply_id" value = "${login.person_id }">
			<textarea name = "reply_content" placeholder="바른말 고운말" class = "form-control" style="width: 40%; height: 100px; display: inline;"></textarea>
			<button type = "submit" class = "btn btn-primary btn-xl">댓글 작성</button>
		</form>
	
	<c:forEach var = "i" items = "${replyPageList }">
		<c:forEach var = "dto" items = "${replyList }" begin = "${nowD*(i-1) }" end = "${nowD*(i-1) + (nowD - 1) }">
			<div class = "k${nowD*(i-1) }reply${nowD*(i-1) + (nowD - 1) } hiddenNone main1">
				<table class = "table dataTable-table" style = "width: 30%;">
					<tr>
						<td>${dto.reply_id }</td>
						<td>${dto.reply_reg }</td>
					</tr>
					<tr>
						<td colspan="2"><pre>${dto.reply_content }</pre></td>
					</tr>
				</table>
			</div>
		</c:forEach>
		<hr>
	</c:forEach>
	
	<c:forEach var = "i" items = "${replyPageList }">
		<span><a href = "" class = "${nowD*(i-1) }reply${nowD*(i-1) + (nowD - 1) }">[${i }]</a></span>
	</c:forEach>
	</div>
</div>


<script>
window.onload = function(){ // 페이지 실행시 바로 작동
		document.querySelectorAll('div.' + 'k0reply9').forEach(div => div.classList.remove('hiddenNone'))
}

	document.querySelectorAll('span > a').forEach(a => a.onclick = function(event){
		event.preventDefault()
		className = event.target.className
		console.log(className)
		document.querySelectorAll('div.' + 'main1').forEach(div => div.classList.add('hiddenNone'))
		document.querySelectorAll('div.k' + className).forEach(div => div.classList.remove('hiddenNone'))
	})
</script>
<%@ include file="../layout/footer.jsp" %>