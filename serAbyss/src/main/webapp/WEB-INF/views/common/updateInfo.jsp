<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<style>
	.hidden{
		display: none;
	}
</style>


<h2>개인정보 수정하는 곳입니다.</h2>
<div>
	<!-- 수정 버튼 누르면 취소 버튼으로 탈바꿈한다. 그때 또 취소 버튼을 누르면 div가 hidden된다. -->
	
		<p>
			이메일: <input type = "email" name = "email">
			<a class = "email">수정</a>
		</p>
		<div class = "email main hidden">
			<h2>이메일 변경을 위해서 인증이 필요합니다</h2>
			<p>
				<input type = "email" name = "newEmail" placeholder="새로운 이메일을 입력 후 인증이 필요합니다">
				<button>인증번호 받기</button>
			</p>
		</div>
		
		<p>폰번호: <input type = "text" name = "person_phone"><a class = "phone">수정</a></p>
		<div class = "phone main hidden">
			<h2>폰번호 변경을 위해서 인증이 필요합니다</h2>
			<p>
				<input type = "email" name = "newPhone" placeholder="새로운 폰번호를 입력 후 인증이 필요합니다">
				<button>인증번호 받기</button>
			</p>
		</div>
		
		<p>유선전화번호: <input type = "text" name = "person_call"><a class = "call">수정</a></p>
		<div class = "call main hidden">
			<p><input type = "text" name = "newCall" placeholder="새로운 유선전화 입력"></p>
			<input type = "submit" value = "다음">
		</div>
		
		<p>팩스: <input type = "text" name = "person_fax"><a class = "fax">수정</a></p>
		<div class = "fax main hidden">
			<p><input type = "text" name = "newPax" placeholder="새로운 팩스 입력"></p>
			<input type = "submit" value = "다음">
		</div>
		
		<p>주소: <a class = "address">수정</a></p>
		<div class = "address main hidden">
			<h2>주소 수정 API</h2>
		</div>
		
		<button onclick = "history.go(-1);">뒤로 가기</button>
		
	
</div>


<script>
	document.querySelectorAll('div > p > a').forEach(a => a.onclick = function(event){
		const className = event.target.className
		var status = document.querySelector('a.' + className).innerText
		if(status == '수정'){
			document.querySelector('a.' + className).innerText = '취소'
			document.querySelector('div.' + className).classList.remove('hidden')
		}
		if(status == '취소'){
			document.querySelector('a.' + className).innerText = '수정'
			document.querySelector('div.' + className).classList.add('hidden')
		}
		
	})
	
	
</script>


<%@ include file="../layout/footer.jsp" %>