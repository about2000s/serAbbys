<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>리뷰글 수정하는 폼입니다.</h2>
<form method = "post">
	<input type = "hidden" name = "page" value = "${map.page }">
	<input type = "hidden" name = "type" value = "${map.type }">
	<input type = "hidden" name = "keyword" value = "${map.keyword }">
	<input type = "hidden" name = "review_idx" value = "${dto.review_idx }">
	<p><input type = "text" name = "review_title" value = "${dto.review_title }" required></p>
	
	<textarea name = "review_content" required>${dto.review_content }</textarea>
	<input type = "submit" value = "수정하기">
	<button onclick = "javascript:history.go(-1);">뒤로가기</button>
</form>
<%@ include file="../layout/footer.jsp" %>