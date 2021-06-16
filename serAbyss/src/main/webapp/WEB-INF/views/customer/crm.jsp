<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/header.jsp" %>

<style>
button { width:80px;height:35px}
.textareastyle {width:40%; height:300px;} 

</style>

<div class="container">

<div>
	<h2>응대 기록 검색하기<br/></h2>
	
	<form method="POST">
	<select name="selectedWord" style="height:35px;">
		<option value="service_name">고객명</option>
		<option value="service_phone">전화번호</option>
		<option value="service_address">주소의 일부</option>0
		<option value="service_engiid">담당 엔지니어</option>
		<option value="service_idx">서비스번호</option>
	</select>
	 <input type="text" name="word"/>
	 <%--	select * from TABLE where ${c_word} = #{word} --%> 
	<button>검색</button>
	</form>
</div>

<!-- 
 service

service_idx(PK)      sequence
service_id      session 유저 id값 받아와서 저장
service_title      not null
service_content      not null
service_status      (R(접수)/A(배정)/P(지불)/C(완료))
service_address      session 유저 address 받아와서 저장
service_reg      default to_string('sysdate', 'yyyy-mm-dd')
service_engineer   글 작성시 '없음', 이후 기사가 배정 버튼 눌렀을때 바뀌도록
service_viewcount   default 0

-->
<table border="1">
	<tr>
		<th>서비스신청일</th>
		<th>서비스번호</th>
		<th>서비스상태</th>
		<th>고객명</th>
		<th>담당엔지니어</th>
		<th>주소</th>
		<th>phone</th>
	</tr>
	<tr>
		<td>${dto.service_reg}</td>
		<td>${dto.service_idx }</td>
		<td>${dto.service_status }</td>
		<td>고객명</td>
		<td>${dto.service_engineer }</td>
		<td>${dto.service_address }</td>
		<td>010-0000-0000</td>
	</tr>
</table>
<br/><br/>
	<table>
		<tr>
			<th width="50px">응대한 날짜</th>
			<th>내용</th>
		</tr>
		<tr>
			<td>2021-06-15</td>
			<td>선반 수리</td>
		</tr>
		<tr>
			<th>xx</th>
			<th>작성하기</th>
		</tr>
		<tr>
			<td align="right" colspan='2'><textarea class="textareastyle" ></textarea></td>
		</tr>
		<tr>
			<td align="right" colspan='2'><button>등록</button></td>
		</tr>
	</table>






</div>


<%@ include file="../layout/footer.jsp" %>
