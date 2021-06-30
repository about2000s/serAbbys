package com.itbank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.dto.ReserveDTO;
import com.itbank.dto.CustMemoDTO;
import com.itbank.dto.PersonDTO;
import com.itbank.dto.ReserveTimeDTO;
import com.itbank.service.PersonService;
import com.itbank.service.ReserveService;

@Controller
@RequestMapping("/reserve")
public class ReserveController {
	
	@Autowired ReserveService rs;
	@Autowired PersonService ps;
	
	@GetMapping("/statusList")
	public ModelAndView statusList(String reserve_status, String type, String keyword, int page, HttpSession session) {
		ModelAndView mav = new ModelAndView("/reserve/list");
		System.out.println("reserve_status: " + reserve_status);
		System.out.println("type: " + type);
		HashMap<String, Object> map = rs.job(reserve_status, type, keyword, page, session);//서비스글에 대한 페이징을 처리하는 메서드
		
		List<String> statusList = rs.statusList();//처리상태값을 리스트에 담아오는 메서드
		mav.addObject("map", map);
		mav.addObject("statusList", statusList);
		return mav;
	}
	
	//기사가 서비스 글 작성하는 폼으로 이동
	@GetMapping("/reserve_new_for_engi")
	public ModelAndView reserveNew(HttpSession session) {
		ModelAndView mav = new ModelAndView("/reserve/reserve_new_for_engi");
		int hourCount = 8;
		int dayCount = 14;
		
		List<PersonDTO> engiList = new ArrayList<PersonDTO>();//기사의 아이디를 담는 리스트 선언 및 초기화
		
		PersonDTO login = (PersonDTO)session.getAttribute("login");
		
		engiList.add(login);//기사 리스트에 세션에 저장된 아이디를 담는다.
		
		List<Integer> dayList = rs.dayList(dayCount);//날짜 리스트를 담는 메서드
		List<HashMap<String, Object>> reserveTimeList = rs.reserveTimeList(engiList, hourCount, dayCount);
		//기사에 따른 예약가능한 예약시간을 담아두는 메서드
		
		mav.addObject("engiList", engiList);
		mav.addObject("dayList", dayList);
		mav.addObject("reserveTimeList", reserveTimeList);
		return mav;
	}
	
	//기사가 서비스 글 작성
	@PostMapping("/reserve_new_for_engi")
	public ModelAndView reserve(ReserveDTO reserveDTO, ReserveTimeDTO reserveTimeDTO, String address, String detailAddress) {
		ModelAndView mav = new ModelAndView("/reserve/alert");
		
		rs.addressAndTitleSetting(reserveDTO, reserveTimeDTO, address, detailAddress);
		
		int row1 = rs.reserve(reserveDTO);//예약하는 메서드
		int reserve_idx = rs.selectMaxIdxInReserve(reserveDTO.getReserve_engiId());//막 예약한 글의 idx를 불러오는 메서드
		reserveTimeDTO.setReserveTime_idx(reserve_idx);//예약시간DTO의 idx에 예약글의 idx를 세팅하는 코드
		int row2 = rs.insertReserveTime(reserveTimeDTO);//예약시간을 삽입하는 메서드
		
		String msg = null;
		String value = null;
		if(row1 == 1 && row2 == 1) {
			msg = "예약 성공";
			mav.addObject("reserve_idx", reserve_idx);
			value = "reserveSuccess";
		}
		else {
			msg = "예약 실패";
			value = "reserveFail";
		}
		mav.addObject("msg", msg);
		mav.addObject("value", value);
		return mav;
	}
	
	
	//글 읽기/${dto.reserve_idx}?page=${map.page}&type=${map.type}&keyword=${map.keyword}&reserve_status=${map.reserve_status}
	@GetMapping("/read/{reserve_idx}")
	public ModelAndView read(@PathVariable int reserve_idx, @RequestParam HashMap<String, Object> map) {
		ModelAndView mav = new ModelAndView("/reserve/read");
		
		Boolean flag = rs.alreadyReviewWrite(reserve_idx);//flag==true라면 리뷰글이 작성된 상태
		List<CustMemoDTO> list = rs.custMemoList(reserve_idx);
		int row = rs.reserveViewCountPlus(reserve_idx);//예약글의 조회수 증가시키는 메서드
		ReserveDTO dto = rs.selectOne(reserve_idx);//idx값을 통해 예약글 하나를 받아오는 메서드
		mav.addObject("list", list);
		
		HashMap<String, String> btnList = rs.statusChangeBtn(dto);//현재 상태에 따라 바꿀 상태값의 버튼 이름 정하는 메서드
		
		mav.addObject("btnList", btnList);
		mav.addObject("ment", "(으)로 처리 상태 변경하기");
		mav.addObject("dto", dto);
		mav.addObject("map", map);
		mav.addObject("flag", flag);
		return mav;
	}
	//미완성. 아직 더 봐야 해
	@GetMapping("statusChange/{reserve_idx}")
	public ModelAndView statusChange(@PathVariable int reserve_idx, String nextStatus) {
		ModelAndView mav = new ModelAndView("redirect:/reserve/read/" + reserve_idx + "?page=1");
		
		ReserveDTO dto = rs.selectOne(reserve_idx);
		
		rs.setBtn(dto, nextStatus);
		int row = rs.statusChange(dto);
		return mav;
	}
	
	//예약시간 변경하는 폼으로 이동
	@GetMapping("/changeReserveTime/{reserve_idx}")
	public ModelAndView changeReserveTime(@PathVariable int reserve_idx) {
		ModelAndView mav = new ModelAndView("reserve/changeReserveTime");
		int hourCount = 8;
		int dayCount = 14;
		PersonDTO engi = rs.selectEngiOneByIdx(reserve_idx);
		List<PersonDTO> engiList = new ArrayList<PersonDTO>();
		engiList.add(engi);
		
		List<Integer> dayList = rs.dayList(dayCount);
		
		List<HashMap<String, Object>> reserveTimeList = rs.reserveTimeList(engiList, hourCount, dayCount);
		
		mav.addObject("engiList", engiList);
		mav.addObject("dayList", dayList);
		mav.addObject("reserveTimeList", reserveTimeList);
		return mav;
	}
	
	//예약시간 변경
	@PostMapping("/changeReserveTime/{reserve_idx}")
	public ModelAndView changeReserveTime(@PathVariable int reserve_idx, ReserveTimeDTO reserveTimeDTO) {
		ModelAndView mav = new ModelAndView("reserve/alert");
		ReserveDTO reserveDTO = rs.selectOne(reserve_idx);
		
		rs.monthAndCustIdSetForReserve(reserveDTO, reserveTimeDTO);
		rs.reserveTitleSetting(reserveDTO, reserveTimeDTO);
		
		int row1 = rs.reserveTitleChange(reserveDTO);
		
		reserveTimeDTO.setReserveTime_idx(reserve_idx);
		int row2 = rs.changeReserveTime(reserveTimeDTO);
		String msg = null;
		String value = null;
		if(row1 != 0 && row2 != 0) {
			msg = "예약시간 변경 성공";
			mav.addObject("reserve_idx", reserve_idx);
			value = "reserveTimeChangeSuccess";
		}
		else {
			msg = "예약시간 변경 실패";
			value = "reserveTimeChangeFail";
		}
		mav.addObject("msg", msg);
		mav.addObject("value", value);
		return mav;
	}

	//예약글 수정하는 폼으로 이동
	@GetMapping("/modify/{reserve_idx}")
	public ModelAndView modify(@PathVariable int reserve_idx, @RequestParam HashMap<String, Object> map) {
		ModelAndView mav = new ModelAndView("reserve/modify");
		ReserveDTO dto = rs.selectOne(reserve_idx);
		mav.addObject("dto", dto);
		mav.addObject("map", map);
		return mav;
	}
	
	//예약글 수정하기
	@PostMapping("/modify/{reserve_idx}")
	public String modify(@PathVariable int reserve_idx, ReserveDTO inputData, @RequestParam HashMap<String, Object> map) {
		String path = "redirect:/reserve/read/" + reserve_idx + 
				"?page=" + map.get("page") + "&type=" + map.get("type")+ 
				"&keyword=" + map.get("keyword") + "&reserve_status=" + map.get("reserve_status");
		ModelAndView mav = new ModelAndView(path);
		int row = rs.modify(inputData);
		return path;
	}
	
	//예약 취소
	@GetMapping("/delete/{reserve_idx}")
	public ModelAndView delete(@PathVariable int reserve_idx) {
		ModelAndView mav = new ModelAndView("/reserve/alert");
		int row2 = rs.deleteReserveTime(reserve_idx);
		int row1 = rs.deleteReserve(reserve_idx);
		String msg;
		String value = null;
		if(row1 != 0 && row2 != 0) {
			msg = "예약이 취소됨";
			value = "reserveCancel";
		}
		else {
			msg = "예약취소 실패";
			value = "reserveCancelFail";
		}
		mav.addObject("msg", msg);
		mav.addObject("value", value);
		return mav;
	}

	//고객이 서비스 글 쓰기 폼으로 이동
	@GetMapping("/reserve_new_for_cust")
	public ModelAndView reserve_new_for_cust() {
		ModelAndView mav = new ModelAndView("/reserve/reserve_new_for_cust");
		int hourCount = 8;
		int dayCount = 14;
		
		List<PersonDTO> engiList = rs.selectEngiAll();
		List<Integer> dayList = rs.dayList(dayCount);
		List<HashMap<String, Object>> reserveTimeList = rs.reserveTimeList(engiList, hourCount, dayCount);
		
		mav.addObject("engiList", engiList);
		mav.addObject("dayList", dayList);
		mav.addObject("reserveTimeList", reserveTimeList);
		return mav;
	}
	
	// 고객이 서비스 글 쓰기
	@PostMapping("/reserve_new_for_cust")
	public ModelAndView reserve_new_for_cust(ReserveDTO reserveDTO, ReserveTimeDTO reserveTimeDTO) throws Exception{
		ModelAndView mav = new ModelAndView("reserve/alert");
		PersonDTO engi = rs.selectOneById(reserveTimeDTO.getReserveTime_engiId());
		
		reserveDTO.setReserve_engiId(reserveTimeDTO.getReserveTime_engiId());
		reserveDTO.setReserve_compBelong(engi.getPerson_belong());
		
		rs.monthAndCustIdSetForReserve(reserveDTO, reserveTimeDTO);
		rs.reserveTitleSetting(reserveDTO, reserveTimeDTO);
		
		String title = reserveDTO.getReserve_title();
		String msg1 = ps.any(reserveDTO.getReserve_phone(), title);
		String msg2 = ps.any(engi.getPerson_phone(), title);
		
		int row1 = rs.reserve(reserveDTO);
		int reserve_idx = rs.selectMaxIdxInReserve(reserveDTO.getReserve_engiId());
		reserveTimeDTO.setReserveTime_idx(reserve_idx);
		int row2 = rs.insertReserveTime(reserveTimeDTO);
		
		String msg = null;
		String value = null;
		if(row1 == 1 && row2 == 1) {
			msg = "예약 성공";
			value = "reserveSuccess";
			mav.addObject("reserve_idx", reserve_idx);
		}
		else {
			msg = "예약 실패";
			value = "reserveFail";
		}
		mav.addObject("msg", msg);
		mav.addObject("value", value);
		return mav;
	}
	
}