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
import com.itbank.service.PersonService;

@RestController
public class PersonRestController {
	
	@Autowired private PersonService ps;
	private ObjectMapper mapper = new ObjectMapper();
	
	@GetMapping(value = "/compSearch/{keyword}", produces = "application/json; charset=utf-8")
	public String compSearch(@PathVariable String keyword) throws JsonProcessingException {
		System.out.println("sex");
		System.out.println("keyword: " + keyword);
		List<HashMap<String, String>> list = ps.compSearchList(keyword);
		System.out.println(list);
		String json = mapper.writeValueAsString(list);
		return json;
	}
}
