<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../layout/header.jsp" %>



<section class="page-section">
	<div class="container">
		<h2>Target Sort</h2>
		<hr>
		<form>
		<table border="1px">
			<tr>
				<th>전체회원선택</th>
				<td><input type="radio"><label>전체회원</label></td></tr>
			<tr>
				<th><label>연령별 : </label></th></tr>
				<td><input type="radio" value="man"><label>20-29</label>
					<input type="radio" value="women"><label>30-39</label>
					<input type="radio" value="women"><label>40-49</label></td></tr>
			<tr><td colspan="2"><button>검색</button></td></tr>
		</table>
		<table border="1px">
			<tr>
				<th>발송대상 회원수</th>
				<td>0000명 검색되었습니다.</td></tr>
			<tr>
				<th>제목 입력</th>
				<td><input type="text" placeholder="이메일 제목"></td></tr>
			<tr>
				<th>내용입력</th>
				<td><textarea width="200px" height="200px" placeholder="내용입력"></textarea></td></tr>
			<tr><td colspan="2"><button>이메일 전송</button></td></tr>
		</table>
		</form>
	</div>
</section>

