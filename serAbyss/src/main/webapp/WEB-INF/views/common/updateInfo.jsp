<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<!-- style hiddenNone있던거 삭제하고 css로 옮겼습니다. 정재훈6월10일 9:42 -->
<h2>개인정보 수정하는 곳입니다.</h2>
<div>
	<!-- 수정 버튼 누르면 취소 버튼으로 탈바꿈한다. 그때 또 취소 버튼을 누르면 div가 hiddenNone된다. -->
	
		<p>이메일: ${login.person_email }<a class = "email">수정</a>
		</p>
		<div class = "email main hiddenNone">
			<h2>이메일 변경을 위해서 인증이 필요합니다</h2>
			<input type = "email" name = "newEmail" id = "newEmail" placeholder="새로운 이메일을 입력 후 인증이 필요합니다">
			<button id = "receiveAuthBtn">인증번호 받기</button>
			
			<div class = "check_font" id = "email_checkDiv"></div>
			
			<div class = "hiddenNone" id = "authMailDiv">
				<h2>인증번호 입력</h2>
				<div>
					<input type = "text" id = "authNumber" name = "authNumber" placeholder="인증번호를 입력하시오">
					<button id = "injung">인증하기</button>
				</div>
				<div id = "injungSuccessDiv"></div>
			</div>
		</div>
		
		<p>폰번호: <input type = "text" name = "person_phone" value = "${login.person_phone }"><a class = "phone">수정</a></p>
		<div class = "phone main hiddenNone">
			<h2>폰번호 변경을 위해서 인증이 필요합니다</h2>
			<p>
				<input type = "email" name = "newPhone" placeholder="새로운 폰번호를 입력 후 인증이 필요합니다">
				<button>인증번호 받기</button>
			</p>
		</div>
		
		<c:if test="${login.person_call != null }">
			<p>유선전화번호: <input type = "text" name = "person_call" value = "${login.person_call }"><a class = "call">수정</a></p>
			<div class = "call main hiddenNone">
				<p><input type = "text" name = "newCall" placeholder="새로운 유선전화 입력"></p>
				<input type = "submit" value = "다음">
			</div>
		</c:if>
		
		<c:if test="${login.person_fax != null }">
			<p>팩스: <input type = "text" name = "person_fax" value = "${login.person_fax }"><a class = "fax">수정</a></p>
			<div class = "fax main hiddenNone">
				<p><input type = "text" name = "newPax" placeholder="새로운 팩스 입력"></p>
				<input type = "submit" value = "다음">
			</div>
		</c:if>
		
		<p>주소: <input type = "text" name = "person_address" value = "${login.person_address }"><a class = "address" >수정</a></p>
		<div class = "address main hiddenNone">
			<label>주소</label><br>
			<input type="text" id="postcode" placeholder="우편번호">
			<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="address" name = "address" placeholder="주소"><br>
			<input type="text" id="detailAddress" name = "detailAddress" placeholder="상세주소">
			<input type="text" id="extraAddress" placeholder="참고항목">
		</div>
		
		<button onclick = "history.go(-1);">뒤로 가기</button>
		
	
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>

<script>
	const email_checkDiv = document.getElementById('email_checkDiv')
	const authMailDiv = document.getElementById('authMailDiv')
	
	const sendMailHandler = function(event){
		event.preventDefault()
		const newEmail = document.getElementById('newEmail').value
		console.log(newEmail)
		const url = '${cpath}/mailto/' + newEmail + '/'
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

<script>
	document.querySelectorAll('div > p > a').forEach(a => a.onclick = function(event){
		const className = event.target.className
		var status = document.querySelector('a.' + className).innerText
		if(status == '수정'){
			document.querySelector('a.' + className).innerText = '취소'
			document.querySelector('div.' + className).classList.remove('hiddenNone')
		}
		if(status == '취소'){
			document.querySelector('a.' + className).innerText = '수정'
			document.querySelector('div.' + className).classList.add('hiddenNone')
		}
		
	})
	
	
</script>


<%@ include file="../layout/footer.jsp" %>