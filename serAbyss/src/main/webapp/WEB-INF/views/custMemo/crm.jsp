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
						<input class = "gao${dto.reserve_idx } main" type="hidden" name="reserve_idx" value="${dto.reserve_idx }">
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
	const type = document.querySelector('option[value="${map.type}"]') // map에는 type(검색 유형)이 담겨있다. 예를들어 폰번호로 검색했다면 reserve_phone이 있는 것이다
	//그러한 value를 가진 option을 쿼리셀렉터 해서 type에 저장하는 거다. 그럼 그 type은 <option value="reserve_phone">전화번호</option> 이 되겠다.
	type.setAttribute('selected', 'selected')// 그러한 type에 선택되도록 하는 속성값을 부여하는 것이다.
</script>

<script>
	document.getElementById('insertForm').onsubmit = function(event){
		event.preventDefault()
		const a = document.getElementById('a')
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
			document.querySelector('input#gao' + a.value).click()
		})
	}
</script>

<script>
	document.querySelectorAll('td > input').forEach(input => input.onclick = function(event){
		const className = event.target.className // gao ...
		const reserve_idx = document.querySelector('input.' + className).value
		console.log(className)
		// 여기서 event.target은 button이다 그러한 버튼의 이전 자식에 대한 value 즉, 1이나 3 , 5 가 될 수 있겠다.
		const newValue = event.target.previousElementSibling.value
		console.log('newValue: ' + newValue)
		document.getElementById('a').value = newValue // 그러한 newValue를 id가 a인 녀석의 value에 주입하는 것이다.
		
		
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
		if(json != ''){ // 테이블을 만드는 과정이다. 일일이 설명하는 건 설명할 내용이 많으므로 모르시는 문법은 구글링 하시면 됩니다!
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
<%@ include file="../layout/footer.jsp" %>