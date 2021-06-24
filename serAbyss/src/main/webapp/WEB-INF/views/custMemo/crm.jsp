<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/customerLeftMenu.jsp" %>

<div class="container">
	<div>
		<h2>응대 기록 검색하기</h2>
		<form method="POST">
			<select name="type" class = "form-control" style = "width: 10%; display: inline;">
				<option value="reserve_name">고객명</option>
				<option value="reserve_phone">전화번호</option>
				<option value="reserve_address">주소의 일부</option>
				<option value="reserve_engiId">담당 엔지니어</option>
				<option value="reserve_idx">서비스번호</option>
			</select>
			 <input type="text" name="keyword" value = "${map.keyword }" class = "form-control" style = "width: 30%; display: inline;">
			<button class = "btn btn-primary btn-xl">검색</button>
		</form>
	</div>
	<div>
	<table class = "table dataTable-table">
		<thead>
			<tr>
				<th>서비스 신청일</th>
				<th>서비스번호</th>
				<th>처리 상태</th>
				<th>고객명</th>
				<th>담당엔지니어</th>
				<th>주소</th>
				<th>phone</th>
				<th>응대기록</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${list }">
			<tr>
				<td>${dto.reserve_reg}</td>
				<td>${dto.reserve_idx }</td>
				<td>${dto.reserve_status }</td>
				<td>
				${dto.reserve_name }
				<c:if test="${dto.reserve_custId != null }">(${dto.reserve_custId })</c:if>
				</td>
				<td>${dto.reserve_engiId }</td>
				<td>${dto.reserve_address }</td>
				<td>${fn:substring(dto.reserve_phone, 0, 3)}-${fn:substring(dto.reserve_phone, 3, 7)}-${fn:substring(dto.reserve_phone, 7, 11)}</td>
				
				<td>
					<p><input class = "gao${dto.reserve_idx }" type="hidden" name="reserve_idx" value="${dto.reserve_idx }"></p>
					<input class = "gao${dto.reserve_idx }" id="gao${dto.reserve_idx }" type="button" value="응대기록가져오기 ">
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
	<h2>가져온 응대기록</h2>
	<div class="gender" id="recordList">
	</div>
	
	<div class = "hiddenNone record">
		<h2>기록 남기기</h2>
			<form id="insertForm">
				<input type="hidden" id = "a" name="custMemo_reserve_idx" value="">
				<textarea id = "b" class="form-control" name="custMemo_comments"></textarea>
				<input id="insertBtn" type="submit" value="다음" class = "btn btn-primary btn-xl">
			</form>
	</div>
</div>

<script>
const type = document.querySelector('option[value="${map.type}"]')
type.setAttribute('selected', 'selected')
</script>

<script>
document.getElementById('insertForm').onsubmit = function(event){
	event.preventDefault()
	const a = document.getElementById('a').value
	const b = document.getElementById('b')
	const formData = new FormData(event.target)
	const ent = formData.entries()
	let ob = {}
	while(true){
		next = ent.next()
		if(next.done) break;
		ob[next.value[0]] = next.value[1]
	}
	const json = JSON.stringify(ob)
	console.log('json: ' + json)
	const url = '${cpath}/record'
	const opt = {
			method: 'POST',
			body: json,
			headers: {
				'Content-Type': 'application/json; charset=utf-8'
			}
	}
	fetch(url, opt).then(resp => resp.text())
	.then(text => {
		b.value = ''
		document.querySelector('input#gao' + a).click()
	})
}
</script>

<script>
document.querySelectorAll('td > input').forEach(input => input.onclick = function(event){
	const className = event.target.className // gao ...
	const reserve_idx = document.querySelector('input.' + className).value
	console.log(className)
	document.getElementById('a').value = document.querySelector('input[name="reserve_idx"]').value
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
		document.querySelector('div.record').classList.remove('hiddenNone')
	if(json != ''){
		const table = document.createElement('table')
		table.classList.add('counterListTable', 'table', 'dataTable-table')
		const thead = document.createElement('thead')
		const headTr = document.createElement('tr')
		const regTh = document.createElement('th')
		const commentsTh = document.createElement('th')
		regTh.innerText = '응대 날짜'
		commentsTh.innerText = '내용'
		headTr.appendChild(regTh)
		headTr.appendChild(commentsTh)
		thead.appendChild(headTr)
		table.appendChild(thead)
		const tbody = document.createElement('tbody')
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
			
			tbody.appendChild(contentTr)
			
			table.appendChild(tbody)
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


<script>
// document.getElementById('custMemoBtn').onclick=function(event){
// // 	event.preventDefault();
// 	const idx = document.getElementById('reserve_idx').value
// 	const url='${cpath}/custMemo/crmList/' + idx
// 	const opt = {
// 		method : 'GET'			
// 	}
// 	console.log(url)
// 	fetch (url, opt)
// 	.then (resp => resp.json)
// 	.then (json => {
// 		if(json == ''){
// 			document.getElementById('recordList').innerText = '결과 없음'
// 		}
// 		else {
// 			const custDiv = document.createElement('div')
// 			console.log(json)
// 			document.getElementById('recordList').innerText = json
			
			
// 		}
		
// 	})
// }


// document.getElementById('insertForm').onsubmit= function(event) { //form을 submit하면
// 	console.log('insert !')
// 	event.preventDefault(); 										//기본작동을 막고
// 	const formData = new FormData(event.target)						//submit된 form을 기반으로 formData를 생성
// 																	//화면에 출력
// 	// 여기서부터 ajax 
// 	const url = '${cpath}/custMemo/crmInsert'
// 	const opt = {
// 			body: formData,
//  			//headers: {
//  			//'Content-Type' : 'application/json; charset=utf-8'
// 			//formData를 직접 전송할 때는 header에 Content-Type을 명시하지 말자 
// 			// form 이용하여 multipart/form-data 형식으로 전송할 때도, 컨텐트 타입을 명시하지 않는다.
// 	}
	
// 	fetch(url, opt)
// 	.then(resp => resp.text())
// 	.then(text => {
// 	//	console.log(text)
// 		if(text == 1) {
// 			event.target.reset();
// 			alert('등록성공');
// 		} else {
// 			alert('등록실패')
// 		}
// 	})
// }
</script>


<%@ include file="../layout/footer.jsp" %>
