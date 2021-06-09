<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<!-- created by 재훈 
	 실시간 ajax 구현은 다음에 합니다.-->
<div>
<h2>회원가입 폼</h2>
<form id = "joinForm">
	<p>
		<label><input type = "radio" name = "choose" >개인회원</label>
		<label><input type = "radio" name = "choose">기업회원</label>
	</p>
	<div class = "company main hidden"><!-- 츄 사이트처럼 기업회원 라디오를 눌렀을 때, hidden이 딱 없어지면서 이 div가 떴으면 좋겠어요-->
		<label><input type = "radio" name = "choose" >개인사업자</label>
		<label><input type = "radio" name = "choose">법인사업자</label>
		<label><input type = "radio" name = "choose">법인소속사업자</label>
	</div>
	<p>
		<input type = "text" name = "id" placeholder="ID입력" required class = "id">
	</p>
	<p>사용자 ID는 6~20자 사이의 영문+숫자로 이루어져야 하며 영문으로 시작되어야 합니다.</p>
	<!-- 정규표현식도 나중에 구현하겠습니다. -->
	<div id = "idCheckMsg"></div><!-- 입력한 결과에 따라 부적합 여부를 실시간으로 띄워주는 div -->
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
	<input type = "submit" value = "가입 신청">
</form>
</div>
<script>
//실시간 Ajax를 구현할 것이라서, 여기는 비워뒀습니다. 나중에 시간 나면 채울 예정입니다!

</script>
<%@ include file="../layout/footer.jsp"%>