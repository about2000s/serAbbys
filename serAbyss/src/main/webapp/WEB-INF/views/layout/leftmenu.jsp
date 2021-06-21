<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="leftmenu">
	<ul>
		<li><a href="${cpath }/order/order_new_for_engi">서비스신청  </a></li>
		<li><a href="${cpath }/order/statusList?page=1&service_status=">전체보기<br></a></li>
		<li><a href="${cpath }/order/statusList?page=1&service_status=등록완료">등록완료<br></a></li>
		<li><a href="${cpath }/order/statusList?page=1&service_status=서비스중 ">서비스중 </a></li>
		<li><a href="${cpath }/order/statusList?page=1&service_status=서비스완료">서비스완료 </a></li>
		<li><a href="${cpath }/order/statusList?page=1&service_status=결제완료">결제완료</a></li>
		<li><a href="${cpath }/order/statusList?page=1&service_status=환불접수">환불접수</a></li>
		<li><a href="${cpath }/order/statusList?page=1&service_status=환불완료">환불완료</a></li>
		<li><a href="${cpath }/order/statusList?page=1&service_status=모든처리완료">모든처리완료</a></li>	
	</ul>
</div>