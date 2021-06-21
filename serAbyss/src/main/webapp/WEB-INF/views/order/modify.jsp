<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<form method="post" enctype="multipart/form-data">
	<input type="hidden" name="service_idx" value="${dto.service_idx }">
	<input type="hidden" name="page" value="${map.page }">
	<input type="hidden" name="type" value="${map.type }">
	<input type="hidden" name="keyword" value="${map.keyword }">
	<input type="hidden" name="service_status" value="${map.service_status }">
	<div class="order">
		<div>
			<p>
				고객: <input type="text" name="service_custId" value="${dto.service_custId}" readonly>
			</p>
			<p>
				기사: <input type="text" name="service_custId" value="${dto.service_engiId}" readonly>
			</p>
			<p>
				<input type="text" name="service_title" value="${dto.service_title}" required>
			</p>
		</div>
	</div>
	<div class="content">
		<textarea class="write-area" name="service_content" required>${dto.service_content}</textarea>
	</div>
		<input type="submit" value="수정하기">
</form>
	<input type="button" value="취소하기" onclick="location.href='history(-1)'">
<%@ include file="../layout/footer.jsp" %>