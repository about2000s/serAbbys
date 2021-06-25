<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<div class = "container">
	<table class = "table dataTable-table">
		<tr>
			<td>${dto.serCen_title }</td>
		</tr>
		<tr>
			<td>
				<pre>${dto.serCen_content }</pre>
			</td>
		</tr>
		<tr>
			<td align="right" colspan="4">
				<c:if test="${dto.serCen_belong == 'faq' }"><c:set var = "why" value = "faq"/></c:if>
				<c:if test="${dto.serCen_belong == 'notice' }"><c:set var = "why" value = "notice"/></c:if>
	 			<button onclick = "location.href='${cpath }/board/${why }?page=${map.page }&type=${map.type }&keyword=${map.keyword}&serCen_belong=${map.serCen_belong}'" class = "btn btn-primary btn-xl">목록</button>
	 			<button onclick = "location.href='${cpath }/board/serCenModify/${dto.serCen_idx}?page=${map.page }&type=${map.type }&keyword=${map.keyword}&serCen_belong=${map.serCen_belong}'" class = "btn btn-primary btn-xl">수정</button>
			</td>
		</tr>
	</table>
</div>
<%@ include file="../layout/footer.jsp" %>