package com.itbank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.service.PersonService;

@RestController
public class PersonRestController {
	
	@Autowired private PersonService cs;
	private ObjectMapper mapper;
	
//	@GetMapping("/idCheck/{id}")//기업, 개인 회원가입 둘 다 id 중복체크용
//	public String idCheck(@PathVariable String id) {
//		int row = cs.selectOne(id);
//		return row + "";
//	}
}
