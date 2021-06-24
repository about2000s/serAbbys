<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<div class="leftmenu">
	<ul>
		<c:if test="${login.person_check == 'y' }">
		<li><a href="${cpath }/reserve/reserve_new_for_engi">서비스신청  </a></li>
		</c:if>
		<c:if test="${login.person_check == 'n' }">
		<li><a href="${cpath }/reserve/reserve_new_for_cust">서비스신청  </a></li>
		</c:if>
		<li><a href="${cpath }/reserve/statusList?page=1&reserve_status=">전체보기<br></a></li>
		<li><a href="${cpath }/reserve/statusList?page=1&reserve_status=등록완료">등록완료<br></a></li>
		<li><a href="${cpath }/reserve/statusList?page=1&reserve_status=서비스중 ">서비스중 </a></li>
		<li><a href="${cpath }/reserve/statusList?page=1&reserve_status=서비스완료">서비스완료 </a></li>
		<li><a href="${cpath }/reserve/statusList?page=1&reserve_status=결제완료">결제완료</a></li>
		<li><a href="${cpath }/reserve/statusList?page=1&reserve_status=환불접수">환불접수</a></li>
		<li><a href="${cpath }/reserve/statusList?page=1&reserve_status=환불완료">환불완료</a></li>
		<li><a href="${cpath }/reserve/statusList?page=1&reserve_status=모든처리완료">모든처리완료</a></li>	
	</ul>
</div>