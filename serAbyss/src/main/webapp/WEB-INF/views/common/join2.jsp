<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<style>
* {margin:0;padding:0;}
html {height:100%;}
body {height:100%; font-family: 'Noto Sans KR';}
table, tr, td, th, div, p, em, ol, ul, li, dl, dt, dd, a, address, img, h1, h2, h3, h4, h5, h6 {font-size:11pt; color:#666;text-decoration: none;}
img {border:0; }
h1 { float:left; padding:0 0 0 0px;}
h2 {padding:0 0 0 0px;}
ul, li { list-style:none;}
ul{list-style:none; }
.red_txt{color:#ee7272;}
.blind {display:block;overflow:hidden;position:absolute;left:0;top:-5000px}
.wrap{max-width:960px; margin: 0 auto;}
.wrap.wd668{max-width:628px;}
.wrap.wd668.line{border:1px solid #ececec;padding:30px 20px;}
.container{width:100%;}
.sub_tit_txt{margin:80px 0 20px 20px; color: #2f2f2f; font-size: 25px;}
.wrap.wd668.line .sub_tit_txt{margin:0px 0 20px 20px; }
.con_term .term_txt{border:1px solid #ececec;padding:30px; height:210px; overflow-y: auto; margin:0 0 15px;}
.con_term .term_txt ul li,.con_term .term_txt p ,.con_term .term_txt div{color:#818181;font-size:12px; line-height:17px;margin: 0 0 15px;}
.left_margin{margin:0 0 0 20px;}
.con_term .term_txt div.txt_bold{font-weight: bold; margin:0 0 25px;}
.btn_wrap{text-align:center; margin:40px 0 30px;}
.btn_wrap a{color: #fff; background-color: #4380ce; font-weight: bold; padding: 10px;  height: 30px; line-height: 30px; width: 168px; display: block; text-align: center; margin: 0 auto;}
.btn_wrap a.wide{width:587px;margin: 0 0 0 20px;}
.find_txt ul li{color:#9a9a9a;font-size:13px;text-align:center; line-height:17px; margin:0 0 20px;}
.form_txtInput .checkbox_wrap {position: relative;padding: 5px;text-align: right;}
.form_txtInput .checkbox_wrap input[type="checkbox"] {position: absolute;width: 1px;height: 1px;padding: 0;margin: -1px;overflow: hidden;clip: rect(0,0,0,0);border: 0;}
.form_txtInput .checkbox_wrap input[type="checkbox"] + label {display: inline-block; line-height:14px;position: relative;padding-left: 20px;font-size: 13px;color: #818181;cursor: pointer;-webkit-user-select: none;-moz-user-select: none;-ms-user-select: none;}
.form_txtInput .checkbox_wrap input[type="checkbox"] + label:before {content: '';position: absolute;top: 0px;left: 0;width: 12px;height: 12px;text-align: center;background: #fff;border: 1px solid #c2c2c2;}
.form_txtInput .checkbox_wrap input[type="checkbox"] + label:active:before, .checkbox_wrap input[type="checkbox"]:checked + label:active:before {box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);}
.form_txtInput .checkbox_wrap input[type="checkbox"]:checked + label:before {background: #fff;border-color: #ddd;}
.form_txtInput .checkbox_wrap input[type="checkbox"]:checked + label:after {content: '✓';color: #0094ff;position: absolute;top:0px;left:2px;width: 7px;height: 7px;font-size: 13px;font-weight: bold;}
.exTxt{font-size:14px;color:#9a9a9a;display: block;margin:0 0 45px 20px;}
.join_form{width:100%;max-width:668px;}
.join_form table {border-spacing: 0;margin:0;padding:0; border:0;width:100%;}
.join_form table input{ border:1px solid #ececec;font-size:14px;color:#4c4c4c; height:35px; padding:10px; width:100%; float:left;}
.join_form table input.email{width:162px; display: inline-block;}
.join_form table input.email2{width:192px;}
.join_form.idpwFind table input{width:519px;}
.join_form.idpwFind table input.email{width:223px;}
.join_form.idpwFind table input.email2{width:263px}
.join_form.idpwFind table input.phone{width:182px;margin: 0 12px 0 11px;}
.join_form.idpwFind table input.phone2{width:182px;}
.join_form table input.send_number{width:383px;}
.join_form table th span{color:#404040;font-size:14px; display:inline-block; position:relative;padding:0 10px 0 0; text-indent:20px;}
.join_form table th{text-align:left;}
.join_form table td{padding:6px 0;position: relative;}
.join_form table th span:after{content:'*';font-size:13px;color:#f95427;position:absolute;top:0;right:0px;}
.join_form.idpwFind table th span:after{content:none;}
.join_form table td a.btn_confirm{display: inline-block; float:left;width:115px; height:48px;margin:5px 0 0 0px;border:1px solid #cfcfcf;background:#dedede;color:#626262;text-align:center; vertical-align: top;line-height: 50px;}
.join_form.idpwFind table td select { -webkit-appearance: none; -moz-appearance: none;  appearance: none; background: url(https://secsales.interparkb2b.co.kr/data/G94/main/sele_arr.gif) no-repeat 95% 50%;text-indent:20px; width:124px; height:50px;border:1px solid #ececec; font-size:14px; color:#ccc; float:left;}
.join_form.idpwFind table td select::-ms-expand { display: none;}
.join_form.idpwFind table td  tr.phone td select {text-align: center; text-indent: 10px;}
.join_form.idpwFind table tr.email input:after,.mar10:after,  .join_form.idpwFind table td select:after,.join_form table td a.btn_confirm:after{content:'';display: block;clear:both;}
.agree_wrap{margin:36px 0 0;}
.agree_wrap .checkbox_wrap{text-align:left;}
::placeholder {color: #c4c4c4;opacity: 1;}
:-ms-input-placeholder {color: #c4c4c4!important;}
::-ms-input-placeholder {color: #c4c4c4!important;}
.mar27{margin:27px 0 0;}
.mar10{margin:14px 5px 0 10px; display: inline-block;padding:0; float:left;}
.exform_txt{padding:12px 0 19px 0; text-align:right;color:#9a9a9a;font-size:13px;border-bottom:1px solid #ececec;}
.exform_txt span{display: inline-block;position:relative;  padding-left:10px}
.exform_txt span:after{content:'*';position:absolute;left:0;top:0; color:#f95427; font-size: 13px; font-weight: bold;}
.explan_txt {margin:3px 0 0 22px;}
.explan_txt li{color:#b2b2b2;font-size:13px; line-height:17px;}
.popWrap{border:1px solid #ececec;padding:30px; max-width:400px;width:100%;margin:30px auto 0;display: none;position: absolute;top:0;left:50%;transform: translateX(-50%);background: #fff;z-index:5;}
.popWrap.is-open{display: block;}
.popWrap .pop_txt_con .pop_exTxt{font-size:14px;color:#9a9a9a;line-height:20px;}
.popWrap .pop_txt_con .pop_exTxt span{color:#254ee9}
.popWrap .pop_btnWrap{margin:30px 0 0;}
.popWrap .pop_btnWrap a{color: #fff; background-color: #4380ce; font-weight: bold; padding: 10px;  height: 22px; line-height: 22px; width: 103px; display: block; text-align: center;}
.join_form table input.send_number::placeholder{text-align:right;}
.join_form table input.send_number:-ms-input-placeholder {text-align:right;}
.join_form table input.send_number::-ms-input-placeholder {text-align:right;}
.overlayer {  position: fixed;display: none;width: 100%;  height: 100%;  top: 0;  left: 0;  right: 0;  bottom: 0;  background-color: rgba(0,0,0,0.5);  z-index: 2;  cursor: pointer;}
.overlayer.is-open{  display: block;}
@media ( max-width: 1023px ) {
  .wrap{margin: 30px auto;}
  .wrap,.wrap.wd668.line{max-width:80vw;}
  .wrap.wd668{width:90vw;}
  .join_form{max-width:90vw;}
  .join_form table th span{text-indent: 0;font-size:13px;}
  .join_form table{width:100%;}
  .join_form table input{ border:1px solid #ececec;font-size:14px;color:#4c4c4c; height:37px; padding:10px; width:100%;}
  .join_form table input.email{width:30%; display: inline-block;}
  .join_form table input.email2{width:60%;}
  .join_form.idpwFind table input{width:100%;}
  .join_form.idpwFind table tr.email input{float:left;}
  .mar10{margin:5px 2% 0 2%; float:left;}
  .join_form.idpwFind table input.email{width:36%;}
  .join_form.idpwFind table input.email2{width:53%}
  .join_form.idpwFind table input.phone{width:30%;margin:0 4% 0 4%;}
  .join_form.idpwFind table input.phone2{width:31%;}
  .join_form table input.send_number{width: 53%; }
  .exTxt{margin:0 0 25px 0px}
  .wrap.wd668.line .sub_tit_txt,.wrap .sub_tit_txt{margin:0 0 10px 0;}
  .btn_wrap a,.btn_wrap a.wide{width:auto;margin:0;}
  .btn_wrap{overflow: hidden;}
  .join_form.idpwFind table td select{width:30%;height:37px; float:left;}
  .join_form.idpwFind table tr.email input:after,.mar10:after,  .join_form.idpwFind table td select:after{content:'';display: block;clear:both;}
  .popWrap{right: auto; max-width: 80vw; margin: 30px auto 0; left: 50%; transform: translateX(-50%);}
  .join_form table td a.btn_confirm{width: 100px; height: 35px;line-height: 35px; font-size: 12px;margin:5px 0 0 ;}
  .join_form table input.send_number + a{margin:0 0 0 5px;}
}
</style>

<link rel = "stylesheet" href = "https://www.w3schools.com/w3css/4/w3.css">
<div>
<h2>회원가입 폼</h2>
<form id = "joinForm" method = "post">

	<p>
		<label><input class = "indi" type = "radio" name = "person_check" value = "n" checked>개인회원</label>
		<label><input class = "company" type = "radio" name = "person_check" value = "y">법인회원</label>
	</p>
	
	<div class = "company main hiddenNone">
		<label><input type = "radio" name = "any" class = "radio1" >개인사업자</label>
		<label><input type = "radio" name = "any" value = "comp" class = "radio2">법인사업자</label>
		<label><input type = "radio" name = "any" value = "empl" class = "radio3">법인소속직원(기사)</label>
		
		<div class = "radio2 hiddenNone">
			<h2>법인사업자 폼</h2>회사명 입력하는 폼
			<input type = "text" name = "person_belong" placeholder="회사명 입력">
		</div>
		
		<div class = "radio12 hiddenNone">
			<h2>사업자등록번호 입력</h2>
			<input type = "text" name = "person_busiNum">
		</div>
		
		<div class = "radio3 hiddenNone">
			<h2>법인소속직원(기사) 폼</h2>compList에서 검색하는 폼
			<input type = "text" id = "person_belong" name = "person_belong" readonly>
			<button onclick = "document.getElementById('id01').style.display='block'"
			class = "w3-button w3-black">회사 검색</button>
		</div>
		
		<div id = "id01" class = "w3-modal">
			<div class = "w3-modal-content w3-card-4">
				<header class = "w3-container w3-teal">
					<span onclick = "document.getElementById('id01').style.display='none'"
					class = "w3-button w3-display-topright">&times;</span>
					<h2>Modal Header</h2>
				</header>
				<div class = "w3-container">
					회사 검색 폼<br>
					<input type = "text" id = "keyword" name = "keyword">
					<button id = "compSearchBtn">검색</button><br>
				</div>
			</div>
		</div>
	</div>
	
	<div class="wrap wd668">
      <div class="container">
        <div class="form_txtInput">
          <h2 class="sub_tit_txt">회원가입</h2>
          <p class="exTxt">회원가입시 이메일 인증을 반드시 진행하셔야 합니다.</p>
          <div class="join_form">
            <table>
              <colgroup>
                <col width="30%"/>
                <col width="auto"/>
              </colgroup>
              <tbody>
                <tr>
                  <th><span>아이디</span></th>
                  <td><input type="text" placeholder="ID 를 입력하세요."></td>
                </tr>
                <tr>
                  <th><span>이름</span></th>
                  <td><input type="text" placeholder=""></td>
                </tr>
                <tr>
                  <th><span>비밀번호</span></th>
                  <td><input type="text" placeholder="비밀번호를 입력해주세요."></td>
                </tr>
                <tr>
                  <th><span>비밀번호 확인</span></th>
                  <td><input type="text" placeholder="비밀번호를 확인하세요"></td>
                </tr>
                <tr class="email">
                  <th><span>이메일</span></th>
                  <td>
                    <input type="text"  class="email" placeholder=""><span class="mar10">@</span>
                    <input type="text"  class="email email2" placeholder="">
                    <a href="javascript:;" class="btn_confirm">인증번호 발송</a>
                  </td>
                </tr>
                <tr>
                  <th><span>인증번호 확인</span></th>
                  <td><input type="text" class="send_number" placeholder="10:00">
                    <a href="javascript:;" class="btn_confirm">인증번호 발송</a>
                  </td>
                </tr>
                <tr>
                  <th><span>휴대폰 번호</span></th>
                  <td><input type="text" placeholder="ID 를 입력하세요."></td>
                </tr>
              </tbody>
            </table>
            <div class="exform_txt"><span>표시는 필수적으로 입력해주셔야 가입이 가능합니다.</span></div>
          </div><!-- join_form E  -->
          <div class="agree_wrap">
            <div class="checkbox_wrap">
              <input type="checkbox" id="news_letter" name="news_letter" class="agree_chk">
              <label for="news_letter">[선택]뉴스레터 수신동의</label>
            </div>
            <div class="checkbox_wrap mar27">
              <input type="checkbox" id="marketing" name="marketing" class="agree_chk">
              <label for="marketing">[선택]마케팅 목적 개인정보 수집 및 이용에 대한 동의</label>
              <ul class="explan_txt">
                <li><span class="red_txt">항목 : 성별, 생년월일</span></li>
                <li>고객님께서는 위의 개인정보 및 회원정보 수정 등을 통해 추가로 수집하는 개인정보에<br/>
                  대해 동의하지 않거나 개인정보를 기재하지 않음으로써 거부하실 수 있습니다.<br/>
                  다만 이때 회원 대상 서비스가 제한될 수 있습니다.
                </li>
              </ul>
            </div>
          </div>
          <div class="btn_wrap">
            <a href="javascript:;">다음</a>
          </div>
        </div> <!-- form_txtInput E -->
      </div><!-- content E-->
    </div> <!-- container E -->
	<button type = "submit" id = "reg_submit">회원가입</button>
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
			document.querySelector('div.' + 'radio12').classList.remove('hiddenNone')
			document.querySelector('div.' + 'radio2').classList.add('hiddenNone')
			document.querySelector('div.' + 'radio3').classList.add('hiddenNone')
		}
		if(className == 'radio2'){
			document.querySelector('div.' + 'radio12').classList.remove('hiddenNone')
			document.querySelector('div.' + 'radio2').classList.remove('hiddenNone')
			document.querySelector('div.' + 'radio3').classList.add('hiddenNone')
		}
		if(className == 'radio3'){
			document.querySelector('div.' + 'radio12').classList.add('hiddenNone')
			document.querySelector('div.' + 'radio3').classList.remove('hiddenNone')
			document.querySelector('div.' + 'radio2').classList.add('hiddenNone')
		}
	})
	
</script>

<%@ include file="../layout/footer.jsp"%>