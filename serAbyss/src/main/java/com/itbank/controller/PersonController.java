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
		System.out.println("fds");
		ModelAndView mav = new ModelAndView("index");
		PersonDTO login = ps.personLogin(inputData);
		// PersonService의 personLogin으로 inputData를 넘겨 일치여부 확인.
		// 일치하는 값이 있다면 login에 해당 정보가 들어가게 되고, 없다면 null이 들어가게 됨
		if(login != null) {	// personLogin을 통해 넘어온 PersonDTO가 있을 경우
			System.out.println("여기는 로그인 성공");
			session.setAttribute("login", login);
			// session으로 login을 등록하여 로그인 정보를 저장
			mav.setViewName("index");
		}
		else {
			System.out.println("여기는 로그인 실패");
			String msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
			mav.addObject("msg", msg);
			// 등록한 메시지 msg를 저장하여 alert.jsp로 전달
			mav.setViewName("common/alert");
		}
		return mav;
	}
	
	//기업회원 로그인
	@PostMapping("/companyLogin")
	public ModelAndView companyLogin(PersonDTO inputData, HttpSession session) {
		System.out.println("apple");
		ModelAndView mav = new ModelAndView();
		PersonDTO login = ps.companyLogin(inputData);
		// 기업회원의 login 정보값을 PersonService로 전달.
		// 일반 회원 로그인과 이후 상황은 동일
		if(login != null) {
			session.setAttribute("login", login);
			// session으로 login을 등록하여 로그인 정보를 저장
			mav.setViewName("index");
		}
		else {
			String msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
			mav.addObject("msg", msg);
			mav.addObject("value", "loginFail");
			// 등록한 메시지 msg를 저장하여 alert.jsp로 전달
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
		// 넘겨받은 기본주소 + 상세주소를 합쳐서 완성된 주소를 저장
		String fullAddress = address + " " + detailAddress;
		// 입력받은 inputData의 주소를 위에서 완성한 주소로 수정
		inputData.setPerson_address(fullAddress);
		ModelAndView mav = new ModelAndView("common/alert");
		if(any != null) {
			if(any.equals("comp")) {//회사대표계정 회원가입시 진행됨.
				inputData.setPerson_belong(inputData.getPerson_belong().split(",")[0]);
				// 가입 조건의 회사이름을 가져와서 belong으로 세팅
				CompDTO comp = new CompDTO(inputData.getPerson_belong(), fullAddress);
				// 입력값과 합쳐진 완성된 주소값을 통해 CompDTO 객체 생성
				int row2 = ps.companyAdd(comp);
				// 생성된 객체를 PersonService로 넘겨 DB에 회사정보를 추가시킴
			}
			if(any.equals("empl")) {//회사직원 가입시 진행됨
				inputData.setPerson_belong(inputData.getPerson_belong().split(",")[1]);
				// 가입 조건에서 선택한 회사이름을 가져와서 belong으로 세팅
			}
		}
		String msg = null;
		String value = null;
		int row = ps.join(inputData);
		
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
	
	@GetMapping("/selectIndiComp")
	public ModelAndView selectIndiComp() {
		ModelAndView mav = new ModelAndView("common/selectIndiComp");
		return mav;
	}
	@PostMapping("/selectIndiComp")
	public ModelAndView selectIndiComp(String say, String person_check) {
		// 개인회원/기업회원을 구분한 값과 id/pw 찾기 선택값을 전달받음
		// say = id or pw 찾기 구분
		// person_check = 개인회원/기업회원 구분
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
		// 입력한 Email 값과 Name 값을 전달하여 일치하는 데이터의 유무를 파악
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
		// 입력한 정보값을 넘기고 PersonService의 repwByPhone를 통해 해당 계정의 pw를 재설정하고 임시로 발급한 비밀번호 6자리를 반환
		String msg = "임시 발급받은 비밀번호는 [" + repw + "] 입니다.";
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
	
	@PostMapping("/pwUpdateResult")
	public ModelAndView pwUpdateResult(String person_pw, HttpSession session) {
		ModelAndView mav = new ModelAndView("common/alert");
		PersonDTO login = (PersonDTO)session.getAttribute("login");	// 로그인 된 session 값을 불러와서 PersonDTO로 저장
		login.setPerson_pw(person_pw);	// session 값의 pw를 입력받은 person_pw로 변경
		int row = ps.updatePw(login);	// pw가 변경된 PersonDTO 값을 전달하여 DB값을 Update시킴
		String msg;
		String value=null;
		if(row != 0) {
			System.out.println("변경 성공");
			msg = "비밀번호가 변경되었습니다.";
			value = "myPageUpdateSuccess";
//			PersonDTO login = ps.selectOneById(inputData.getPerson_id());
			session.setAttribute("login", login);
		} else {
			msg = "비밀번호 변경에 실패했습니다. 다시 시도해주세요";
		}
		mav.addObject("value", value);
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
	@PostMapping("replaceAddress")
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
	@PostMapping("replaceCall")
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
	@PostMapping("replaceFax")
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
}