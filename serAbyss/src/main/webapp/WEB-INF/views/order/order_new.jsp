<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<div class="container">
	<h2>서비스 신청하기</h2>
	<hr/>
	<form method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<th>고객아이디입력</th>
			<td><input type="text" name="service_id" placeholder="고객id입력" required></td>
		</tr>
		<tr>
			<th>제목입력</th>
			<td><input type="text" name="service_title" placeholder="제목 입력" required></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea class="write-area" name="service_content" required></textarea></td>
		</tr>
		<tr>
			<th>파일입력</th>
			<td><input type="file" name="file"></td>
		</tr>
		<tr>
			<th>주소입력</th>
			<td><input type="text" name="service_address" placeholder="주소 입력" required></td>
		</tr>
		<tr>
			<th>담당엔지니어</th>
			<td><input type="text" name="service_engineer" value="없음" readonly></td>
		</tr>
		<tr>
			<td colspan='2'><input type="submit" value="신청하기"></td>
		</tr>
	</table>
	</form>
	
<!--  210614 기찬씨 나중에 보고 c:구문만 살려서 쓰시고 지워주세요 : 남형진

	<form method="post" enctype="multipart/form-data">
		<div class="order">
			<div>
				<p>
			<%-- 		<c:when test="${login.person_check }.equals('cust')"> --%>
			<%-- 			<input type="text" value="${login.person_id }" readonly> --%>
			<%-- 		</c:when> --%>
			<%-- 		<c:otherwise> --%>
			<!-- 			<input type="text" placeholder="고객id입력" required> -->
			<%-- 		</c:otherwise> --%> <!-- 나중에 로그인 session 비교해서 값 들어가게끔 설정 --
					<input type="text" name="service_id" placeholder="고객id입력" required>
				</p>
				<p>
					<input type="text" name="service_title" placeholder="제목 입력" required>
				</p>
			</div>
		</div>
		<div class="content">
			<textarea class="write-area" name="service_content" required></textarea>
		</div>
		<div class="order">
			<p>
				<input type="file" name="file">
			</p>
		</div>
		<div class="order">
			<p><input type="text" name="service_address" placeholder="주소 입력" required></p>
		</div>
		<%-- 	<c:when test="${login.person_check }.equals('cust')"> --%>
		<!-- 		<p><input type="text" value="없음" readonly></p> -->
		<%-- 	</c:when> --%>
		<%-- 	<c:when test="${login.person_check } == 'noCompEngi' or 'yesCompEngi'"> --%>
		<%-- 		<p><input type="text" value="${login.person_id }" readonly></p> --%>
		<%-- 	</c:when> --%> <!-- 로그인 session 비교해서 로그인 한 사람이 기사면 바로 본인 id가 입력되게 --
		<input type="hidden" name="service_status" value="register">
		<div class="order">
			<p><input type="text" name="service_engineer" value="없음" readonly></p>
		</div>
		<div class="order">
			<input type="submit" value="신청하기">
		</div>
	</form>
</div> -->
<%@ include file="../layout/footer.jsp" %>