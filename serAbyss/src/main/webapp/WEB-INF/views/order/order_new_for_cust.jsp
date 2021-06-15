<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<div class="container">
	<h2>고객이 서비스 신청하기</h2>
	<hr/>
	<form method="post" enctype="multipart/form-data">
	<input type = "hidden" name = "custId" value = "${login.person_id }">
	<input type = "hidden" name = "address" value = "${login.person_address }">
	<table>
		<tr>
			<th>제목입력</th>
			<td><input type="text" name="service_title" placeholder="제목 입력" required></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea class="write-area" name="service_content" required>모델명: ...</textarea></td>
		</tr>
		<tr>
			<th>파일입력</th>
			<td><input type="file" name="file"></td>
		</tr>
		<tr>
			<td colspan='2'><input type="submit" value="신청하기"></td>
		</tr>
	</table>
	
	<div>
		<h2>월 선택</h2>
		<c:forEach var = "i" items = "${monthList }">
			<label><input type = "radio" name = "month" value = "${i }" class = "">${i }월</label>
		</c:forEach>
		<h2>날짜 선택</h2>
		<c:forEach var = "j" items = "${dayList }">
			<label><input type = "radio" name = "day" value = "${j }">${j }일</label>
		</c:forEach>
		
		
<!-- 		<h2>시간대 선택</h2> -->
<%-- 		<c:forEach var = "k" items = "${hourList }"> --%>
<%-- 			<c:forEach var = s items = "${k }"> --%>
<!-- 				<label><input type = "radio" name = "hour">a</label> -->
<%-- 			</c:forEach> --%>
<%-- 		</c:forEach> --%>
	</div>
	
	
	
	
	</form>
	
<%@ include file="../layout/footer.jsp" %>