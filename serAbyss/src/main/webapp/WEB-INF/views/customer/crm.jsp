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
			<option value="reserve_engiid">담당 엔지니어</option>
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
			<td>
				<p><input class = "gao${dto.reserve_idx }" type = "hidden" name = "reserve_idx" value = "${dto.reserve_idx }"></p>
				<input class="gao${dto.reserve_idx }" id="gao${dto.reserve_idx }" type="button" value="응대기록가져오기 ">
				
				
			</td>
		</tr>
		</c:forEach>
	</table>
	</div>
	<br/><br/>
	<div class = "gender">
		<h2>가져온 응대기록</h2>
	</div>
	<div>
		<h2>기록 남기기</h2>
			<form method="POST" id="insertForm">
				<input id="custMemo_reservie_idx" type = "hidden" name="custMemo_reserve_idx" value="${dto.reserve_idx }">
				<textarea id="custMemo" class="textareastyle" name="custMemo_comments"></textarea>
				<input id="custMemoBtn" name="insert-btn" type ="submit" value="다음">
			</form>
	</div>
</div>

<script>
document.querySelectorAll('td > input').forEach(input => input.onclick = function(event){
	const className = event.target.className
	const reserve_idx = document.querySelector('input.' + className).value
	
	const url = '${cpath}/crm/' + reserve_idx
	const opt = { 
			method : 'GET'
			}
	fetch(url, opt).then(resp => resp.json())
	.then(json => {
		if(document.querySelector('table.' + 'counterListTable') != null){
			document.querySelector('table.' + 'counterListTable').remove()
		}
		if(document.querySelector('div.' + 'noServComment') != null){
			document.querySelector('div.' + 'noServComment').remove()
		}
	if(json != ''){
		const table = document.createElement('table')
		table.classList.add('counterListTable')
		const headTr = document.createElement('tr')
		const regTh = document.createElement('th')
		const commentsTh = document.createElement('th')
		regTh.innerText = '응대 날짜'
		commentsTh.innerText = '내용'
		headTr.appendChild(regTh)
		headTr.appendChild(commentsTh)
		table.appendChild(headTr)
		for(let i=0;i<json.length;i++){
			var contentTr = document.createElement('tr')
			var regTd = document.createElement('td')
			var commentsTd = document.createElement('td')
			
			var custMemo_reg = json[i].CUSTMEMO_REG
			regTd.innerText = custMemo_reg
			
			var custMemo_comments = json[i].CUSTMEMO_COMMENTS
			commentsTd.innerText = custMemo_comments
			
			contentTr.appendChild(regTd)
			contentTr.appendChild(commentsTd)
			
			table.appendChild(contentTr)
		}
		document.querySelector('div.' + 'gender').appendChild(table)
	}
	else{
		const div = document.createElement('div')
		div.classList.add('noServComment')
		div.innerText = '응대기록이 없습니다'
		document.querySelector('div.' + 'gender').appendChild(div)
	}
	})
})

</script>




<%@ include file="../layout/footer.jsp" %>
