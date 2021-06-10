<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="layout/header.jsp" %>

<div>
	<button onclick = "location.href='${cpath}/common/join'">회원가입</button>  <button onclick = "location.href='${cpath}/common/login'">로그인</button>
</div>
<hr>
=======

<button onclick = "location.href='${cpath}/common/updateInfo'">마이페이지</button>

<%@ include file = "layout/footer.jsp" %>