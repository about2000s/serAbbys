<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<div class="container">
	<form method="post" enctype="multipart/form-data">
		<input type="hidden" name="reserve_idx" value="${dto.reserve_idx }">
		<input type="hidden" name="page" value="${map.page }">
		<input type="hidden" name="type" value="${map.type }">
		<input type="hidden" name="keyword" value="${map.keyword }">
		<input type="hidden" name="reserve_status" value="${map.reserve_status }">
				담당기사: <input type="text" name="reserve_custId" value="${dto.reserve_engiId}" readonly class="form-control" style = "width: 15%; display: inline;">
				<p>
					<input type="text" name="reserve_title" value="${dto.reserve_title}" required class="form-control" style = "width: 50%;">
				</p>
			<textarea name="reserve_content" required class="form-control" style = "width: 50%;">${dto.reserve_content}</textarea>
		<button type = "submit" class = "btn btn-primary btn-xl" style = "display: inline;">수정</button>
		<button class = "btn btn-primary btn-xl" type = "submit" onclick="location.href='history(-1)'">취소</button>
	</form>
</div>
<%@ include file="../layout/footer.jsp" %>