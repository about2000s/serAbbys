<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>



<div class="container">
	<h2>고객이 서비스 신청하기</h2>
	<hr/>
	<form method="post" enctype="multipart/form-data">
		<input type = "hidden" name = "service_custId" value = "${login.person_id }">
		<input type = "hidden" name = "service_name" value = "${login.person_name }">
		<input type = "hidden" name = "service_phone" value = "${login.person_phone }">
		<input type = "hidden" name = "dayList" value = "${dayList }">
		<table>
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
					<div>
						<h2>기사 선택</h2>
						<c:forEach var = "i" items = "${engiIdList }">
							<label><input type = "radio" name = "reserve_engiId" value = "${i }">${i }</label>
						</c:forEach>
					</div>
					
					<div>
						<h2>일 선택</h2>
						<c:forEach var = "j" items = "${dayList }">
							<label><input type = "radio" name = "reserve_day" value = "${j }">${j }</label>
						</c:forEach>
					</div>
					
					<div>
						<h2>시간 선택</h2>
						<c:forEach var = "i" items = "${engiIdList }">
							<c:forEach var = "j" items = "${dayList }">
								<c:forEach var = "k" items = "${list }">
									<c:if test="${k.engiId == i && k.day == j }">
										<div class = "${i }day${j } hiddenNone main">
											<label><input type = "radio" name = "reserve_hour" value = "${k.hour }">${k.hour }</label>
										</div>
									</c:if>
								</c:forEach>
							</c:forEach>
						</c:forEach>
					</div>
				</td>
			</tr>
		</table>
		<input type = "submit" value = "제출">
	</form>
</div>


<script>
let className1
let className2
let classFullName

document.querySelectorAll('input[name="reserve_engiId"]').forEach(input => input.onclick = function(event){
	className1 = event.target.value
	classFullName = className1 + 'day' + className2
	document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
	document.querySelectorAll('div.' + classFullName).forEach(div => div.classList.remove('hiddenNone'))
});

document.querySelectorAll('input[name="reserve_day"]').forEach(input => input.onclick = function(event){
	className2 = event.target.value
	classFullName = className1 + 'day' + className2
	document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
	document.querySelectorAll('div.' + classFullName).forEach(div => div.classList.remove('hiddenNone'))
});
</script>

	
<!-- <div id='result'> -->
<!--   <input type='file' id='uploadFile' multiple='multiple'/><br/> -->
<!--   <table class="table"> -->
<!--     <tr> -->
<!--       <th>미리보기</th> -->
<!--       <th>파일명</th> -->
<!--       <th>파일크기</th> -->
<!--     </tr> -->
<!--     <tr v-for="item in fileList"> -->
<!--       <td><img v-bind:src="item.url" style='height:80px;width:80px;'/></td> -->
<!--       <td>{{item.name}}</td> -->
<!--       <td>{{item.size}}</td> -->
<!--     </tr> -->
<!--   </table> -->
<!-- </div> -->
<!-- <script src="https://unpkg.com/vue@2.6.6/dist/vue.js"></script> -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<!-- <script src='http://jquery-multifile-plugin.googlecode.com/svn/trunk/jquery.form.js' type="text/javascript"></script> -->
<!-- <script src='http://jquery-multifile-plugin.googlecode.com/svn/trunk/jquery.MetaData.js' type="text/javascript"></script> -->
<!-- <script src='http://jquery-multifile-plugin.googlecode.com/svn/trunk/jquery.MultiFile.js' type="text/javascript"></script> -->
<!-- <script src='http://jquery-multifile-plugin.googlecode.com/svn/trunk/jquery.blockUI.js' type="text/javascript"></script>  -->


<script>
//   var uploadApp = new Vue({
//     el: '#result',
//     data: {
//       fileList: []
//     }
//   })
//   $("#afile").change(function(event){
//     console.log($(this)[0].files);
//     var files = $(this)[0].files;
//     uploadApp.fileList = [];
//     $.each(files, function(i, item){
//       var fileReader = new FileReader();
//       fileReader.onload = function(e){
//         var img = {
//           url: e.target.result,
//           name: item.name,
//           size: item.size
//         };
//         uploadApp.fileList.push(img);
//       }
//       fileReader.readAsDataURL(item);
//     });
//   });
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