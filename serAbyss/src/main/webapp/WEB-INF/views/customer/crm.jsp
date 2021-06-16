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
<div>
<table border="1">
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
	<c:forEach var="list" items="${list }">
	<tr>
		<td>${list.service_reg}</td>
		<td>${list.service_idx }</td>
		<td>${list.service_status }</td>
		<td>${list.service_name }</td>
		<td>${list.service_engineer }</td>
		<td>${list.service_address }</td>
		<td>${list.service_phone } +sms +copy </td>
		
		<td>
		<form>
			<input type="hidden" id = "customer_service_idx" name="customer_service_idx" value="${list.service_idx }">
			<button id = "gao">가져오기</button>
		</form>
		</td>
	</tr>
	</c:forEach>
</table>
</div>

<br/><br/>
<div class = "gender">
	<h2>가져온 응대기록</h2>
<!-- 	<table id = "listTable"> -->
<!-- 		<tr> -->
<!-- 			<th width="50px">innerText</th> -->
<!-- 			<th>내용</th> -->
<!-- 		</tr> -->
		
<!-- 	</table> -->
<!-- 		<form method="POST"> -->
<!-- 			<tr> -->
<!-- 				<td align="right" colspan="2"><textarea name="customer_comments" class="textareastyle" ></textarea></td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td align="right" colspan="2"><button>등록</button></td> -->
<!-- 			</tr> -->
<!-- 		</form> -->
</div>
<script>
document.getElementById('gao').onclick = function(event){
	event.preventDefault()
	const service_idx = document.getElementById('customer_service_idx').value
	const url = '${cpath}/crm/' + service_idx
	const opt = { 
			method : 'GET'
			}
	fetch(url, opt).then(resp => resp.json())
	.then(json => {
		if(document.querySelector('table.' + 'counterListTable') != null){
			document.querySelector('table.' + 'counterListTable').remove()
		}
		if(document.querySelector('div.' + 'noCompComment') != null){
			document.querySelector('div.' + 'noCompComment').remove()
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
			
			var customer_reg = json[i].CUSTOMER_REG
			regTd.innerText = customer_reg
			console.log(customer_reg)
			
			var customer_comments = json[i].CUSTOMER_COMMENTS
			commentsTd.innerText = customer_comments
			
			contentTr.appendChild(regTd)
			contentTr.appendChild(commentsTd)
			
			table.appendChild(contentTr)
		}
		document.querySelector('div.' + 'gender').appendChild(table)
	}
	else{
		const div = document.createElement('div')
		div.classList.add('noCompComment')
		div.innerText = '검색결과가 없습니다'
		document.querySelector('div.' + 'gender').appendChild(div)
	}
	})
}

</script>




</div>


<%@ include file="../layout/footer.jsp" %>
