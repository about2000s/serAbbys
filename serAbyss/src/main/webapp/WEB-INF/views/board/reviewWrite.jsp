<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>리뷰를 작성해주세요!</h2>
<form method = "post" enctype="multipart/form-data">
	<input type = "hidden" name = "review_idx" value = "${dto.service_idx }">
	<input type = "hidden" name = "review_engiId" value = "${dto.service_engiId }">
	<input type = "hidden" name = "review_custId" value = "${dto.service_custId }">
	<input type = "hidden" name = "review_compBelong" value = "${dto.service_compBelong }">
	<p><input type = "text" name = "review_title" placeholder="제목 입력"></p>
	<textarea name = "review_content"></textarea>
	<c:forEach var = "i" begin="1" end = "10">
		<label><input type = "radio" name = "review_starScore" value = "${i }">${i }</label>
	</c:forEach>
	<input type = "submit" value = "리뷰 쓰기">
</form>

<%@ include file="../layout/footer.jsp" %>