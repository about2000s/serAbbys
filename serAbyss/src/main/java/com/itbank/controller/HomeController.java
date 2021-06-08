package com.itbank.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.dto.PersonDTO;
import com.itbank.service.PersonService;

@Controller
@RequestMapping("common")
public class HomeController {
	
	@Autowired private PersonService ps;
	
	@PostMapping("/personLogin")
	public ModelAndView personLogin(PersonDTO inputData, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		PersonDTO login = ps.personLogin(inputData);
		if(login != null) {
			session.setAttribute("login", login);
		}
		else {
			String msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
			mav.addObject("msg", msg);
			mav.setViewName("alert");
		}
		return mav;
	}
	
	@PostMapping("/companyLogin")
	public ModelAndView companyLogin(PersonDTO inputData, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		PersonDTO login = ps.companyLogin(inputData);
		if(login != null) {
			session.setAttribute("login", login);
			mav.setViewName("home");
		}
		else {
			String msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
			mav.addObject("msg", msg);
			mav.setViewName("alert");
		}
		return mav;
	}
	
	@GetMapping("/join")
	public String join() {
		return "common/join";
	}
	@PostMapping("/join")
	public ModelAndView join(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView("alert");
		String msg = null;
		int row = ps.join(inputData);
		if(row != 0) {
			msg = "회원가입 성공";
		}
		else {
			msg = "회원가입 실패";
		}
		mav.addObject("msg", msg);
		return mav;
	}
	
}
