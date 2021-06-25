package com.itbank.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
		System.out.println("fds");
		ModelAndView mav = new ModelAndView();
		PersonDTO login = ps.personLogin(inputData);
		if(login != null) {
			System.out.println("여기는 로그인 성공");
			session.setAttribute("login", login);
			mav.setViewName("home");
		}
		else {
			System.out.println("여기는 로그인 실패");
			String msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
			String value = "loginFail";
			mav.addObject("msg", msg);
			mav.addObject("value", value);
			mav.setViewName("common/alert");
		}
		return mav;
	}
	
	//기업회원 로그인
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
			mav.addObject("link", "history.go(-1)");
			mav.setViewName("common/alert");
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
		ModelAndView mav = new ModelAndView("common/alert");
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
			mav.addObject("link", "login");
		}
		else {
			msg = "회원가입 실패";
			mav.addObject("link", "history.go(-1)");
		}
		mav.addObject("msg", msg);
		return mav;
	}
	
	@GetMapping("/selectIndiComp")
	public ModelAndView selectIndiComp() {
		ModelAndView mav = new ModelAndView("common/selectIndiComp");
		return mav;
	}
	@PostMapping("/selectIndiComp")
	public ModelAndView selectIndiComp(String say, String person_check) {
		System.out.println("say: " + say);
		System.out.println("person_check: " + person_check);
		ModelAndView mav = new ModelAndView();
		if(say.equals("id,")) mav.setViewName("common/findId");
		if(say.equals("pw,")) mav.setViewName("common/rePw");
		mav.addObject("person_check", person_check);
		return mav;
	}
	
	//폰번호 입력에 의한 아이디 찾기 데이터 받아와서 처리
	@PostMapping("/findIdByPhone")
	public ModelAndView findIdByPhone(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView("common/findResult");
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
		ModelAndView mav = new ModelAndView("common/findResult");
		int row = ps.emailNameCheck(inputData);
		String msg;
		if(row == 0) {
			msg = "이름 혹은 Email 주소가 잘못 입력되었습니다. 다시 확인해주세요";
		} else {
			String person_id = ps.findIdByEmail(inputData);
			msg = "당신의 아이디는 [" + person_id + "] 입니다.";
		}
		mav.addObject("msg", msg);
		return mav;
	}
	
//	//비밀번호 재발급 폼으로 이동
//	@GetMapping("/rePw")
//	public String rePw() {
//		return "common/rePw";
//	}
	
	//폰번호 입력에 의한 비밀번호 재발급 데이터 받아와서 처리
	@PostMapping("/repwByPhone")
	public ModelAndView repwByPhone(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView("common/findResult");
		String repw = ps.repwByPhone(inputData);
		String msg = "임시 발급받은 비밀번호는 [" + repw + "] 입니다.";
		mav.addObject("msg", msg);
		return mav;
	}
	
	//이메일 입력에 의한 비밀번호 재발급 데이터 받아와서 처리
	@PostMapping("/repwByEmail")
	public ModelAndView repwByEmail(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView("common/findResult");
		int row = ps.emailIdCheck(inputData);
		String msg;
		if(row == 0) {
			msg = "아이디 혹은 Email 주소가 잘못 입력되었습니다. 다시 확인해주세요";
		} else {
			String person_pw = ps.findPwByEmail(inputData);
			msg = "임시 비밀번호는 [" + person_pw + "] 입니다. 로그인 후 변경해주세요";
		}
		mav.addObject("msg", msg);
		return mav;
	}

	@GetMapping("/myPage")
	public ModelAndView myPage() {
		ModelAndView mav = new ModelAndView("common/myPage");
		String msg = "";
		mav.addObject("msg", msg);
		return mav;
	}
	
	@GetMapping("/updateInfo")
	public String updateInfo() {
		return "common/updateInfo";
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
			mav.addObject("link", "history.go(-1)");
			mav.setViewName("common/alert");
		}
		return mav;
	}
	
	@PostMapping("/pwUpdateResult")
	public ModelAndView pwUpdateResult(PersonDTO inputData, HttpSession session) {
		ModelAndView mav = new ModelAndView("common/alert");
		System.out.println("여긴 컨트롤러 : " + inputData.getPerson_id());
		int row = ps.updatePw(inputData);
		String msg;
		if(row != 0) {
			System.out.println("변경 성공");
			msg = "비밀번호가 변경되었습니다.";
			PersonDTO login = ps.selectOneById(inputData.getPerson_id());
			session.setAttribute("login", login);
			mav.addObject("link", "myPage");
		} else {
			msg = "비밀번호 변경에 실패했습니다. 다시 시도해주세요";
		}
		mav.addObject("msg", msg);
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
	
	@PostMapping("/replaceEmail")
	public ModelAndView emailUpdateResult(@RequestParam String replaceEmail, String login_id, HttpSession session) {
		ModelAndView mav = new ModelAndView("common/myPage");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("login_id", login_id);
		map.put("replaceEmail", replaceEmail);
		int row = ps.updateEmail(map);
		String msg = null;
		if(row != 0) {
			msg = "E-mail 변경이 완료되었습니다";
			PersonDTO login = ps.selectOneById(login_id);
			session.setAttribute("login", login);
		} else {
			msg = "E-mail 변경에 실패했습니다. 재시도해주세요";
		}
		mav.addObject("msg", msg);
		return mav;
	}
	
	
	@PostMapping("replaceAddress")
	public ModelAndView addressUpdateResult(String address, String detailAddress, String login_id, HttpSession session) {
		ModelAndView mav = new ModelAndView("common/myPage");
		String realAddress = address + " " + detailAddress;
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("login_id", login_id);
		map.put("realAddress", realAddress);
		int row = ps.updateAddress(map);
		String msg = null;
		if(row != 0) {
			msg = "주소지 변경이 완료되었습니다";
		} else {
			msg = "주소지 변경에 실패했습니다. 재시도해주세요";
		}
		PersonDTO login = ps.selectOneById(login_id);
		session.setAttribute("login", login);
		mav.addObject("msg", msg);
		return mav;
	}
}