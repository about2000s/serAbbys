package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	@PostMapping("/order_new")
	public ModelAndView order(OrderDTO dto) {
		ModelAndView mav = new ModelAndView("order/order_confirm");
		String msg;
		int row = os.order(dto);
		if(row != 0) {
			msg = "주문이 접수되었습니다";
		}
		else {
			msg = "주문 접수에 실패했습니다. 다시 시도해주세요";
		}
		mav.addObject("msg", msg);
		return mav;
	}
	
	@GetMapping("/read/{idx}")
	public ModelAndView read(@PathVariable int idx) {
		ModelAndView mav = new ModelAndView("order/read");
		OrderDTO dto = os.selectOne(idx);
		mav.addObject("dto", dto);
		return mav;
	}
	
}
