package com.itbank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.dto.OrderDTO;
import com.itbank.service.CustomerService;

@Controller
@RequestMapping("/customer")
public class CustomerController {
	
	@Autowired
	private CustomerService cs;
	
	@GetMapping("/crm")
	public void crm() {}
	
	@PostMapping("/crm")
	public ModelAndView crm(@PathVariable String c_word ) {
		
		ModelAndView mav = new ModelAndView();
		OrderDTO dto = cs.crmOrder(c_word); 
		mav.addObject("dto", dto);

		return mav;
	}
	

}
