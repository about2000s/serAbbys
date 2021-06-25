<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>고객센터글 수정하는 폼입니다.</h2>
<div class="container">
	<form method = "post">
		<input type = "hidden" name = "page" value = "${map.page }">
		<input type = "hidden" name = "type" value = "${map.type }">
		<input type = "hidden" name = "keyword" value = "${map.keyword }">
		<input type = "hidden" name = "serCen_idx" value = "${dto.serCen_idx }">
		<p><input type = "text" name = "serCen_title" value = "${dto.serCen_title }" required></p>
		
		<textarea name = "serCen_content" class="form-control" required style = "width: 50%;">${dto.serCen_content }</textarea>
		<button type = "submit" class = "btn btn-primary btn-xl" style = "display: inline;">수정</button>
		<button class = "btn btn-primary btn-xl" type = "submit" onclick="location.href='history.go(-1)'">취소</button>
	</form>
</div>
<%@ include file="../layout/footer.jsp" %>