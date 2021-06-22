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
		</td>
	</tr>
</table>
<div>
	<c:if test="${login.person_id == dto.review_custId }">
		<button onclick = "location.href='${cpath}/board/reviewModify/${dto.review_idx }?type=${map.type }&keyword=${map.keyword }&page=${map.page }'">수정</button> | 
		<button id = "deleteBtn">삭제</button>
	</c:if>
	 | <button onclick = "location.href='${cpath}/board/review_list_all?type=${map.type }&keyword=${map.keyword }&page=${map.page }'">목록으로</button>
</div>

<div><!-- 댓글 기능을 구현해 봅시다. -->
	<form method = "post">
		<input type = "hidden" name = "page" value = "${map.page }">
		<input type = "hidden" name = "type" value = "${map.type }">
		<input type = "hidden" name = "keyword" value = "${map.keyword }">
		<input type = "hidden" name = "reply_bnum" value = "${dto.review_idx }">
		<input type = "hidden" name = "reply_id" value = "${login.person_id }">
		<textarea name = "reply_content" placeholder="바른말 고운말"></textarea>
		<input type = "submit" value = "댓글 작성">
	</form>
</div>
<%-- 		<h3>작성자: ${dto.reply_id }</h3> --%>
<%-- 		<h3>작성일: ${dto.reply_reg }</h3> --%>
<%-- 		<c:if test="${login.person_id == dto.reply_id }"> --%>
<%-- 			<button onclick = "location.href='${cpath}/???'">수정</button> --%>
<!-- 			<button id = "replyDeleteBtn">삭제</button> -->
<%-- 		</c:if> --%>




<c:forEach var = "i" items = "${replyPageList }">
	<c:forEach var = "dto" items = "${replyList }" begin = "${nowD*(i-1) }" end = "${nowD*(i-1) + (nowD - 1) }">
		<div class = "k${nowD*(i-1) }reply${nowD*(i-1) + (nowD - 1) } hiddenNone main1">
		<h2><pre>${dto.reply_content }</pre></h2>
		<h2>작성자: ${dto.reply_id }</h2>
		<h2>작성일: ${dto.reply_reg }</h2>
		</div>
	</c:forEach>
	<hr>
</c:forEach>

<c:forEach var = "i" items = "${replyPageList }">
	<span><a href = "" class = "${nowD*(i-1) }reply${nowD*(i-1) + (nowD - 1) }">[${i }]</a></span>
</c:forEach>

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