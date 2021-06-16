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
		<option value="service_address">주소의 일부</option>
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
	<c:forEach var="dto" items="${list }">
	<tr>
		<td>${dto.service_idx }</td>
		<td>${dto.service_reg}</td>
		<td>${dto.service_status }</td>
		<td>${dto.service_name }</td>
		<td>${dto.service_engineer }</td>
		<td>${dto.service_address }</td>
		<td>${dto.service_phone } + sms + copy </td>
		
		<td>
			<p><input class = "gao${dto.service_idx }" type = "hidden" name = "service_idx" value = "${dto.service_idx }"></p>
			<input class = "gao${dto.service_idx }" id = "gao${dto.service_idx }" type = "button" value = "고객응대내역보러가기 ㄱㄱ">
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
document.querySelectorAll('td > input').forEach(input => input.onclick = function(event){
	const className = event.target.className
	const service_idx = document.querySelector('input.' + className).value
	
	const url = '${cpath}/crm/' + service_idx
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
			
			var customer_reg = json[i].CUSTOMER_REG
			regTd.innerText = customer_reg
			
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
		div.classList.add('noServComment')
		div.innerText = '검색결과가 없습니다'
		document.querySelector('div.' + 'gender').appendChild(div)
	}
	})
})

</script>




</div>


<%@ include file="../layout/footer.jsp" %>
