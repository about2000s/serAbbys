package com.itbank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("order")
public class OrderController {

	@GetMapping("/service_list_all")
	public String serviceListAll() {
		return "order/service_list_all";
	}
	
	@GetMapping("/order_new")
	public String orderNew() {
		return "order/order_new";
	}
	
}
