<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>



<!-- created by 재훈 
	 실시간 ajax 구현은 다음에 합니다.-->
<div>
<h2>회원가입 폼</h2>
<form id = "joinForm">

	<p>
		<label><input class = "indi" type = "radio" name = "person_check" value = "n">개인회원</label>
		<label><input class = "company" type = "radio" name = "person_check" value = "y">법인회원</label>
	</p>
	
	<div class = "company main hiddenNone">
		<label><input type = "radio" name = "radios" class = "radio1" >개인사업자</label>
		<label><input type = "radio" name = "radios" class = "radio2">법인사업자</label>
		<label><input type = "radio" name = "radios" class = "radio3">법인소속직원(기사)</label>
		<div class = "radio2 hiddenNone">
			<h2>법인사업자 폼</h2>
			<input type = "text" name = "belong" placeholder="회사명 입력">
		</div>
		
		<div class = "radio3 hiddenNone">
			<h2>법인소속직원(기사) 폼</h2>
			<input type = "text" name = "belong" placeholder="회사명 입력">
		</div>
	</div>
	<!--sdf d -->
	<p>사용자 ID는 6~20자 사이의 영문+숫자로 이루어져야 하며 영문으로 시작되어야 합니다.</p>
	<p>
		<input type = "text" name = "id" placeholder="ID입력" 
		required class = "id" oninput = "checkId()" id = "checkaa">
	</p>
	<!-- 정규표현식도 나중에 구현하겠습니다. -->
	<div id = "idCheckMsg"></div>입력한 결과에 따라 부적합 여부를 실시간으로 띄워주는 div
	<p>
		<input type = "password" name = "pw" placeholder="PW 입력" required>
	</p>
	<p>비밀번호는 영문, 숫자 포함한 6~20자로 되어야 합니다.</p>
	<p><input type = "password" name = "pw2" placeholder="PW 다시 입력" required></p>
	<p><input type = "text" name = "name" placeholder="이름 입력" required></p>
	<p><input type = "text" name = "email" placeholder="foo@bar.com" required></p>
	<p><input type = "text" name = "address" placeholder="주소 입력" required></p>
	<p><input type = "text" name = "birth" placeholder="생년월일 입력 ex)980819" required></p>
	<p><input type = "text" name = "phone" placeholder="핸드폰번호 입력" required><button>인증번호 받기</button></p>
	<p><input type = "text" name = "call" placeholder="유선전화번호 입력"></p>
	<p><input type = "text" name = "fax" placeholder="팩스 전화 입력" required></p>
	
	<button type = "submit" class = "signUpBtn" disabled="disabled">회원가입</button>
</form>
</div>

<script>
	document.querySelectorAll('p > label > input').forEach(input => input.onclick = function(event){
		const className = event.target.className
		console.log(className)
		if(className == 'company'){
			document.querySelector('div.' + className).classList.remove('hiddenNone')
		}
		if(className == 'indi'){
			document.querySelector('div.' + 'company').classList.add('hiddenNone')
		}
	})
	
	document.querySelectorAll('div > label > input').forEach(input => input.onclick = function(event){
		const className = event.target.className
		
		if(className == 'radio1'){
			document.querySelector('div.' + 'radio2').classList.add('hiddenNone')
			document.querySelector('div.' + 'radio3').classList.add('hiddenNone')
		}
		if(className == 'radio2'){
			document.querySelector('div.' + 'radio2').classList.remove('hiddenNone')
			document.querySelector('div.' + 'radio3').classList.add('hiddenNone')
		}
		if(className == 'radio3'){
			document.querySelector('div.' + 'radio3').classList.remove('hiddenNone')
			document.querySelector('div.' + 'radio2').classList.add('hiddenNone')
		}
	})
	
</script>

<script>
//실시간 Ajax를 구현할 것이라서, 여기는 비워뒀습니다. 나중에 시간 나면 채울 예정입니다!
// var idCheck = 0
// var pwdCheck = 0;
// function checkId(){
// 	var inputed = $('.id').val()
// 	$.ajax({
// 		data : {
// 			id : inputed
// 		},
// 		url : '${cpath}/common/idCheck',
// 		success : function(data){
// 			if(inputed == '' && data == '0'){
// 				$('.signUpBtn').prop('disabled', true)
// 				$('.signUpBtn').css('background-color', '#aaaaaa')
// 				$('#checkaa').css('background-color', '#FFCECE')
// 				idCheck = 0
// 			} else if (data == '0'){
// 				$('#checkaa').css('background-color', '#B0F6AC')
// 				idCheck = 1
// 				if(idCheck == 1){
// 					$('.signUpBtn').prop('disabled', false)
// 					$('.signUpBtn').css('background-color', '#4CAF50')
					
// 				}
// 			} else if(data == '1'){
// 				$('.signUpBtn').prop('disabled', true)
// 				$('.signUpBtn').css('background-color', '#aaaaaa')
// 				$('#checkaa').css('background-color', '#FFCECE')
// 				idCheck = 0
// 			}
// 		}
// 	})
// 	console.log(idCheck)
// }











</script>
<%@ include file="../layout/footer.jsp"%>