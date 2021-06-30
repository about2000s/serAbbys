<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value = "${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>기술로 세상을 밝히다</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="${cpath }/resources/assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?	family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${cpath }/resources/css/styles.css" rel="stylesheet" />
<link href="${cpath }/resources/css/custum.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>엔지니어를 위한 플랫폼 써어-비스(SerAbbys)</title>
 <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="${cpath }"><img src="${cpath }/resources/img/logo.png" alt="Ser-Abbys"></a>
                <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto">
                        <!-- 엔지니어 로그인시 메뉴 출력 -->
                        <c:choose>
                        	<%--기사 로그인시 --%>
	                        <c:when test="${login.person_check == 'y' }">
	                        	<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/reserve/reserve_new_for_engi">신청하기</a></li>
				        		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/reserve/statusList?page=1&reserve_status">예약목록보기</a></li>
				        		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/custMemo/crm">고객응대하기</a></li>
				        	</c:when>
				        	<%-- 회사 대표 계정 로그인시 --%>
				        	<c:when test="${login.person_check == 'r' }">
				        		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/reserve/reserve_new_for_engi">신청하기</a></li>
				        		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/reserve/statusList?page=1&reserve_status">예약목록보기</a></li>
				        		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/custMemo/crm">고객응대하기</a></li>
				        		
				        	</c:when>
				        	<c:when test="${login.person_check == 'a' }">
				        		<%-- 마스터 로그인시 --%>
                    	 	    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-1 rounded" href="${cpath }/reserve/reserve_new_for_cust">고객서비스신청</a></li>
				        		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-1 rounded" href="${cpath }/reserve/reserve_new_for_engi">신청하기</a></li>
				        		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-1 rounded" href="${cpath }/reserve/statusList?page=1&reserve_status">예약목록보기</a></li>
                    	 	    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/custMemo/crm">고객응대하기</a></li>
				        	</c:when>
				        	<c:otherwise>
				        		<%-- 고객 로그인시 --%>
				        		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/reserve/reserve_new_for_cust">신청하기</a></li>
				        		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/reserve/statusList?page=1&reserve_status=">내 서비스</a></li>
				      	  	</c:otherwise>
                        </c:choose>
                        <%--공통 사항 --%>
                 		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/board/review_list_all?page=1">리뷰보기</a></li>
                   	 	<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/board/faq?page=1">고객센터</a></li>
                        
                        <c:if test="${login == null }">
                  	        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/common/login">LogIn</a></li>
                    	    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/common/join">회원가입</a></li>
                        </c:if>
                        <c:if test="${login != null }">
                     	    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/common/logout">Logout</a></li>
                        	 <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${cpath }/common/myPage">MyPage</a></li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>
<div class="topmenubar">
	<div class="toplogo"><a href="${cpath }"><img src="${cpath }/resources/img/logo.png"></a></div>
</div>
</head>
