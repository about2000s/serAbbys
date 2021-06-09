package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.dto.OrderDTO;
import com.itbank.service.OrderService;

@Controller
@RequestMapping("order")
public class OrderController {

	@GetMapping("/service_list_all")
	public ModelAndView ListAll() {
		ModelAndView mav = new ModelAndView("order/list");
		List<OrderDTO> list = os.selectall();
		mav.addObject("list", list);
		return mav;
	}
	
	@Autowired OrderService os;
	
	@GetMapping("/statusList")
	public ModelAndView registList(@RequestParam String status) {
		ModelAndView mav = new ModelAndView("order/list");
		List<OrderDTO> list = os.selectStatus(status);
		mav.addObject("list", list);
		return mav;
	}
	
	@GetMapping("/order_new")
	public String orderNew() {
		return "order/order_new";
	}
	
}
