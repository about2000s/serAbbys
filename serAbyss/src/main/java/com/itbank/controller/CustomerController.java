package com.itbank.controller;

import java.util.HashMap;
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
import com.itbank.service.CustomerService;

@Controller
@RequestMapping("customer")
public class CustomerController {
	
	@Autowired
	private CustomerService cs;
	
	@GetMapping("/crm")
	public void crm() {}
	
	@PostMapping("/crm")
	public ModelAndView crm(@RequestParam HashMap<String,String> param ) {
		ModelAndView mav = new ModelAndView();
		List<OrderDTO> list = cs.crmOrder(param); 
		mav.addObject("list", list);
		return mav;
	}
	
	@GetMapping("/crm?customer_service_idx=${customer_service_idx}")
	public String selectRecord(@PathVariable Integer customer_service_idx) {
		
		System.out.println(customer_service_idx);
		
		
		
		return "customer/crm";
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
