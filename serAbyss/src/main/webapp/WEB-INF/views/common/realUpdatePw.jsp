<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<div>
	<form id = "repwCheck" method = "post" action = "pwUpdateResult">
		<p><input type = "hidden" name = "person_id" value = "${login.person_id }"></p>
		<p>새 비밀번호 입력: <input type = "password" id = "person_pw" name = "person_pw"></p>
		<div class = "check_font" id = "pw_check"></div>
		<p>새 비밀번호 확인: <input type = "password" id = "person_pw2" name = "person_pw2"></p>
		<div class = "check_font" id = "pw2_check"></div>
		<input type = "submit" value = "다음">
	</form>
</div>
<script>
	document.getElementById('repwCheck').onsubmit = function(event){
		event.preventDefault()
		const person_pw = event.target.querySelector('input[name="person_pw"]').value
		const person_pw2 = event.target.querySelector('input[name="person_pw2"]').value
		if(person_pw != person_pw2){
			alert('비밀번호가 일치하지 않습니다.')
		}
		else{
			event.target.submit()
		}
	}
</script>

<script>
	//비밀번호 체크
	$('#person_pw').blur(function(){
		const pwJ = /^[a-z0-9]{6,20}$/
		const person_pw = $('#person_pw').val()
		const person_pw2 = $('#person_pw2').val()
			if(pwJ.test(person_pw)){
				$('#pw_check').text('사용 가능한 비밀번호입니다')
				$('#pw_check').css('color', 'blue')
	// 			$('#reg_submit').attr('disabled', false)
			} else if(person_pw == ''){
				$('#pw_check').text('비밀번호를 입력해주세요')
				$('#pw_check').css('color', 'red')
	// 			$('#reg_submit').css('disabled', true)
			} else {
				$('#pw_check').text('비밀번호는 소문자와 숫자 6~20자리만 가능합니다')
				$('#pw_check').css('color', 'red')
	// 			$('#reg_submit').attr('disabled', true)
				
			}
	})
	//비밀번호 확인 체크
	$('#person_pw2').blur(function(){
		const person_pw = $('#person_pw').val()
		const person_pw2 = $('#person_pw2').val()
		if(person_pw2 != person_pw){
				$('#pw2_check').text('비밀번호가 일치하지 않습니다')
				$('#pw2_check').css('color', 'red')
		}else{
				$('#pw2_check').text('비밀번호가 일치합니다')
				$('#pw2_check').css('color', 'blue')
		}
	})
</script>
<%@ include file="../layout/footer.jsp" %>