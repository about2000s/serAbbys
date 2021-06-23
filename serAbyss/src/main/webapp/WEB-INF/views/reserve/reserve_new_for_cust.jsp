<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<link rel = "stylesheet" href = "https://www.w3schools.com/w3css/4/w3.css">

<div class="container">
	<h2>고객이 서비스 신청하기</h2>
	<hr/>
	<form method="post">
		<input type = "hidden" name = "reserve_custId" value = "${login.person_id }">
		<input type = "hidden" name = "reserve_name" value = "${login.person_name }">
		<input type = "hidden" name = "reserve_phone" value = "${login.person_phone }">
		
		<input  type = "hidden" id = "realReserveAddress" name = "reserve_address" value = "${login.person_address }">
		<table class = "table dataTable-table">
			<tr>
				<td><input type="text" name="reserve_title" placeholder="제목 입력" required class="form-control"></td>
			</tr>
			<tr>
				<td><textarea class="form-control" name="reserve_content" required>모델명: ...</textarea></td>
			</tr>
			<tr>
				<td>
					<div>
						<h2>기사 선택</h2>
						<c:forEach var = "i" items = "${engiIdList }">
							<label><input type = "radio" name = "reserveTime_engiId" value = "${i }" class = "form-check-input">${i }</label>
						</c:forEach>
					</div>
					
					<div>
						<h2>일 선택</h2>
						<c:forEach var = "j" items = "${dayList }">
							<label><input type = "radio" name = "reserveTime_day" value = "${j }" class = "form-check-input">${j }</label>
						</c:forEach>
					</div>
					
					<div>
						<h2>시간 선택(이미 예약이 되어있는 시간은 비어있습니다)</h2>
						<c:forEach var = "i" items = "${engiIdList }">
							<c:forEach var = "j" items = "${dayList }">
								<c:forEach var = "k" items = "${reserveTimeList }">
									<c:if test="${k.engiId == i && k.day == j }">
										<div class = "${i }day${j } hiddenNone main">
											<label><input type = "radio" name = "reserveTime_hour" value = "${k.hour }" class = "form-check-input">${k.hour }:00</label>
										</div>
									</c:if>
								</c:forEach>
							</c:forEach>
						</c:forEach>
					</div>
				</td>
			</tr>
			
			<tr>
				<td>
					<button class = "btn btn-primary btn-xl" id = "goToSelectAddress">
						<h3>서비스 받을 주소지</h3>
						<p id = "inputAddress">${login.person_address } ></p>
					</button>
					
				</td>
			</tr>
		</table>
		<div id = "id02" class = "w3-modal">
			<div class = "w3-modal-content w3-card-4">
				<header class = "w3-container w3-teal">
					<span onclick = "document.getElementById('id02').style.display='none'"
					class = "w3-button w3-display-topright">&times;</span>
					<h2>Modal Header</h2>
				</header>
				<div class = "w3-container">
					<button class = "btn btn-primary btn-xl" id = "originalAddressSelectBtn">
						${login.person_address }
					</button>
					<button class = "btn btn-primary btn-xl" id = "newAddressSearchBtn">
						<h2>+주소지 새로 입력</h2>
					</button>
				</div>
			</div>
		</div>
		<div id = "id03" class = "w3-modal">
			<label>주소</label><br>
			<input type="text" id="postcode" placeholder="우편번호">
			<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="address" name = "address" placeholder="주소"><br>
			<input type="text" id="detailAddress" name = "detailAddress" placeholder="상세주소">
			<input type="text" id="extraAddress" placeholder="참고항목">
			<button class = "btn btn-primary btn-xl" id = "thisAddressSelectBtn">이 주소로 선택</button> <!-- 클릭하는 순간 위 버튼에 innerText하고 모든 모달창 닫기 -->
		</div>
		<button class = "btn btn-primary btn-xl" type = "submit">다음</button>
	</form>
</div>

<script>
document.getElementById('newAddressSearchBtn').onclick = function(event){
	event.preventDefault()
	document.getElementById('id03').style.display='block'
}

document.getElementById('goToSelectAddress').onclick = function(event){
	event.preventDefault()
	document.getElementById('id02').style.display='block'
}


document.getElementById('originalAddressSelectBtn').onclick = function(event){
	event.preventDefault()
	document.getElementById('id02').style.display='none'
	document.getElementById('realReserveAddress').value = fullAddress
}


document.getElementById('thisAddressSelectBtn').onclick = function(event){
	event.preventDefault()
	const address = document.querySelector('input[name="address"]').value
	const detailAddress = document.querySelector('input[name="detailAddress"]').value
	const fullAddress = address + ' ' + detailAddress
	document.getElementById('id03').style.display='none'
	document.getElementById('id02').style.display='none'
	document.getElementById('inputAddress').innerText = fullAddress
	document.getElementById('originalAddressSelectBtn').innerText = fullAddress
	document.getElementById('realReserveAddress').value = fullAddress
}
</script>

<script>
let className1
let className2
let classFullName

document.querySelectorAll('input[name="reserveTime_engiId"]').forEach(input => input.onclick = function(event){
	className1 = event.target.value
	classFullName = className1 + 'day' + className2
	console.log(classFullName)
	document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
	document.querySelectorAll('div.' + classFullName).forEach(div => div.classList.remove('hiddenNone'))
});

document.querySelectorAll('input[name="reserveTime_day"]').forEach(input => input.onclick = function(event){
	className2 = event.target.value
	classFullName = className1 + 'day' + className2
	console.log(classFullName)
	document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
	document.querySelectorAll('div.' + classFullName).forEach(div => div.classList.remove('hiddenNone'))
});
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

<%@ include file="../layout/footer.jsp" %>