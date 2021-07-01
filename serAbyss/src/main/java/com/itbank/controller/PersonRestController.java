package com.itbank.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.Scanner;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.dto.CustMemoDTO;
import com.itbank.dto.PersonDTO;
import com.itbank.service.CustMemoService;
import com.itbank.service.Hash;
import com.itbank.service.PersonService;

@RestController
public class PersonRestController  {
	
	
	
	@Autowired private PersonService ps;
	@Autowired private CustMemoService cs; 
	
	
	private ObjectMapper mapper = new ObjectMapper();
	
	@GetMapping(value = "/custMemo/crmList/{reserve_idx}",  produces = "application/json; charset=utf-8")
	public String crmRead(@PathVariable int reserve_idx) throws JsonProcessingException {
		List<HashMap<String, String>> list = cs.crmRead(reserve_idx);
		String json = mapper.writeValueAsString(list);
		return json;
	}
	
	@GetMapping(value = "/compSearch/{keyword}", produces = "application/json; charset=utf-8")
	public String compSearch(@PathVariable String keyword) throws JsonProcessingException {
		List<HashMap<String, String>> list = ps.compSearchList(keyword);
		String json = mapper.writeValueAsString(list);
		return json;
	}
	
	//응대기록 리스트 보기
	@GetMapping(value = "/crm/{reserve_idx}", produces = "application/json; charset=utf-8")
	public String crm(@PathVariable int reserve_idx) throws JsonProcessingException {
		List<HashMap<String, String>> list = cs.selectList(reserve_idx);
		String json = mapper.writeValueAsString(list);
		return json;
	}
	
	@GetMapping(value = "/mailto/{person_email}/", produces = "application/text; charset=utf-8")
	public String mailto(@PathVariable String person_email, HttpSession session) throws FileNotFoundException {
		
		int row = ps.emailCheck(person_email);
		if(row == 1) {
			return "fail";
		}
		
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
		
		if(result.equals(authNumber)) {
			return hashNumber;
		}
		else {
			return result;
		}
		
	}
	
	@GetMapping("/getAuthResult/{userNumber}")
	public boolean getAuthResult(@PathVariable String userNumber, HttpSession session) {
		String hashNumber = (String)session.getAttribute("hashNumber");
		boolean flag = hashNumber.equals(Hash.getHash(userNumber));
		System.out.println(flag);
		return flag;
	}
	
	//응대기록 남기기
	@PostMapping(value = "/record")
	public int record(@RequestBody CustMemoDTO dto) {
		int row = cs.insert(dto);
		return 0;
	}
	
	@GetMapping(value = "/phoneInjung/{person_phone}")
	public String phoneInjung(@PathVariable String person_phone, HttpSession session) throws Exception {
		int row = ps.phoneCheck(person_phone);
		if(row == 1) {
			System.out.println("fail");
			return "fail";
		}
		else {
			String authNumber = ps.getAuthNumber();
			session.setAttribute("authNumber", authNumber);
			System.out.println(person_phone);
			String msg = ps.any(person_phone, authNumber);
			return msg;
		}
	}
	
	@GetMapping(value = "/injungPhone1111/{authNumberPhone}")
	public String authNumberPhone(@PathVariable String authNumberPhone, HttpSession session) {
		String authNumber = (String)session.getAttribute("authNumber");
		System.out.println("authNumber: " + authNumber);
		if(authNumberPhone.equals(authNumber)) {
			return "1";
		}
		else {
			return "0";
		}
	}
	
	@GetMapping(value = "/regionSearch/{keyword}", produces = "application/json; charset=utf-8")
	public String regionSearch(@PathVariable String keyword) throws JsonProcessingException {
		List<HashMap<String, String>> list = ps.regionSearchList(keyword);
		String json = mapper.writeValueAsString(list);
		return json;
	}
}
