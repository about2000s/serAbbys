<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<style>
	* {margin:0;padding:0;}
	html {height:100%;}
	body {height:100%; font-family: 'Noto Sans KR';}
	img {border:0; }
	h1 { float:left; padding:0 0 0 0px;}
	h2 {padding:0 0 0 0px;}
	ul, li { list-style:none;}
	ul{list-style:none; }
	.form-control{
		width:15vw;
	}
	.container{width:100%;}
	.wrap{max-width:960px; margin: 0 auto;}
	.wrap.wd668{max-width:768px;}
	.join_form{max-width:90vw;}
	.wrap.wd668{width:90vw;}
	.btn.btn-primary.btn-xl {
		width: 11vw;
		height: 30px;
		position: relative;
        left: 170px;
        font-size:15px;
	}
	span {
		margin: 10px;
		text-indent: 0;
		font-size:15px;
	}
	th {
		width: 20%;
	}
	.hiddenNone {
		display: none;
	}
</style>

<link rel = "stylesheet" href = "https://www.w3schools.com/w3css/4/w3.css">
<div>
<form id = "joinForm" method = "post">
	<div class="join_form">
		<div class="wrap wd668">
    		<div class="container">
        		<div class="form_txtInput">
        			<table>
						<tr>
							<td>
								<label><input class = "indi" type = "radio" name = "person_check" value = "n" checked>개인회원</label>
							</td>
							<td>
								<label><input class = "company" type = "radio" name = "person_check" value = "y">법인회원</label>
							</td>
						</tr>
							
						<tr class = "company main hiddenNone">
							<td><label><input type = "radio" name = "any" class = "radio1" >개인사업자</label></td>
							<td><label><input type = "radio" name = "any" value = "comp" class = "radio2">법인사업자</label></td>
							<td><label><input type = "radio" name = "any" value = "empl" class = "radio3">법인소속직원(기사)</label></td>
						</tr>
							
						<tr class = "radio2 hiddenNone">
							<td>
								<h2>법인사업자 폼</h2>회사명 입력하는 폼
							</td>
							<td>
								<input class = "form-control" type = "text" name = "person_belong" placeholder="회사명 입력">
							</td>
						</tr>
							
						<tr class = "radio12 hiddenNone">
							<td>
								<h2>사업자등록번호 입력</h2>
							</td>
							<td>
								<input class = "form-control" type = "text" name = "person_busiNum">
							</td>
						</tr>
							
						<tr class = "radio3 hiddenNone">
							<td>
								<h2>법인소속직원(기사) 폼</h2>compList에서 검색하는 폼
							</td>
							<td>
								<input class = "form-control" type = "text" id = "person_belong" name = "person_belong" readonly>
								<button onclick = "document.getElementById('id01').style.display='block'"
								class = "btn btn-primary btn-xl">회사 검색</button>
							</td>
						</tr>
								
						<tr id = "id01" class = "w3-modal">
							<td class = "w3-modal-content w3-card-4">
								<header class = "w3-container w3-teal">
									<span onclick = "document.getElementById('id01').style.display='none'"
									class = "w3-button w3-display-topright">&times;</span>
									<h2>Modal Header</h2>
								</header>
							</td>
							<td class = "w3-container">
								회사 검색 폼<br>
								<input class = "form-control" type = "text" id = "keyword" name = "keyword">
								<button id = "compSearchBtn" class = "btn btn-primary btn-xl">검색</button><br>
							</td>
						</tr>

						
						<tr>
							<th>아이디</th>
							<td><input class = "form-control" type = "text" id = "person_id" name = "person_id" required></td>
							<td class = "check_font" id = "id_check"></td>
						</tr>
						
						<tr>
							<th>비밀번호</th>
							<td><input class = "form-control" type = "password" id = "person_pw" name = "person_pw" required></td>
							<td class = "check_font" id = "pw_check"></td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td><input class = "form-control" type = "password" id = "person_pw2" name = "person_pw2" required></td>
							<td class = "check_font" id = "pw2_check"></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input class = "form-control" type = "text" id = "person_name" name = "person_name" required></td>
							<td class = "check_font" id = "name_check"></td>
						</tr>
						<tr>
							<th>생년월일 ex)980819</th>
							<td><input class = "form-control" type = "text" id = "person_birth" name = "person_birth" required></td>
							<td class = "check_font" id = "birth_check"></td>
						</tr>
						<tr>	
							<th>일반전화</th>
							<td><input class = "form-control" type = "text" name = "person_call"></td>
							<td class = "check_font" id = "call_check"></div>
						</tr>
						<tr>
							<th>팩스</th>
							<td><input class = "form-control" type = "text" name = "person_fax"></td>
							<td class = "check_font" id = "fax_check"></td>
						</tr>
						<tr>
							<th>핸드폰번호</th>
							<td>
								<input class = "form-control" type = "text" name = "person_phone" placeholder="핸드폰번호 입력" required>
							</td>
							<td><button class = "btn btn-primary btn-xl">인증번호 받기</button></td>
						</tr>
						<tr>
							<th>주소</th>
							<td><input class = "form-control" type="text" id="postcode" placeholder="우편번호"></td>
							<td><input class = "form-control" type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class = "btn btn-primary btn-xl"></td>
						</tr>
						<tr>
							<th></th>
							<td><input class = "form-control" type="text" id="address" name = "address" placeholder="주소"></td>
							<td><input class = "form-control" type="text" id="detailAddress" name = "detailAddress" placeholder="상세주소"></td>
							<td><input class = "form-control" type="text" id="extraAddress" placeholder="참고항목"></td>
						</tr>
						<tr>
							<th>이메일 입력</th>
							<td><input class = "form-control" type = "text" id = "person_email" name = "person_email" required></td>
							<td><button class = "btn btn-primary btn-xl" id = "receiveAuthBtn">인증번호 받기</button></td>
							<td class = "check_font" id = "email_checkDiv"></td>
						</tr>
							
						<tr class = "hiddenNone" id = "authMailDiv">
							<th>인증번호 입력</th>
								<td>
									<input class = "form-control" type = "text" id = "authNumber" name = "authNumber" placeholder="인증번호를 입력하시오">
									<button class = "btn btn-primary btn-xl" id = "injung">인증하기</button>
								</td>
								<td><input type="text" id = "injungSuccessDiv" class = "injung hiddenNone"></td>
						</tr>
					</table>
					<button class = "btn btn-primary btn-xl" type = "submit" id = "reg_submit">회원가입</button>
				</div>
			</div>
		</div>
	</div>
</form>
    
</div>

<script>
const email_checkDiv = document.getElementById('email_checkDiv')
const authMailDiv = document.getElementById('authMailDiv')

const sendMailHandler = function(event){
	event.preventDefault()
	const person_email = document.getElementById('person_email').value
	console.log(person_email)
	const url = '${cpath}/mailto/' + person_email + '/'
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
// const pass = 
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
document.getElementById('compSearchBtn').onclick = function(event){
	const keyword = document.getElementById('keyword').value
	const url = '${cpath}/compSearch/' + keyword
	const opt = {
			method: 'GET'
	}
	fetch(url, opt).then(resp => resp.json())
	.then(json => {
			if(document.querySelector('table.' + 'compListTable') != null){
				document.querySelector('table.' + 'compListTable').remove()
			}
			if(document.querySelector('div.' + 'noCompComment') != null){
				document.querySelector('div.' + 'noCompComment').remove()
			}
		if(json != ''){
			
			const table = document.createElement('table')
			table.classList.add('compListTable')
			const headTr = document.createElement('tr')
			const nameTh = document.createElement('th')
			const addressTh = document.createElement('th')
			nameTh.innerText = '회사 이름'
			addressTh.innerText = '회사 주소'
			headTr.appendChild(nameTh)
			headTr.appendChild(addressTh)
			table.appendChild(headTr)
			for(let i=0;i<json.length;i++){
				var contentTr = document.createElement('tr')
				var nameTd = document.createElement('td')
				var addressTd = document.createElement('td')
				
				var companyList_name = json[i].COMPANYLIST_NAME
				var nameLink = document.createElement('a')
				nameLink.innerText = companyList_name
				nameLink.href = "javascript:inputBelong('" + companyList_name + "')"
				nameTd.appendChild(nameLink)
				
				var companyList_address = json[i].COMPANYLIST_ADDRESS
				var addressLink = document.createElement('a')
				addressLink.innerText = companyList_address
				addressLink.href = "javascript:inputBelong('" + companyList_name + "')"
				addressTd.appendChild(addressLink)
				
				contentTr.appendChild(nameTd)
				contentTr.appendChild(addressTd)
				
				table.appendChild(contentTr)
			}
			document.querySelector('div.' + 'w3-container').appendChild(table)
		}
		else{
			const div = document.createElement('div')
			div.classList.add('noCompComment')
			div.innerText = '검색결과가 없습니다'
			document.querySelector('div.' + 'w3-container').appendChild(div)
		}
		
	})
};
</script>

<script>
function inputBelong(companyList_name){
	console.log(companyList_name)
	document.getElementById('person_belong').value = companyList_name
	document.getElementById('id01').style.display='none'
}
</script>

<script>

//아이디 중복체크
$('#person_id').blur(function(){
	const idJ = /^[a-z0-9]{4,12}$/
	const person_id = $('#person_id').val()
	$.ajax({
		url: '${cpath}/common/idCheck?person_id=' + person_id,
		type: 'get',
		success: function(data){
			if(idJ.test(person_id)){
				if(data == 1){
					$('#id_check').text('이미 사용중인 아이디입니다')
					$('#id_check').css('color', 'red')
				}
				else{
					$('#id_check').text('사용 가능한 아이디입니다')
					$('#id_check').css('color', 'blue')
				}
			}else if(!idJ.test(person_id)){
				$('#id_check').text('아이디는 소문자와 숫자 4~12자리만 가능합니다')
				$('#id_check').css('color', 'red')
			}
		}, error: function(){
			console.log('실패')
		}
	})
})

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

//이름 체크
$('#person_name').blur(function(){
	const person_name = $('#person_name').val()
	if(person_name == ''){
			$('#name_check').text('이름을 입력하세요')
			$('#name_check').css('color', 'red')
	}else{
			$('#name_check').text('')
		
	}
})

//이메일 체크
// $('#person_email').blur(function(){
// 	const emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
// 	const person_email = $('#person_email').val()
// 	$.ajax({
// 		url: '${cpath}/common/emailCheck?person_email=' + person_email,
// 		type: 'get',
// 		success: function(data){
// 			if(emailJ.test(person_email)){
// 				if(data == 1){
// 					$('#email_check').text('이미 사용중인 이메일입니다')
// 					$('#email_check').css('color', 'red')
// 				}
// 				else{
// 					$('#email_check').text('사용 가능한 이메일입니다')
// 					$('#email_check').css('color', 'blue')
// 				}
// 			}else if(!emailJ.test(person_email)){
// 				$('#email_check').text('이메일 형식에 적합하지 않습니다')
// 				$('#email_check').css('color', 'red')
// 			}
// 		}, error: function(){
// 			console.log('실패')
// 		}
// 	})
// })

//생년월일 체크
//보류
</script>

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
	document.querySelectorAll('tr > td > label > input').forEach(input => input.onclick = function(event){
		const className = event.target.className
		console.log(className)
		if(className == 'company'){
			document.querySelector('tr.' + className).classList.remove('hiddenNone')
		}
		if(className == 'indi'){
			document.querySelector('tr.' + 'company').classList.add('hiddenNone')
		}
	})
	
	document.querySelectorAll('tr > td > label > input').forEach(input => input.onclick = function(event){
		const className = event.target.className
		
		if(className == 'radio1'){
			document.querySelector('tr.' + 'radio12').classList.remove('hiddenNone')
			document.querySelector('tr.' + 'radio2').classList.add('hiddenNone')
			document.querySelector('tr.' + 'radio3').classList.add('hiddenNone')
		}
		if(className == 'radio2'){
			document.querySelector('tr.' + 'radio12').classList.remove('hiddenNone')
			document.querySelector('tr.' + 'radio2').classList.remove('hiddenNone')
			document.querySelector('tr.' + 'radio3').classList.add('hiddenNone')
		}
		if(className == 'radio3'){
			document.querySelector('tr.' + 'radio12').classList.add('hiddenNone')
			document.querySelector('tr.' + 'radio3').classList.remove('hiddenNone')
			document.querySelector('tr.' + 'radio2').classList.add('hiddenNone')
		}
	})
	
</script>

<%@ include file="../layout/footer.jsp"%>