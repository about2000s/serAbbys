<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<section class="page-section">
	<div class="container">
		<form method="post">
			<input type="hidden" name="reserve_idx" value="${dto.reserve_idx }">
			<input type="hidden" name="page" value="${map.page }">
			<input type="hidden" name="type" value="${map.type }">
			<input type="hidden" name="keyword" value="${map.keyword }">
			<input type="hidden" name="reserve_status" value="${map.reserve_status }">
			담당기사: <input type="text" value="${dto.reserve_engiId}" readonly class="form-control" style = "width: 15%; display: inline; margin-bottom: 20px;">
			<textarea name="reserve_content" class="form-control" style = "width: 50%; margin-bottom: 20px;">${dto.reserve_content}</textarea>
		</form>
			<button type = "submit" id = "submitBtn" class = "btn btn-primary btn-lg" style = "display: inline;" disabled="disabled">수정</button>
			<button class = "btn btn-primary btn-lg" onclick="history.go(-1)">취소</button>
	</div>
</section>

<script>
let contentFlag = true
const content = document.querySelector('textarea[name="reserve_content"]')
const submitBtn = document.getElementById('submitBtn')

$('textarea[name="reserve_content"]').change(function(){
// 	console.log($('input[name="reserveTime_hour"]:checked').val())
	if($('textarea[name="reserve_content"]').val()) contentFlag = true
	else contentFlag = false
	console.log('contentFlag: ' + contentFlag)
	check()
})

function check(event){
	if(contentFlag){
		submitBtn.disabled = false
	}
	else{
		submitBtn.disabled = true
	}
}
</script>

<script>
	document.getElementById('submitBtn').onclick = function(event){
		document.forms[0].submit()
	}
	
</script>
<%@ include file="../layout/footer.jsp" %>