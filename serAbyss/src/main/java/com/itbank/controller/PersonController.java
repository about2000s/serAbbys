package com.itbank.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.dto.CompDTO;
//
import com.itbank.dto.PersonDTO;
import com.itbank.service.PersonService;

@Controller
@RequestMapping("/common")
public class PersonController {
	
	@Autowired private PersonService ps;
	
	//로그인 페이지로 이동하기.
	@GetMapping("/login")
	public String login() {
		return "common/login";
	}
	
	//로그아웃 처리하기
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "home";
	}
	
	//개인회원 로그인
	@PostMapping("/personLogin")
	public ModelAndView personLogin(PersonDTO inputData, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		PersonDTO login = ps.personLogin(inputData);
		if(login != null) {
			session.setAttribute("login", login);
			mav.setViewName("home");
		}
		else {
			String msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
			mav.addObject("msg", msg);
//			mav.setViewName("alert");
		}
		return mav;
	}
	
	//기업회원 로그인
	@PostMapping("/companyLogin")
	public ModelAndView companyLogin(PersonDTO inputData, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		PersonDTO login = ps.companyLogin(inputData);
		
		if(login != null) {
			boolean iamCeo = ps.iamCeo(login);
			session.setAttribute("login", login);
			session.setAttribute("iamCeo", iamCeo);
			mav.setViewName("home");
		}
		else {
			String msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
			mav.addObject("msg", msg);
//			mav.setViewName("alert");
		}
		return mav;
	}
	
	//회원가입 폼으로 이동
	@GetMapping("/join")
	public String join() {
		return "common/join";
	}
//	@RequestParam HashMap<String, String> map
	//회원가입 처리
	@PostMapping("/join")
	public ModelAndView join(PersonDTO inputData, String any, String address, String detailAddress) {
		String fullAddress = address + " " + detailAddress;
		inputData.setPerson_address(fullAddress);
		ModelAndView mav = new ModelAndView("alert");
		if(any != null) {
			if(any.equals("comp")) {//회사대표계정 회원가입시 진행됨.
				inputData.setPerson_belong(inputData.getPerson_belong().split(",")[0]);
				CompDTO comp = new CompDTO(inputData.getPerson_belong(), fullAddress);
				int row2 = ps.companyAdd(comp);
			}
			if(any.equals("empl")) {//회사직원 가입시 진행됨
				inputData.setPerson_belong(inputData.getPerson_belong().split(",")[1]);
			}
		}
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
	
	//아이디 찾기 폼으로 이동
	@GetMapping("/findId")
	public String findId() {
		return "common/findId";
	}
	
	//폰번호 입력에 의한 아이디 찾기 데이터 받아와서 처리
	@PostMapping("/findIdByPhone")
	public ModelAndView findIdByPhone(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView("common/findIdResult");
		String person_id = ps.findIdByPhone(inputData);
		if(person_id != null) {
			String msg = "당신의 아이디는 [" + person_id + "] 입니다.";
			mav.addObject("msg", msg);
		}
		return mav;
	}
	
	//이메일 입력에 의한 아이디 찾기 데이터 받아와서 처리
	@PostMapping("/findIdByEmail")
	public ModelAndView findIdByEmail(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView("common/findIdResult");
		String person_id = ps.findIdByEmail(inputData);
		String msg = "당신의 아이디는 [" + person_id + "] 입니다.";
		mav.addObject("msg", msg);
		return mav;
	}
	
	//비밀번호 재발급 폼으로 이동
	@GetMapping("/rePw")
	public String rePw() {
		return "common/rePw";
	}
	
	//폰번호 입력에 의한 비밀번호 재발급 데이터 받아와서 처리
	@PostMapping("/repwByPhone")
	public ModelAndView repwByPhone(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView("common/repwResult");
		String repw = ps.repwByPhone(inputData);
		String msg = "임시 발급받은 비밀번호는 [" + repw + "] 입니다.";
		mav.addObject("msg", msg);
		return mav;
	}
	
	//이메일 입력에 의한 비밀번호 재발급 데이터 받아와서 처리
	@PostMapping("/repwByEmail")
	public ModelAndView repwByEmail(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView("common/repwResult");
		String repw = ps.repwByEmail(inputData);
		String msg = "임시 발급받은 비밀번호는 [" + repw + "] 입니다.";
		mav.addObject("msg", msg);
		return mav;
	}

	@GetMapping("/myPage")
	public String myPage() {
		return "common/myPage";
	}
	
	@GetMapping("/updateInfo")
	public String updateInfo() {
		return "common/updateInfo";
	}
	
	@PostMapping("/updateInfo")
	public ModelAndView updateInfo(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@GetMapping("/updatePw")
	public String updatePw() {
		return "common/updatePw";
	}
	@PostMapping("/updatePw")
	public ModelAndView updatePw(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView();
		System.out.println(inputData.getPerson_id());
		System.out.println(inputData.getPerson_pw());
		System.out.println(inputData.getPerson_check());
		
		int row = ps.selectOneCheckIdPw(inputData);
		if(row != 0) {
			mav.setViewName("common/realUpdatePw");
		}
		else {
			String msg = "비밀번호가 일치하지 않습니다";
			mav.addObject("msg", msg);
//			mav.setViewName("alert");
		}
		return mav;
	}
	
	@PostMapping("/pwUpdateResult")
	public ModelAndView pwUpdateResult(PersonDTO inputData, HttpSession session) {
		ModelAndView mav = new ModelAndView("alert");
		int row = ps.updatePw(inputData);
		session.invalidate();//비밀번호가 변경되었으므로 세션을 끊고 다시 로그인하게 한다.
		String msg = "비밀번호가 변경되었습니다. 다시 로그인하세요";
//		mav.addObject("msg", msg);
		return mav;
	}
	
	@GetMapping(value = "/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("person_id") String person_id) {
		return ps.idCheck(person_id);
	}
	
	@GetMapping(value = "/emailCheck")
	@ResponseBody
	public int emailCheck(@RequestParam("person_email") String person_email) {
		return ps.emailCheck(person_email);
	}
	
	@GetMapping("timePlus")
	public void timePlus() {
		ps.timePlus();
	}
}







