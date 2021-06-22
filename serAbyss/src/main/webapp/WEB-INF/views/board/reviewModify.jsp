<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>리뷰글 수정하는 폼입니다.</h2>
<div class="container">
	<form method = "post">
		<input type = "hidden" name = "page" value = "${map.page }">
		<input type = "hidden" name = "type" value = "${map.type }">
		<input type = "hidden" name = "keyword" value = "${map.keyword }">
		<input type = "hidden" name = "review_idx" value = "${dto.review_idx }">
		<p><input type = "text" name = "review_title" value = "${dto.review_title }" required></p>
		
		<textarea name = "review_content" class="form-control" required style = "width: 50%;">${dto.review_content }</textarea>
		<button type = "submit" class = "btn btn-primary btn-xl" style = "display: inline;">수정</button>
		<button class = "btn btn-primary btn-xl" type = "submit" onclick="location.href='history(-1)'">취소</button>
	</form>
</div>
<%@ include file="../layout/footer.jsp" %>