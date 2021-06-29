<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<section class="page-section">
	<div class = "container">
		<form method = "post">
			<table class = "table dataTable-table">
				<tr>
					<td>
						<div>
							<h2>담당 기사</h2>
							<c:forEach var = "i" items = "${engiList }">
								<label><input type = "radio" name = "reserveTime_engiId" value = "${i.person_id }" checked class = "form-check-input">${i.person_id }</label>
							</c:forEach>
						</div>
						<hr>
						<div style = "margin-top: 50px;">
							<h2>날짜 선택</h2>
							<c:forEach var = "j" items = "${dayList }">
								<label><input type = "radio" name = "reserveTime_day" value = "${j }" class = "form-check-input">${j }</label>
							</c:forEach>
						</div>
						<hr>
						<div style = "margin-top: 50px;">
							<h2>시간 선택(이미 예약이 되어있는 시간은 비어있습니다)</h2>
	<%-- 						<c:forEach var = "i" items = "${engiIdList }"> --%>
								<c:forEach var = "j" items = "${dayList }">
									<c:forEach var = "k" items = "${reserveTimeList }">
										<c:if test="${k.day == j }">
											<div class = "day${j } hiddenNone main">
												<label><input type = "radio" name = "reserveTime_hour" value = "${k.hour }" class = "form-check-input">${k.hour }:00</label>
											</div>
										</c:if>
									</c:forEach>
								</c:forEach>
	<%-- 						</c:forEach> --%>
						</div>
					</td>
				</tr>
			</table>
		</form>
		<button class = "btn btn-primary btn-xl" type = "submit" id = "submitBtn" disabled="disabled">예약시간 변경하기</button>
		<button class = "btn btn-primary btn-xl" onclick="history.back()">취소</button>
	</div>
</section>

<script>
const submitBtn = document.getElementById('submitBtn')
let dayFlag = false
let hourFlag = false

$('input[name="reserveTime_day"]').change(function(event){
	console.log($('input[name="reserveTime_day"]:checked').val())
	if($('input[name="reserveTime_day"]:checked').val()) dayFlag = true
	console.log('dayFlag: ' + dayFlag)
	check()
})
$('input[name="reserveTime_hour"]').change(function(){
	console.log($('input[name="reserveTime_hour"]:checked').val())
	if($('input[name="reserveTime_hour"]:checked').val()) hourFlag = true
	console.log('hourFlag: ' + hourFlag)
	check()
})

function check(event){
	if(dayFlag && hourFlag){
		submitBtn.disabled = false
	}
	else{
		submitBtn.disabled = true
	}
}
</script>

<script>

document.getElementById('submitBtn').onclick = function(event){
	event.preventDefault()
	const cf = confirm('정말로 예약시간을 변경하시겠습니까?')
	if(cf){
		document.forms[0].submit()
	}
}

// let className1
let className2
let classFullName

// document.querySelectorAll('input[name="reserveTime_engiId"]').forEach(input => input.onclick = function(event){
// 	className1 = event.target.value
// 	classFullName = className1 + 'day' + className2
// 	document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
// 	document.querySelectorAll('div.' + classFullName).forEach(div => div.classList.remove('hiddenNone'))
// });

document.querySelectorAll('input[name="reserveTime_day"]').forEach(input => input.onclick = function(event){
	className2 = event.target.value
	classFullName = 'day' + className2
	document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
	document.querySelectorAll('div.' + classFullName).forEach(div => div.classList.remove('hiddenNone'))
});
</script>

<%@ include file="../layout/footer.jsp" %>