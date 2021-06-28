<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<section class = "page-section">
	<div class="container">
	<div class = "row" style = "margin-left: 10%;">
		<h2>Login</h2>
		<hr>
		<div class = "col-md-6">
			<h3>개인회원 로그인</h3>
			<form method = "post" action = "${cpath }/common/personLogin">
				<div style = "float: left;">
					<input type = "text" id = "indi_id" name = "person_id" placeholder="아이디" class = "form-control">
					<input type = "password" id = "indi_pw" name = "person_pw" placeholder="비밀번호" class = "form-control">
				</div>
				<button class = "btn btn-primary btn-xl" id = "indi_login" type = "submit" style = "height: 80px;" disabled="disabled">로그인</button>
			</form>
		</div>
		<div class = "col-md-6">
			<h3>기업회원 로그인</h3>
			<form method = "post" action = "${cpath }/common/companyLogin">
				<div style = "float: left;">
					<input type = "text" id = "comp_id" name = "person_id" placeholder="아이디" class = "form-control">
					<input type = "password" id = "comp_pw" name = "person_pw" placeholder="비밀번호" class = "form-control">
				</div>
				<button class = "btn btn-primary btn-xl" id = "comp_login" type = "submit" style = "height: 80px;" disabled="disabled">로그인</button>
			</form>
		</div>
		<div style = "margin-top: 20px;">
			<div class="col-md-10" style = "text-align: center;">
				<button onclick = "location.href='${cpath}/common/selectIndiComp?say=id'" class = "btn btn-primary btn-lg">ID 찾기</button>
				<button onclick = "location.href='${cpath}/common/selectIndiComp?say=pw'" class = "btn btn-primary btn-lg">비밀번호 재발급</button><br>
				회원이 아니세요? <button onclick = "location.href='${cpath}/common/join'" class = "btn btn-primary btn-lg" style = "margin-top: 20px;">회원가입</button>
			</div>
			<div>
			</div>
		</div>
	</div>
</div>
</section>

<script>
const indi_id = document.getElementById('indi_id')
const indi_pw = document.getElementById('indi_pw')
const comp_id = document.getElementById('comp_id')
const comp_pw = document.getElementById('comp_pw')

let indi_id_flag = false
let indi_pw_flag = false
let comp_id_flag = false
let comp_pw_flag = false

const indi_login = document.getElementById('indi_login')
const comp_login = document.getElementById('comp_login')

indi_id.onkeydown = function(event){
	if(indi_id.value){
		indi_id_flag = true
	}
	else{
		indi_id_flag = false
	}
	check1()
}
indi_pw.onkeydown = function(event){
	if(indi_pw.value){
		indi_pw_flag = true
	}
	else{
		indi_pw_flag = false
	}
	check1()
}
comp_id.onkeydown = function(event){
	if(comp_id.value){
		comp_id_flag = true
	}
	else{
		comp_id_flag = false
	}
	check2()
}
comp_pw.onkeydown = function(event){
	if(comp_pw.value){
		comp_pw_flag = true
	}
	else{
		comp_pw_flag = false
	}
	check2()
}


function check1(event){
	if(indi_id_flag && indi_pw_flag){
		indi_login.disabled = false
	}
	else{
		indi_login.disabled = true
	}
}
function check2(event){
	if(comp_id_flag && comp_pw_flag){
		comp_login.disabled = false
	}
	else{
		comp_login.disabled = true
	}
}
</script>



<%@ include file="../layout/footer.jsp" %>