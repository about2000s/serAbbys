<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h2>리뷰를 작성해주세요!</h2>
<div class="card mb-4 container">
	<div class="card-body">
		<form method = "post" enctype="multipart/form-data">
			<input type = "hidden" name = "review_idx" value = "${dto.service_idx }">
			<input type = "hidden" name = "review_engiId" value = "${dto.service_engiId }">
			<input type = "hidden" name = "review_custId" value = "${dto.service_custId }">
			<input type = "hidden" name = "review_compBelong" value = "${dto.service_compBelong }">
			<table class = "table dataTable-table">

			<tr>
				<td><input type = "text" name = "review_title" placeholder="제목 입력" class = "form-control" style = "width: 20%;"></td>
			</tr>
			<tr>
				<td><textarea name = "review_content" class = "form-control"></textarea></td>
			</tr>
			<tr>
				<td>
					<c:forEach var = "i" begin="1" end = "10">
						별점: <label><input type = "radio" name = "review_starScore" value = "${i }" class = "form-check-input">${i }</label>
					</c:forEach>
				</td>
			</tr>
			</table>
			<button class = "btn btn-primary btn-xl" type = "submit">리뷰 작성하기</button>
			<button class = "btn btn-primary btn-xl" type = "submit" onclick="location.href='history(-1)'">취소</button>
		</form>
	</div>
</div>

<%@ include file="../layout/footer.jsp" %>