package com.itbank.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.dto.CompDTO;
import com.itbank.dto.CustomerDTO;
import com.itbank.service.CustomerService;
import com.itbank.service.PersonService;

@RestController
public class PersonRestController {
	
	@Autowired private PersonService ps;
	@Autowired private CustomerService cs; 
	
	private ObjectMapper mapper = new ObjectMapper();
	
	@GetMapping(value = "/compSearch/{keyword}", produces = "application/json; charset=utf-8")
	public String compSearch(@PathVariable String keyword) throws JsonProcessingException {
		List<HashMap<String, String>> list = ps.compSearchList(keyword);
		String json = mapper.writeValueAsString(list);
		return json;
	}
	
	@GetMapping(value = "/crm/{service_idx}", produces = "application/json; charset=utf-8")
	public String crm(@PathVariable int service_idx) throws JsonProcessingException {
		List<CustomerDTO> list = cs.selectList(service_idx);
		System.out.println(list);
		String json = mapper.writeValueAsString(list);
		return json;
	}
}
