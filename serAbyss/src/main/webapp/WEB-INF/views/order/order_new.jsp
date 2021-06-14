<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<div class="container">
	<form method="post" enctype="multipart/form-data">
		<div class="order">
			<div>
				<p>
			<%-- 		<c:when test="${login.person_check }.equals('cust')"> --%>
			<%-- 			<input type="text" value="${login.person_id }" readonly> --%>
			<%-- 		</c:when> --%>
			<%-- 		<c:otherwise> --%>
			<!-- 			<input type="text" placeholder="고객id입력" required> -->
			<%-- 		</c:otherwise> --%> <!-- 나중에 로그인 session 비교해서 값 들어가게끔 설정 -->
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
		<%-- 	</c:when> --%> <!-- 로그인 session 비교해서 로그인 한 사람이 기사면 바로 본인 id가 입력되게 -->
		<input type="hidden" name="service_status" value="register">
		<div class="order">
			<p><input type="text" name="service_engineer" value="없음" readonly></p>
		</div>
		<div class="order">
			<input type="submit" value="신청하기">
		</div>
	</form>
</div>
<%@ include file="../layout/footer.jsp" %>