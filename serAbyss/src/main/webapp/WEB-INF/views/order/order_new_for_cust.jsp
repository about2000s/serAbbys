<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<!-- <div class="container"> -->
<!-- 	<h2>고객이 서비스 신청하기</h2> -->
<!-- 	<hr/> -->
<!-- 	<form method="post" enctype="multipart/form-data"> -->
<%-- 	<input type = "hidden" name = "custId" value = "${login.person_id }"> --%>
<%-- 	<input type = "hidden" name = "address" value = "${login.person_address }"> --%>
<!-- 	<table> -->
<!-- 		<tr> -->
<!-- 			<th>제목입력</th> -->
<!-- 			<td><input type="text" name="service_title" placeholder="제목 입력" required></td> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<th>내용</th> -->
<!-- 			<td><textarea class="write-area" name="service_content" required>모델명: ...</textarea></td> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<th>파일입력</th> -->
<!-- 			<td><a><input type="file" name="file"></a></td> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<th>예약하기</th> -->
<!-- 			<td> -->
<!-- 				<div> -->
<!-- 				<h2>수리기사 선택</h2> -->
<%-- 				<c:forEach var = "engi" items = "${engiIdList }"> --%>
<%-- 					<label><input type = "radio" name = "engiId" value = "${engi }">${engi }</label> --%>
<%-- 				</c:forEach> --%>
<!-- 			</div> -->
<!-- 		<hr> -->
	
<!-- 		<div> -->
<!-- 			<h2>월 선택</h2> -->
<%-- 			<c:forEach var = "month" items = "${monthList }"> --%>
<%-- 				<label><input type = "radio" name = "month" value = "${month }">${month }</label> --%>
<%-- 			</c:forEach> --%>
<!-- 		</div> -->
<!-- 		<hr> -->
	
<!-- 		<div> -->
<!-- 			<h2>일 선택</h2> -->
<%-- 			<c:forEach var = "day" items = "${dayList }"> --%>
<%-- 				<label><input type = "radio" name = "day" value = "${day }">${day }</label> --%>
<%-- 			</c:forEach> --%>
<!-- 		</div> -->
<!-- 		<hr> -->
	
<%-- 		<c:forEach var = "a" items = "${aMap }"> --%>
<%-- 			<c:forEach var = "b" items = "${a.value }"> --%>
<%-- 				<c:forEach var = "c" items = "${b.value }"> --%>
<%-- 					<div class = "main ${a.key }${b.key }${c.key } hiddenNone"> --%>
<%-- 						<c:forEach var = "d" items = "${c.value }"> --%>
<%-- 								<label><input type = "radio" name = "hour" value = "${d }">${d }시</label> --%>
<%-- 						</c:forEach> --%>
<!-- 					</div> -->
<%-- 				</c:forEach> --%>
<%-- 			</c:forEach> --%>
<!-- 			<hr> -->
<%-- 		</c:forEach> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan='2'><input type="submit" value="신청하기" disabled="disabled"></td> -->
<!-- 			</tr> -->
<!-- 		</table> -->
<!-- 		<hr> -->
	
<!-- 	</form> -->
	
<script src="https://unpkg.com/vue@2.6.6/dist/vue.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<div id='result'>
  <input type='file' id='uploadFile' multiple='multiple'/><br/>
  <table class="table">
    <tr>
      <th>미리보기</th>
      <th>파일명</th>
      <th>파일크기</th>
    </tr>
    <tr v-for="item in fileList">
      <td><img v-bind:src="item.url" style='height:80px;width:80px;'/></td>
      <td>{{item.name}}</td>
      <td>{{item.size}}</td>
    </tr>
  </table>
</div>
<script>
  var uploadApp = new Vue({
    el: '#result',
    data: {
      fileList: []
    }
  })
  $("#uploadFile").change(function(event){
    console.log($(this)[0].files);
    var files = $(this)[0].files;
    uploadApp.fileList = [];
    $.each(files, function(i, item){
      var fileReader = new FileReader();
      fileReader.onload = function(e){
        var img = {
          url: e.target.result,
          name: item.name,
          size: item.size
        };
        uploadApp.fileList.push(img);
      }
      fileReader.readAsDataURL(item);
    });
  });
</script>

<script>
// let className1
// let className2
// let className3
// let classFullName

// document.querySelectorAll('input[name="engiId"]').forEach(input => input.onclick = function(event){
// 	className1 = event.target.value
// 	classFullName = className1 + className2 + className3
// 	document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
// 	document.querySelector('div.' + classFullName).classList.remove('hiddenNone')
// })

// document.querySelectorAll('input[name="month"]').forEach(input => input.onclick = function(event){
// 	className2 = event.target.value
// 	classFullName = className1 + className2 + className3
// 	document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
// 	document.querySelector('div.' + classFullName).classList.remove('hiddenNone')
// })

// document.querySelectorAll('input[name="day"]').forEach(input => input.onclick = function(event){
// 	className3 = event.target.value
// 	classFullName = className1 + className2 + className3
// 	document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
// 	document.querySelector('div.' + classFullName).classList.remove('hiddenNone')
// })
</script>
	
<%@ include file="../layout/footer.jsp" %>