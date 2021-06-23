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

import com.itbank.dto.CustMemoDTO;
import com.itbank.dto.ReserveDTO;
import com.itbank.service.CustMemoService;

@Controller
@RequestMapping("custMemo")
public class CustomerController {
	
	@Autowired
	private CustMemoService cs;
	
	@PostMapping("/crm1")
	public String custMemo(CustMemoDTO dto) {
		System.out.println(dto);
		
		return "custMemo/crm";
	}
		
	@GetMapping("/crm")
	public void crm() {}
	
	@PostMapping("/crm")
	public ModelAndView crm(@RequestParam HashMap<String,String> param ) {
		ModelAndView mav = new ModelAndView();
		List<ReserveDTO> list = cs.crmOrder(param); 
		mav.addObject("list", list);
		return mav;
	}
	
	@GetMapping("/crm?custMemo_service_idx=${custMemo_service_idx}")
	public String selectRecord(@PathVariable Integer custMemo_service_idx) {
		System.out.println(custMemo_service_idx);
		return "custMemo/crm";
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
