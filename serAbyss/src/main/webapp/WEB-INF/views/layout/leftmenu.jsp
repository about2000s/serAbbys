<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="leftmenu">
	<ul>
		<li><a href="${cpath }/order/order_new">서비스신청  </a></li>
		<li><a href="${cpath }/order/statusList?page=1&status=register">서비스준비중  <br></a></li>
		<li><a href="${cpath }/order/statusList?page=1&status=fixing">서비스중  </a></li>
		<li><a href="${cpath }/order/statusList?page=1&status=fixed">서비스완료  </a></li>
		<li><a href="${cpath }/order/statusList?page=1&status=payed">결제완료</a></li>
		<li><a href="${cpath }/order/statusList?page=1&status=cancleRegister">환불접수</a></li>
		<li><a href="${cpath }/order/statusList?page=1&status=cancleComplete">환불완료</a></li>
		<li><a href="${cpath }/order/statusList?page=1&status=success">수리완료</a></li>	
	</ul>
</div>