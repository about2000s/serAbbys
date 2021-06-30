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
		return "index";
	}
	
	//개인회원 로그인
	@PostMapping("/personLogin")
	public ModelAndView personLogin(PersonDTO inputData, HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		PersonDTO login = ps.personLogin(inputData);//입력한 아이디 비밀번호를 바탕으로 회원객체를 반환한다
		ps.loginProcess(mav, login, session);//login 객체의 유무에 따라 로그인을 처리하는 메서드
		return mav;
	}
	
	//기업회원 로그인
	@PostMapping("/companyLogin")
	public ModelAndView companyLogin(PersonDTO inputData, HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		PersonDTO login = ps.companyLogin(inputData);//입력한 아이디 비밀번호를 바탕으로 회원객체를 반환한다
		ps.loginProcess(mav, login, session); //login 객체의 유무에 따라 로그인을 처리하는 메서드
		return mav;
	}
	
	//회원가입 폼으로 이동
	@GetMapping("/join")
	public String join() {
		return "common/join";
	}
	//회원가입 처리
	@PostMapping("/join")
	public ModelAndView join(PersonDTO inputData, String any, String address, String detailAddress) {
		ModelAndView mav = new ModelAndView("common/alert");
		
		ps.joinProcess(address, detailAddress, inputData, any);
		//주소 및 회사명 세팅
		
		int row = ps.join(inputData);
		String msg = null;
		String value = null;
		
		if(row != 0) {
			msg = "회원가입 성공";
			value = "joinSuccess";
		}
		else {
			msg = "회원가입 실패";
			value = "joinFail";
		}
		mav.addObject("msg", msg);
		mav.addObject("value", value);
		return mav;
	}
	
	//아이디 찾기 또는 비밀번호 재발급을 하기 위해 개인/기업 회원 여부를 따지는 페이지로 이동
	@GetMapping("/selectIndiComp")
	public ModelAndView selectIndiComp() {
		ModelAndView mav = new ModelAndView("common/selectIndiComp");
		return mav;
	}
	@PostMapping("/selectIndiComp")
	public ModelAndView selectIndiComp(String say, String person_check) {
		ModelAndView mav = new ModelAndView();
		// 개인회원/기업회원을 구분한 값과 id/pw 찾기 선택값을 전달받음
		// say = id or pw 구분
		// person_check = 개인회원/기업회원 구분
		if(say.equals("id,")) mav.setViewName("common/findId");
		if(say.equals("pw,")) mav.setViewName("common/rePw");
		mav.addObject("person_check", person_check);
		return mav;
	}
	
	//이메일 입력에 의한 아이디 찾기 데이터 받아와서 처리
	@PostMapping("/findIdByEmail")
	public ModelAndView findIdByEmail(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView("common/findResult");
		int row = ps.emailNameCheck(inputData);// 입력한 Email 값과 Name 값을 전달하여 일치하는 데이터의 유무를 파악
		
		String msg;
		if(row == 0) {	// 입력한 Email과 Name과 일치하는 데이터가 없는 경우
			msg = "이름 혹은 Email 주소가 잘못 입력되었습니다. 다시 확인해주세요";
		} else {	// 입력한 Email과 Name과 일치하는 데이터가 있는 경우
			String person_id = ps.findIdByEmail(inputData);
			// 입력한 Email과 Name값을 토대로 findIdByEmail을 통해 id값을 반환받음
			msg = "당신의 아이디는 [" + person_id + "] 입니다.";
		}
		mav.addObject("msg", msg);
		return mav;
	}
	
	//이메일 입력에 의한 비밀번호 재발급 데이터 받아와서 처리
	@PostMapping("/repwByEmail")
	public ModelAndView repwByEmail(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView("common/findResult");
		int row = ps.emailIdCheck(inputData);
		// 입력한 ID값과 Email값을 PersonService의 emailIdCheck으로 전달하여 일치하는 계정의 여부를 판단
		String msg;
		if(row == 0) {	// ID 값과 Email 값이 일치하는 정보가 없을 경우
			msg = "아이디 혹은 Email 주소가 잘못 입력되었습니다. 다시 확인해주세요";
		} else {	// ID 값과 Email 값이 일치하는 정보가 있을 경우
			String person_pw = ps.findPwByEmail(inputData);
			// PersonService의 findPwByEmail으로 입력값을 전달하여 해당 계정의 pw를 재설정하고 발급한 임시 비밀번호 6자리를 반환
			msg = "임시 비밀번호는 [" + person_pw + "] 입니다. 로그인 후 변경해주세요";
		}
		mav.addObject("msg", msg);
		return mav;
	}

	//마이페이지
	@GetMapping("/myPage")
	public ModelAndView myPage() {
		ModelAndView mav = new ModelAndView("common/myPage");
		String msg = "";
		mav.addObject("msg", msg);
		return mav;
	}
	
	//개인정보 수정 페이지로 이동
	@GetMapping("/updateInfo")
	public String updateInfo() {
		return "common/updateInfo";
	}
	
	//비밀번호 수정 페이지로 이동
	@GetMapping("/updatePw")
	public String updatePw() {
		return "common/updatePw";
	}
	
	//비밀번호 수정하기 위해 기존 비밀번호를 검증하는 절차
	@PostMapping("/updatePw")
	public ModelAndView updatePw(PersonDTO inputData) {
		ModelAndView mav = new ModelAndView();
		
		int row = ps.selectOneCheckIdPw(inputData);
		// 비밀번호 변경페이지에서 입력한 pw값과 본래 계정의 pw값을 비교
		if(row == 0){
			String msg = "비밀번호가 일치하지 않습니다";
			mav.addObject("msg", msg);
			mav.addObject("value", null);
			mav.setViewName("common/alert");
		}
		else {
			mav.setViewName("common/realUpdatePw");
		}
		return mav;
	}
	
	//비밀번호를 새로 변경하기
	@PostMapping("/pwUpdateResult")
	public ModelAndView pwUpdateResult(String person_pw, HttpSession session) {
		ModelAndView mav = new ModelAndView("common/alert");
		PersonDTO login = (PersonDTO)session.getAttribute("login");	// 로그인 된 session 값을 불러와서 PersonDTO로 저장
		login.setPerson_pw(person_pw);	// session 값의 pw를 입력받은 person_pw로 변경
		int row = ps.updatePw(login);	// pw가 변경된 PersonDTO 값을 전달하여 DB값을 Update시킴
		String msg = null;
		String value = null;
		if(row != 0) {
			msg = "비밀번호가 변경되었습니다.";
			value = "myPageUpdateSuccess";
			session.setAttribute("login", login);
		}
		mav.addObject("msg", msg);
		mav.addObject("value", value);
		return mav;
	}
	
	//아이디를 실시간으로 중복체크
	@GetMapping(value = "/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("person_id") String person_id) {
		return ps.idCheck(person_id);
	}
	
//	@GetMapping(value = "/emailCheck")
//	@ResponseBody
//	public int emailCheck(@RequestParam("person_email") String person_email) {
//		return ps.emailCheck(person_email);
//	}
	
	//이메일 변경
	@PostMapping("/replaceEmail")
	public ModelAndView emailUpdateResult(String newEmail, HttpSession session) {
		ModelAndView mav = new ModelAndView("common/alert");
		PersonDTO login = (PersonDTO)session.getAttribute("login");
		// 로그인 해놓은 session 값을 불러와 PersonDTO의 login객체에 저장
		login.setPerson_email(newEmail);
		// 입력받은 Email 값을 login객체의 값에 저장
		int row = ps.updateEmail(login);
		// 변경된 login 객체를 전달하여 DB의 값을 변경시킴
		String msg = null;
		String value = null;
		if(row != 0) {
			msg = "E-mail 변경이 완료되었습니다";
			value = "myPageUpdateSuccess";
		} else {
			msg = "E-mail 변경에 실패했습니다. 재시도해주세요";
		}
		session.setAttribute("login", login);
		mav.addObject("msg", msg);
		mav.addObject("value", value);
		return mav;
	}
	
	// 주소 변경
	@PostMapping("/replaceAddress")
	public ModelAndView addressUpdateResult(String address, String detailAddress, HttpSession session) {
		ModelAndView mav = new ModelAndView("common/alert");
		String realAddress = address + " " + detailAddress;
		// 입력한 주소지와 상세주소지의 값을 합쳐 실제 주소지의 값을 제작
		PersonDTO login = (PersonDTO)session.getAttribute("login");
		// 로그인 해놓은 session 값을 불러와 PersonDTO의 login객체에 저장
		login.setPerson_address(realAddress);
		// session으로 불러온 객체의 address 값을 입력받은 실제 주소지 값으로 변경
		int row = ps.updateAddress(login);
		// 변경된 객체를 PersonService의 updateAddress로 전달하여 DB값을 변경
		String msg = null;
		String value = null;
		if(row != 0) {
			msg = "주소지 변경이 완료되었습니다";
			value = "myPageUpdateSuccess";
		} else {
			msg = "주소지 변경에 실패했습니다. 재시도해주세요";
		}
		session.setAttribute("login", login);
		mav.addObject("value", value);
		mav.addObject("msg", msg);
		return mav;
	}
	
	// 유선전화 변경 및 추가
	@PostMapping("/replaceCall")
	public ModelAndView replaceCall(String newCall, HttpSession session) {
		ModelAndView mav = new ModelAndView("common/alert");
		PersonDTO login = (PersonDTO)session.getAttribute("login");
		// 로그인 해놓은 session 값을 불러와 PersonDTO의 login객체에 저장
		Boolean existsCall = null;	// 전화번호가 있는지 여부를 판단
		if(login.getPerson_call() != null) existsCall = true;	// 있을때
		if(login.getPerson_call() == null) existsCall = false;	// 없을때
		login.setPerson_call(newCall);	// 입력받은 전화번호 값을 login객체에 넣어 변경
		int row = ps.updateCall(login);	// 변경된 login객체를 PersonService의 updateCall로 전달하여 DB값 변경
		String msg = null;
		String value = null;
		if(row !=0) {
			if(existsCall) {	// 유선전화가 있었을 경우
				msg = "유선전화가 변경되었습니다";
			}
			else {	// 유선전화가 없었을 경우
				msg = "유선전화가 추가되었습니다";
			}
			value = "myPageUpdateSuccess";
		}else {
			msg = "실패";
		}
		session.setAttribute("login", login);
		mav.addObject("msg", msg);
		mav.addObject("value", value);
		return mav;
	}
	
	// 팩스번호 변경 및 추가
	@PostMapping("/replaceFax")
	public ModelAndView replaceFax(String newFax, HttpSession session) {
		ModelAndView mav = new ModelAndView("common/alert");
		PersonDTO login = (PersonDTO)session.getAttribute("login");
		// 로그인 해놓은 session 값을 불러와 PersonDTO의 login객체에 저장
		Boolean existsFax = null;	// 팩스번호가 있는지 여부를 판단
		if(login.getPerson_fax() != null) existsFax = true;		// 있을때
		if(login.getPerson_fax() == null) existsFax = false;	// 없을때
		login.setPerson_fax(newFax);	// 입력받은 전화번호 값을 login객체에 넣어 변경
		int row = ps.updateFax(login);	// 변경된 login객체를 PersonService의 updateFax로 전달하여 DB값 변경
		String msg = null;
		String value = null;
		if(row !=0) {
			if(existsFax) {	// 팩스번호가 있었을 경우
				msg = "팩스주소가 변경되었습니다";
			}
			else {	// 팩스번호가 없었을 경우
				msg = "팩스주소가 추가되었습니다";
			}
			value = "myPageUpdateSuccess";
		}else {
			msg = "실패";
		}
		session.setAttribute("login", login);
		mav.addObject("msg", msg);
		mav.addObject("value", value);
		return mav;
	}
	
	//휴대전화 변경
	@PostMapping("/replacePhone")
	public ModelAndView replacePhone(String newPhone, HttpSession session) {
		ModelAndView mav = new ModelAndView("common/alert");
		PersonDTO login = (PersonDTO)session.getAttribute("login");
		login.setPerson_phone(newPhone);
		int row = ps.updatePhone(login);
		String msg = null;
		String value = null;
		if(row != 0) {
			msg = "휴대전화가 변경되었습니다";
			value = "myPageUpdateSuccess";
		}
		else {
			msg = "휴대전화 변경 실패";
		}
		session.setAttribute("login", login);
		mav.addObject("msg", msg);
		mav.addObject("value", value);
		
		return mav;
	}
}