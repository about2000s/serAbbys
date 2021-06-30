<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<section class="page-section">
	<div class = "container">
		<div class = "email main">
			<h2>아이디 찾는 곳입니다</h2>
			<h2>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</h2>
			<table class = "table dataTable-table">
				<tr>
					<td width="5%" style = "vertical-align: middle;">이름</td>
					<td><input type = "text" name = "input_name" id = "input_name" class = "form-control" style = "width: 20%; display: inline;"></td>
				</tr>
				<tr>
					<td width="5%" style = "vertical-align: middle;">이메일</td>
					<td>
						<input type = "email" name = "input_email" id = "input_email" class = "form-control" style = "width: 20%; display: inline;">
						<button id = "receiveAuthBtn" class = "btn btn-primary btn-sm" style = "height: 37px; margin-bottom: 3px;">인증번호 받기</button>
						<div class = "check_font" id = "email_checkDiv"></div>
						<div class = "hiddenNone" id = "authMailDiv">
						<input type = "text" id = "authNumber" name = "authNumber" placeholder="인증번호 입력" class = "form-control" style = "width: 20%; display: inline;">
						<button id = "injung" class = "btn btn-primary btn-sm" style = "height: 37px; margin-bottom: 3px;">인증하기</button>
						<div id = "injungSuccessDiv"></div>
							<div class = "hiddenNone" id = "injungform">
								<form method = "post" action = "${cpath }/common/findIdByEmail">
									<input type = "hidden" name = "person_check" value = "${person_check }">
									<input type = "hidden" id = "person_name" name = "person_name">
									<input type = "hidden" id = "person_email" name = "person_email">
									<input type = "submit" value = "다음" class = "btn btn-primary btn-sm" style = "height: 37px; margin-bottom: 3px;">
								</form>
							</div>
						</div>
					</td>
				</tr>
			</table>
			<div class = "hiddenNone" id = "authMailDiv">
				<input type = "text" id = "authNumber" name = "authNumber" placeholder="인증번호 입력" class = "form-control" style = "width: 20%; display: inline;">
				<button id = "injung" class = "btn btn-primary btn-sm" style = "height: 37px; margin-bottom: 3px;">인증하기</button>
				<div id = "injungSuccessDiv"></div>
				<div class = "hiddenNone" id = "injungform">
					<form method = "post" action = "${cpath }/common/findIdByEmail">
						<input type = "hidden" name = "person_check" value = "${person_check }">
						<input type = "hidden" id = "person_name" name = "person_name">
						<input type = "hidden" id = "person_email" name = "person_email">
						<input type = "submit" value = "다음" class = "btn btn-primary btn-xl">
					</form>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
	// id값이 input_name인 곳에 입력하는 값의 정보를 그대로 id값이 person_name인 곳에도 입력시킴
	$("#input_name").keydown(function(){
	    $('#person_name').val($(this).val());
	});
	$("#input_name").change(function(){
	    $('#person_name').val($(this).val());
	});
</script>

<script>
	// id값이 input_email인 곳에 입력하는 값의 정보를 그대로 id값이 person_email인 곳에도 입력시킴
	$("#input_email").keydown(function(){
	    $('#person_email').val($(this).val());
	});
	$("#input_email").change(function(){
	    $('#person_email').val($(this).val());
	});
</script>

<script>
	const email_checkDiv = document.getElementById('email_checkDiv')
	const authMailDiv = document.getElementById('authMailDiv')
	
	const sendMailHandler = function(event){
		event.preventDefault()
		const input_email = document.getElementById('input_email').value
		console.log(input_email)
		const url = '${cpath}/mailto/' + input_email + '/'
		const opt = {
				method: 'GET'
		}
		fetch(url, opt).then(resp => resp.text())
		.then(text => {
			console.log(text)
			if(text.length == 128){
				email_checkDiv.innerText = '이메일 전송에 성공'
				email_checkDiv.style.color = 'blue'
				authMailDiv.classList.remove('hiddenNone')
			}
			else{
				
				email_checkDiv.innerText = '이메일 전송에 실패'
				email_checkDiv.style.color = 'red'
			}
				email_checkDiv.style.fontWeight = 'bold'
		})
	}
	document.getElementById('receiveAuthBtn').onclick = sendMailHandler
</script>

<script>
const injungSuccessDiv = document.getElementById('injungSuccessDiv')
// const pass
const injungHandler = function(event){
	event.preventDefault()
	const authNumber = document.getElementById('authNumber').value
	console.log(authNumber)
	const url = '${cpath}/getAuthResult/' + authNumber
	const opt = {
			method: 'GET'
	}
	
	fetch(url, opt).then(resp => resp.text())
	.then(text => {
		if(text == 'true'){
			injungSuccessDiv.innerText = '인증 성공'
			injungSuccessDiv.style.color = 'blue'
			injungform.classList.remove('hiddenNone')
		}
		else{
			injungSuccessDiv.innerText = '인증 실패'
			injungSuccessDiv.style.color = 'red'
		}
			injungSuccessDiv.style.fontWeight = 'bold'
	})
}

document.getElementById('injung').onclick = injungHandler

</script>

<%@ include file="../layout/footer.jsp" %>