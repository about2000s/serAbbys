<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<div class="container">
	<h2>고객이 서비스 신청하기</h2>
	<hr/>
	<form method="post" enctype="multipart/form-data">
	<input type = "hidden" name = "custId" value = "${login.person_id }">
	<input type = "hidden" name = "address" value = "${login.person_address }">
	<table>
		<tr>
			<th>제목입력</th>
			<td><input type="text" name="service_title" placeholder="제목 입력" required></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea class="write-area" name="service_content" required>모델명: ...</textarea></td>
		</tr>
		<tr>
			<th>파일입력</th>
			<td><input type="file" name="file"></td>
		</tr>
		<tr>
			<td colspan='2'><input type="submit" value="신청하기"></td>
		</tr>
	</table>
	<hr>
	
	
	<div>
		<h2>수리기사 선택</h2>
		<c:forEach var = "engi" items = "${engiIdList }">
			<label><input type = "radio" name = "engiId" value = "${engi }">${engi }</label>
		</c:forEach>
	</div>
	<hr>
	
	<div>
		<h2>월 선택</h2>
		<c:forEach var = "month" items = "${monthList }">
			<label><input type = "radio" name = "month" value = "${month }">${month }</label>
		</c:forEach>
	</div>
	<hr>
	
	<div>
		<h2>일 선택</h2>
		<c:forEach var = "day" items = "${dayList }">
			<label><input type = "radio" name = "day" value = "${day }">${day}</label>
		</c:forEach>
	</div>
	<hr>
	
	
	
<!-- 	<div> -->
<!-- 		<h2>월 선택</h2> -->
<%-- 		<c:forEach var = "month" items = "${monthList }"> --%>
<%-- 			<label><input type = "radio" name = "month" value = "${month }" checked>${month }월</label> --%>
<%-- 		</c:forEach> --%>
		
<!-- 		<h2>날짜 선택</h2> -->
<%-- 		<c:forEach var = "day" items = "${dayList }"> --%>
<%-- 			<label><input type = "radio" name = "day" value = "${day }" id = "day${day }">${day }일</label> --%>
<%-- 		</c:forEach> --%>

<%-- 		<c:set var = "sD" value = "${startDay }"/> --%>
<!-- 		<h2>시간대 선택</h2> -->
<%-- 		<c:forEach var = "k" items = "${hList }"> --%>
<%-- 			<div class = "main hiddenNone day${sD }"> --%>
<%-- 			<c:forEach var = "s" items = "${k }"> --%>
<%-- 				<label><input type = "radio" name = "hour" value = "${s }">${s }시</label> --%>
<%-- 			</c:forEach> --%>
<%-- 				<c:set var = "sD" value = "${sD + 1 }"/> --%>
<!-- 			<hr> -->
<!-- 			</div> -->
			
<%-- 		</c:forEach> --%>
<!-- 	</div> -->


	
	</form>
	
	<c:forEach var = "a" items = "${aMap }">
		달러a: ${a }
		<c:forEach var = "b" items = "${a.value }">
		
			<c:forEach var = "c" items = "${b.value }">
			
				<div class = "main ${a.key }${b.key }${c.key } hiddenNone">
					<c:forEach var = "d" items = "${c.value }">
							<label><input type = "radio" value = "${d }">${d }시</label>
					</c:forEach>
				</div>
			</c:forEach>
		</c:forEach>
		<hr>
	</c:forEach>
	
<script>

const engiId = document.querySelector('input[name="engiId"]').value
const month = document.querySelector('input[name="month"]').value
const day = document.querySelector('input[name="day"]').value
const fullName = engiId + month + day
console.log(fullName)

document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
document.querySelector('div.' + engiId + month + day).classList.remove('hiddenNone')



// 	for(let i=${startDay};i<${startDay} + ${dayCount };i++){
// 		document.getElementById('day' + i).onclick = function(event){
// 			console.log('sd')
// 			document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
// 			document.querySelector('div.' + 'day' + i).classList.remove('hiddenNone')
// 		}
// 	}
</script>
	
<%@ include file="../layout/footer.jsp" %>