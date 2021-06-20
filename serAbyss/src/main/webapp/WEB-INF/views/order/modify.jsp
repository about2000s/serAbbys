<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<form method="post" enctype="multipart/form-data">
	<input type="hidden" name="service_idx" value="${dto.service_idx }">
	<div class="order">
		<div>
			<p>
				<input type="text" name="service_custId" value="${dto.service_custId}" readonly>
			</p>
			<p>
				<input type="text" name="service_title" value="${dto.service_title}" required>
			</p>
		</div>
	</div>
	<div class="content">
		<textarea class="write-area" name="service_content" required>${dto.service_content}</textarea>
	</div>
	<div class="order">
		<p>
			<input type="file" name="file" >
			<c:if test="${not empty dto.service_uploadFile1 }">
				<div><img src="${cpath }/upload/${dto.service_uploadFile1 }" height="200px"></div>
			</c:if>
		</p>
	</div>
	<div class="order">
		<p><input type="text" name="service_address" value="${dto.service_address}" required></p>
	</div>
	<div class="order">
		<p><input type="text" name="service_engiId" value="${dto.service_engiId}" readonly></p>
	</div>
	<div class="order">
		<input type="submit" value="수정하기">
		<input type="button" value="취소하기" onclick="location.href='history(-1)'">
	</div>
</form>
<%@ include file="../layout/footer.jsp" %>