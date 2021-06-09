<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>
<!--  -->
<form method="post">
	<div class="order">
		<p>
	<%-- 		<c:when test="${login.person_check }.equals('cust')"> --%>
	<%-- 			<input type="text" value="${login.person_id }" readonly> --%>
	<%-- 		</c:when> --%>
	<%-- 		<c:otherwise> --%>
	<!-- 			<input type="text" placeholder="고객id입력" required> -->
	<%-- 		</c:otherwise> --%> <!-- 나중에 로그인 session 비교해서 값 들어가게끔 설정 -->
			<input type="text" placeholder="고객id입력" required>
		</p>
		<p>
			<input type="text" placeholder="제목 입력" required>
		</p>
		<p><textarea class="write-area" name="content" required></textarea></p>
		<p><input type="text" placeholder="주소 입력" required></p>
	<%-- 	<c:when test="${login.person_check }.equals('cust')"> --%>
	<!-- 		<p><input type="text" value="없음" readonly></p> -->
	<%-- 	</c:when> --%>
	<%-- 	<c:when test="${login.person_check } == 'noCompEngi' or 'yesCompEngi'"> --%>
	<%-- 		<p><input type="text" value="${login.person_id }" readonly></p> --%>
	<%-- 	</c:when> --%> <!-- 로그인 session 비교해서 로그인 한 사람이 기사면 바로 본인 id가 입력되게 -->
		<p><input type="text" value="없음" readonly></p>
		<input type="submit" value="신청하기">
	</div>
</form>
<%@ include file="../layout/footer.jsp" %>