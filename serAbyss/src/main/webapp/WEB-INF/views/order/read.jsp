<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<div class="order">
	<div>No. ${dto.service_idx } | <b>${dto.service_title }</b> | ${dto.service_id }</div>
	<div>${dto.service_reg } | 조회수 : ${dto.service_viewCount }</div>
</div>

<div class="content" style="flex-flow: column;">
	<c:if test="${not empty dto.service_uploadFile }">
		<div><img src="${cpath }/upload/${dto.service_uploadFile }" height="300px"></div>
	</c:if>
	<pre>${dto.service_content }</pre>
</div>

<div class="order"> 
	<div>
		<a href="${cpath }/order/statusList/?status=${dto.service_status}"><button>목록</button></a>
	</div>
<%-- 	<c:if test="${dto.service_id == (login.person_id or 'admin')}"> --%>
		<div>
			<a href="${cpath }/order/select/${dto.service_idx}?value=modify"><button>수정</button></a>
			<button id="deleteBtn">삭제</button>
		</div>
<%-- 	</c:if> --%>
</div>

<script>
	const deleteUrl = '${cpath }/order/delete/${dto.service_idx}';
	document.getElementById('deleteBtn').onclick = function(event) {
		if(confirm("정말 삭제하시겠습니까?") == true) {
			location.href = deleteUrl + "?" + '${login.person_check}';
		} else {
			return;
		}
	}
</script>

<%@ include file="../layout/footer.jsp" %>