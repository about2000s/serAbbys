package com.itbank.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.dto.CompDTO;
import com.itbank.dto.CustomerDTO;
import com.itbank.service.CustomerService;
import com.itbank.service.Hash;
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
		List<HashMap<String, String>> list = cs.selectList(service_idx);
		String json = mapper.writeValueAsString(list);
		return json;
	}
	
	@GetMapping(value = "/mailto/{person_email}/", produces = "application/text; charset=utf-8")
	public String mailto(@PathVariable String person_email, HttpSession session) throws FileNotFoundException {
		
		String filePath = session.getServletContext().getRealPath("/WEB-INF/data/mailAccount.dat");
		File file = new File(filePath);
		if(!file.exists()) {
			return "메일전송에 필요한 계정 정보를 찾을 수 없습니다. 즉, 파일이 존재하지 않습니다";
		}
		Scanner sc = new Scanner(file);
		String account = null;
		while(sc.hasNextLine()) {
			account = sc.nextLine();
		}
		sc.close();
		
		String authNumber = ps.getAuthNumber();
		String hashNumber = Hash.getHash(authNumber);
		
		session.setAttribute("hashNumber", hashNumber);
		
		System.out.println("메일 받을 주소: " + person_email);
		
		String result = ps.sendMail(person_email, authNumber, account);
		
		System.out.println("ssd");
		return "성공";
	}
}
