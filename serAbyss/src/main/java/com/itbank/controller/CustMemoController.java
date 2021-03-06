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
public class CustMemoController {
	
	@Autowired
	private CustMemoService cs;
		
	@GetMapping("/crm")
	public void crm() {}
	
	//고객응대내용 가져오기
	@PostMapping("/crm") 
	public ModelAndView crm(@RequestParam HashMap<String, String> map) {
		ModelAndView mav = new ModelAndView();
		System.out.println(map);
		List<ReserveDTO> list = cs.crmOrder(map);
		mav.addObject("list", list);
		mav.addObject("map", map);
		return mav;
	}
	
}
