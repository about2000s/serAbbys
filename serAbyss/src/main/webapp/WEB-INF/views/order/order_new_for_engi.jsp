<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<div class="container">
	<h2>수리기사가 서비스 신청하기</h2>
	<hr/>
	<form method="post" enctype="multipart/form-data">
		<input type = "hidden" name = "service_status" value = "register">
		<input type = "hidden" name = "service_compBelong" value = "${login.person_belong }">
		<input type = "hidden" name = "service_engiId" value = "${login.person_id }">
		<table>
			<tr>
				<td><input type="text" name="service_custId" placeholder="고객 아이디 입력" required></td>
			</tr>
			<tr>
				<td><input type="text" name="service_phone" placeholder="고객 전화번호 입력" required></td>
			</tr>
			<tr>
				<td><input type="text" name="service_name" placeholder="고객 이름 입력" required></td>
			</tr>
			<tr>
				<td><input type="text" name="service_title" placeholder="제목 입력" required></td>
			</tr>
			<tr>
				<td><textarea class="write-area" name="service_content" required>모델명: ...</textarea></td>
			</tr>
			<tr>
				<td><input type="file" id="file" name="file" class="multi" style="width:60%;"></td>
			</tr>
<!-- 			<tr v-for="item in fileList"> -->
<!-- 				<td><img v-bind:src="item.url" style="height:80px;width:80px;"/></td> -->
<!-- 			</tr> -->
			<tr>
				<td>
					<label>주소</label><br>
					<input type="text" id="postcode" placeholder="우편번호">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="address" name = "address" placeholder="주소"><br>
					<input type="text" id="detailAddress" name = "detailAddress" placeholder="상세주소">
					<input type="text" id="extraAddress" placeholder="참고항목">
				</td>
			</tr>
			<tr>
				<td>
					<div>
						<h2>기사</h2>
						<c:forEach var = "i" items = "${engiIdList }">
							<label><input type = "radio" name = "reserve_engiId" value = "${i }" checked>${i }</label>
						</c:forEach>
					</div>
					
					<div>
						<h2>일 선택</h2>
						<c:forEach var = "j" items = "${dayList }">
							<label><input type = "radio" name = "reserve_day" value = "${j }">${j }</label>
						</c:forEach>
					</div>
					
					<div>
						<h2>시간 선택(이미 예약이 되어있는 시간은 비어있습니다)</h2>
<%-- 						<c:forEach var = "i" items = "${engiIdList }"> --%>
							<c:forEach var = "j" items = "${dayList }">
								<c:forEach var = "k" items = "${list }">
									<c:if test="${k.day == j }">
										<div class = "day${j } hiddenNone main">
											<label><input type = "radio" name = "reserve_hour" value = "${k.hour }">${k.hour }</label>
										</div>
									</c:if>
								</c:forEach>
							</c:forEach>
<%-- 						</c:forEach> --%>
					</div>
				</td>
			</tr>
		</table>
		<input type = "submit" value = "제출">
	</form>
</div>


<script>
// let className1
let className2
let classFullName

// document.querySelectorAll('input[name="reserve_engiId"]').forEach(input => input.onclick = function(event){
// 	className1 = event.target.value
// 	classFullName = className1 + 'day' + className2
// 	document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
// 	document.querySelectorAll('div.' + classFullName).forEach(div => div.classList.remove('hiddenNone'))
// });

document.querySelectorAll('input[name="reserve_day"]').forEach(input => input.onclick = function(event){
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
	
<!--  210614 기찬씨 나중에 보고 c:구문만 살려서 쓰시고 지워주세요 : 남형진

	<form method="post" enctype="multipart/form-data">
		<div class="order">
			<div>
				<p>
			<%-- 		<c:when test="${login.person_check }.equals('cust')"> --%>
			<%-- 			<input type="text" value="${login.person_id }" readonly> --%>
			<%-- 		</c:when> --%>
			<%-- 		<c:otherwise> --%>
			<!-- 			<input type="text" placeholder="고객id입력" required> -->
			<%-- 		</c:otherwise> --%> <!-- 나중에 로그인 session 비교해서 값 들어가게끔 설정 --
					<input type="text" name="service_id" placeholder="고객id입력" required>
				</p>
				<p>
					<input type="text" name="service_title" placeholder="제목 입력" required>
				</p>
			</div>
		</div>
		<div class="content">
			<textarea class="write-area" name="service_content" required></textarea>
		</div>
		<div class="order">
			<p>
				<input type="file" name="file">
			</p>
		</div>
		<div class="order">
			<p><input type="text" name="service_address" placeholder="주소 입력" required></p>
		</div>
		<%-- 	<c:when test="${login.person_check }.equals('cust')"> --%>
		<!-- 		<p><input type="text" value="없음" readonly></p> -->
		<%-- 	</c:when> --%>
		<%-- 	<c:when test="${login.person_check } == 'noCompEngi' or 'yesCompEngi'"> --%>
		<%-- 		<p><input type="text" value="${login.person_id }" readonly></p> --%>
		<%-- 	</c:when> --%> <!-- 로그인 session 비교해서 로그인 한 사람이 기사면 바로 본인 id가 입력되게 --
		<input type="hidden" name="service_status" value="register">
		<div class="order">
			<p><input type="text" name="service_engineer" value="없음" readonly></p>
		</div>
		<div class="order">
			<input type="submit" value="신청하기">
		</div>
	</form>
</div> -->
<%@ include file="../layout/footer.jsp" %>