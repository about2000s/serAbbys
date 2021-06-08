<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--  <link href="/bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script> -->

<title>엔지니어를 위한 플랫폼 써어-비스(SerAbbys)</title>
<style>
.topmenubar { width:100%;  }
.topmenubar .toplogo { width:15%;border:1px solid black; }
.navi { width:100%; border:1px solid red;}
.navi ul li { font-size:8px; margin-right:20px; display:inline; font-size:22px; list-style:none;}
.leftmenu { width:10%; list-style:none; border:2px solid blue; } 
</style>

<div class="topmenubar">
	<div class="toplogo"><a href="${cpath }">로고자리</a></div>
	<div class="navi">
		<ul>
			<li><a href="">기본정보관리</a></li>
			<li><a href="">서비스관리</a></li>
			<li><a href="">Login/Logout</a></li>
		</ul>
	</div>
</div>

<div class="leftmenu">
	<ul>
		<li><a href="">서비스신청(reg)</a></li>
		<li><a href="">서비스준비중(accept=기사배정완료)</a></li>
		<li><a href="">서비스중(기사도착완료)</a></li>
		<li><a href="">서비스완료</a></li>
		<li><a href="">결제완료(pay)</a></li>
		<li><a href="">환불접수</a></li>
		<li><a href="">처리완료(comp)</a></li>
		<li><a href=""></a></li>
		<li><a href=""></a></li>
	</ul>
</div>
</head>
<body>

  