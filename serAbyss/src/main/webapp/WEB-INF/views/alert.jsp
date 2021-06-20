<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="layout/header.jsp" %>
<script>
	alert('${msg}')
	if('${msg}' == '회원가입 성공') location.replace('${cpath}')
	if('${msg}' == '회원가입 실패' || '${msg}' == '아이디 또는 비밀번호가 일치하지 않습니다.') history.go(-1)
	if('${msg}' == '글수정 성공') location.replace('${cpath}/board/reviewRead?review_idx=${review_idx}')
	if('${msg}' == '리뷰작성 성공') location.replace('${cpath}/board/review_list_all')
</script>
</body>
</html>