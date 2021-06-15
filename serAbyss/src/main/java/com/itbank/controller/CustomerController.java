package com.itbank.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	public String crm( Map<String,String> param ) {
		
		System.out.println(param.get(param));
//		
//		ModelAndView mav = new ModelAndView();
//		
////		OrderDTO dto = cs.crmOrder(param); 
//		
////		System.out.println(selectedWord +  word);
////		System.out.println(dto);
////		mav.addObject("dto", dto);
//
		return "customer/crm";
	}
//	

}
