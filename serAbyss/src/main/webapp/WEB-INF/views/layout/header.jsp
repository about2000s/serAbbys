<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<c:set var = "cpath" value = "${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>기술로 세상을 밝히다</title>

<link href="${cpath }/resources/css/styles.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Alfa+Slab+One&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<!--  -->

<!--  <link href="/bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script> -->
<!-- 커밋 테스트 -->

<title>엔지니어를 위한 플랫폼 써어-비스(SerAbbys)</title>
<div class="topmenubar">
	<div class="toplogo"><a href="${cpath }"><img src="${cpath }/resources/img/logo.png"></a></div>
	<div class="menubar">
		<ul>
			<li><a href="${cpath }/common/myPage">기본정보관리</a></li>
			<li><a href="${cpath }/order/statusList?page=1&service_status=">서비스관리</a></li>
			
			<!-- 여기서부터 재훈이가 수정했습니다. -->
			<c:if test="${login != null}">
				<li><a href="${cpath }/common/logout">Logout</a></li>
			</c:if>
			
			<c:if test="${login == null}">
				<li><a href="${cpath }/common/login">Login</a></li>
				<li><a href="${cpath }/common/join">회원가입</a></li>
			</c:if>
			<!-- 여기까지 -->
			<li><a href="${cpath }/board/review_list_all?page=1">리뷰 보러가기</a></li>
			
			<!-- 여기서부터 재훈이가 수정했습니다. -->
			<li><a href="${cpath }/customer/crm">고객응대하기</a></li>
			<li><a href="${cpath }/board/serCen?page=1">고객센터(자주 묻는 질문)</a></li>
			<li><a href="${cpath }/order/order_new_for_cust">고객이 서비스 신청하러 가기!</a></li>
			<!-- 여기까지 -->
		</ul>
	</div>
</div>

<c:if test="${login.person_check == 'r'}"></c:if>
<c:if test="${login.person_check == 'y'}"></c:if>
<c:if test="${login.person_check == 'n'}"></c:if>
<c:if test="${login.person_check == 'a'}"></c:if>
</head>
<body>

  