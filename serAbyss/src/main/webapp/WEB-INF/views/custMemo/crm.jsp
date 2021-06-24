<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/customerLeftMenu.jsp" %>

<style>
button { width:80px;height:35px}
.textareastyle {width:40%; height:300px;} 
</style>
<div class="container">
	<div>
		<h2>응대 기록 검색하기<br/></h2>
		<form method="POST">
		<select name="selectedWord" style="height:35px;">
			<option value="reserve_name">고객명</option>
			<option value="reserve_phone">전화번호</option>
			<option value="reserve_address">주소의 일부</option>
			<option value="reserve_engiId">담당 엔지니어</option>
			<option value="reserve_idx">서비스번호</option>
		</select>
		 <input type="text" name="word"/>
		<button>검색</button>
		</form>
	</div>
	<div>
	<table border="">
		<tr>
			<th width="10%">서비스신청일</th>
			<th width="10%">서비스번호</th>
			<th width="5%">서비스상태</th>
			<th width="10%">고객명</th>
			<th width="10%">담당엔지니어</th>
			<th width="20%">주소</th>
			<th width="10%">phone</th>
			<th width="5%">응대기록</th>
		</tr>
		<c:forEach var="dto" items="${list }">
		<tr>
			<td>${dto.reserve_reg}</td>
			<td>${dto.reserve_idx }</td>
			<td>${dto.reserve_status }</td>
			<td>${dto.reserve_name }</td>
			<td>${dto.reserve_engiId }</td>
			<td>${dto.reserve_address }</td>
			<td>${dto.reserve_phone } + sms + copy </td>
			
			<%--<td>
				<p><input class = "gao${dto.reserve_idx }" type="hidden" name="reserve_idx" value="${dto.reserve_idx }"></p>
				<input class = "gao${dto.reserve_idx }" id="gao${dto.reserve_idx }" type="button" value="응대기록가져오기 ">
			</td> --%>
			<td><input type="hidden" id="reserve_idx" value="${dto.reserve_idx }">
				<input type="button" id="custMemoBtn" value="응대기록가져오기" ></td>
		</tr>
		</c:forEach>
	</table>
	</div>
	
	<br/><br/>
		<h2>가져온 응대기록</h2>
	<div class = "gender" id = "apple">
	</div>
	
	<div>
		<h2>기록 남기기</h2>
			<form method="POST" id="insertForm">
				<input id="custMemoServiceIdx" type="hidden" name="custMemo_service_idx" value="${dto.reserve_idx }">
				<textarea id="content" class="textareastyle" name="custMemo_comments"></textarea>
				<input id="insertBtn" type="submit" value="다음">
			</form>
	</div>
</div>


<script>
document.getElementById('custMemoBtn').onclick=function(event){
// 	event.preventDefault();
	const idx = document.getElementById('reserve_idx').value
	const url='${cpath}/custMemo/crmList/' + idx
	const opt = {
		method : 'GET'			
	}
	console.log(url)
	fetch (url, opt)
	.then (resp => resp.json)
	.then (json => {
		if(json == ''){
			document.getElementById('apple').innerText = '결과 없음'
		}
		else{
			
		}
		
	})
}


document.getElementById('insertForm').onsubmit= function(event) { //form을 submit하면
	console.log('insert !')
	event.preventDefault(); 										//기본작동을 막고
	const formData = new FormData(event.target)						//submit된 form을 기반으로 formData를 생성
																	//화면에 출력
	// 여기서부터 ajax 
	const url = '${cpath}/custMemo/crmInsert'
	const opt = {
			body: formData,
 			//headers: {
 			//'Content-Type' : 'application/json; charset=utf-8'
			//formData를 직접 전송할 때는 header에 Content-Type을 명시하지 말자 
			// form 이용하여 multipart/form-data 형식으로 전송할 때도, 컨텐트 타입을 명시하지 않는다.
	}
	
	fetch(url, opt)
	.then(resp => resp.text())
	.then(text => {
	//	console.log(text)
		if(text == 1) {
			event.target.reset();
			alert('등록성공');
		} else {
			alert('등록실패')
		}
	})
}
</script>


<%@ include file="../layout/footer.jsp" %>
