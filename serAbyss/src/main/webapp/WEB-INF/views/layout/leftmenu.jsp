<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="leftmenu">
	<ul>
		<li><a href="${cpath }/order/order_new">서비스신청  </a></li>
		<li><a href="${cpath }/order/statusList?page=1&type=&search=&status=접수완료">서비스준비중  <br></a></li>
		<li><a href="${cpath }/order/statusList?page=1&type=&search=&status=등록완료">기사 배정 </a></li>
		<li><a href="${cpath }/order/statusList?page=1&type=&search=&status=fixing">서비스 중  </a></li>
		<li><a href="${cpath }/order/statusList?page=1&type=&search=&status=fixed">서비스완료  </a></li>
		<li><a href="${cpath }/order/statusList?page=1&type=&search=&status=payed">결제완료</a></li>
		<li><a href="${cpath }/order/statusList?page=1&type=&search=&status=cancleRegister">환불접수</a></li>
		<li><a href="${cpath }/order/statusList?page=1&type=&search=&status=cancleComplete">환불완료</a></li>
		<li><a href="${cpath }/order/statusList?page=1&type=&search=&status=success">수리완료</a></li>	
	</ul>
</div>