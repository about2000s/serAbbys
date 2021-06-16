<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<div>
<h2>예약시간 구현</h2>
</div>

<div>
	<c:forEach var = "i" items = "${list }">
		<label><input type = "radio" class = "reserveTime" id = "${i }" name = "reserveTime" value = "${i }">${i }</label>
	</c:forEach>
</div>

<div>
좋은생각이 떠올랐어요. radio의 버튼을 하나 눌러 service 제출을 하면 reserveTime 테이블에 061422(06월 14일 22시), engiId = kim123 이렇게 저장을 한다!
그럼 그 저장된 값을 기사를 선택할 때 불러와서 이미 찍힌 값은 삭제해버린다. 그럼 고객은 나머지 시간대를 고를 수 있겠지.
</div>

<%@ include file="../layout/footer.jsp" %>