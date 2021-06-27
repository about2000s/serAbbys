<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<section class="page-section">
	<div class = "container">
		<table class = "table dataTable-table">
			<tr>
				<td colspan = "3">${dto.serCen_title }</td>
			</tr>
			<tr>
				<td>${dto.serCen_id }</td>
				<td>${dto.serCen_reg }</td>
				<td>조회수: ${dto.serCen_viewCount }</td>
			</tr>
			<tr>
				<td colspan = "3">
					<pre>${dto.serCen_content }</pre>
				</td>
			</tr>
			<tr>
				<td align="right" colspan = "3">
					<c:if test="${dto.serCen_belong == 'faq' }"><c:set var = "why" value = "faq"/></c:if>
					<c:if test="${dto.serCen_belong == 'notice' }"><c:set var = "why" value = "notice"/></c:if>
		 			<button onclick = "location.href='${cpath }/board/${why }?page=${map.page }&type=${map.type }&keyword=${map.keyword}&serCen_belong=${map.serCen_belong}'" class = "btn btn-primary btn-lg">목록</button>
		 			<c:if test="${login.person_check == 'a' }">
		 				<button onclick = "location.href='${cpath }/board/serCenModify/${dto.serCen_idx}?page=${map.page }&type=${map.type }&keyword=${map.keyword}&serCen_belong=${map.serCen_belong}'" class = "btn btn-primary btn-lg">수정</button>
		 			</c:if>
				</td>
			</tr>
		</table>
	</div>
</section>
<%@ include file="../layout/footer.jsp" %>