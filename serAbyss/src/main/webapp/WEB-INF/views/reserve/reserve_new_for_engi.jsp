<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<section class="page-section">
	<div class="container">
		<h2>수리기사가 서비스 신청하기</h2>
		<hr/>
		<form method="post">
			<input type = "hidden" name = "reserve_status" value = "예약완료">
			<input type = "hidden" name = "reserve_compBelong" value = "${login.person_belong }">
			<input type = "hidden" name = "reserve_engiId" value = "${login.person_id }">
			<table class = "table dataTable-table">
				<tr>
					<td><input type="text" name="reserve_phone" placeholder="고객 전화번호 입력" required class = "form-control" style = "width: 20%; display:inline;">&nbsp;'-' 없이 입력해주세요!</td>
				</tr>
				<tr>
					<td><input type="text" name="reserve_name" placeholder="고객 이름 입력" required required class = "form-control" style = "width: 20%;"></td>
				</tr>
				<tr>
					<td>
						<label>주소</label><br>
						<input type="text" id="postcode" placeholder="우편번호" readonly class = "form-control" style = "width: 15%; display:inline;">
						<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="address" name = "address" placeholder="주소" readonly class = "form-control" style = "width: 30%;">
						<input type="text" id="detailAddress" name = "detailAddress" placeholder="상세주소" class = "form-control" style = "width: 15%; display:inline;">
						<input type="text" id="extraAddress" placeholder="참고항목" readonly class = "form-control" style = "width: 15%; display:inline;">
					</td>
				</tr>
				<tr>
					<td><textarea class="form-control" name="reserve_content" required>모델명: ...</textarea></td>
				</tr>
				<tr>
					<td>
						<div>
							<h2>기사 선택</h2>
							<c:forEach var = "dto" items = "${engiList }">
								<label><input type = "radio" name = "reserveTime_engiId" value = "${dto.person_id }" class = "form-check-input">${dto.person_name }(${dto.person_id })</label>
							</c:forEach>
						</div>
						
						<div>
							<h2>날짜 선택</h2>
							<c:forEach var = "j" items = "${dayList }">
								<label><input type = "radio" name = "reserveTime_day" value = "${j }" class = "form-check-input">${j }</label>
							</c:forEach>
						</div>
						
						<div>
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
			<button class = "btn btn-primary btn-xl" type = "submit">다음</button>
			<button class = "btn btn-primary btn-xl" onclick="location.href='history(-1)'">취소</button>
		</form>
	</div>
</section>
<script>
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