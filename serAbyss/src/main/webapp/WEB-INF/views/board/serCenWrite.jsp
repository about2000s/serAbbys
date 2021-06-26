<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<section class="page-section">
	<div class="card mb-4 container">
		<c:if test="${serCen_belong == 'faq' }"><h2>FAQ 작성하는 곳</h2></c:if>
		<c:if test="${serCen_belong == 'notice' }"><h2>공지사항 작성하는 곳</h2></c:if>
		<div class="card-body">
			<form method = "post">
				<input type = "hidden" name = "serCen_id" value = "${login.person_id }">
				<table class = "table dataTable-table">
					<tr>
						<td><input type = "text" name = "serCen_title" placeholder="제목 입력" class = "form-control" style = "width: 20%;"></td>
					</tr>
					<tr>
						<td><textarea name = "serCen_content" class = "form-control"></textarea></td>
					</tr>
				</table>
				<button class = "btn btn-primary btn-xl" type = "submit">작성하기</button>
				<button class = "btn btn-primary btn-xl" type = "submit" onclick="location.href='history(-1)'">취소</button>
			</form>
		</div>
	</div>
</section>
<%@ include file="../layout/footer.jsp" %>