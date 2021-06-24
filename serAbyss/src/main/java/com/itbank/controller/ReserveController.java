package com.itbank.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

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
import com.itbank.service.ReserveService;
import com.itbank.service.Paging;

@Controller
@RequestMapping("/reserve")
public class ReserveController {
	
	@Autowired ReserveService rs;
	
	String[] status_list = {"등록완료", "접수완료", "fixing", "fixed", "payed", "cancleRegister", "cancleComplete", "success"};
	
	@GetMapping("/statusList")
	public ModelAndView statusList(String reserve_status, String type, String keyword, int page, HttpSession session) {
		ModelAndView mav = new ModelAndView("/reserve/list");
		HashMap<String, Object> map = rs.job(reserve_status, type, keyword, page, session);
		mav.addObject("map", map);
		return mav;
	}
	
	//기사가 서비스 글 작성하는 폼으로 이동
	@GetMapping("/reserve_new_for_engi")
	public ModelAndView reserveNew(HttpSession session) {
		ModelAndView mav = new ModelAndView("/reserve/reserve_new_for_engi");
		int hourCount = 8;
		int dayCount = 14;
		
		List<String> engiIdList = new ArrayList<String>();
		engiIdList.add(((PersonDTO)session.getAttribute("login")).getPerson_id());
		
		List<Integer> dayList = rs.dayList(dayCount);
		List<HashMap<String, Object>> reserveList = rs.reserveList(engiIdList, hourCount, dayCount);
		
		mav.addObject("engiIdList", engiIdList);
		mav.addObject("dayList", dayList);
		mav.addObject("reserveList", reserveList);
		return mav;
	}
	
	//기사가 서비스 글 작성
	@PostMapping("/reserve_new_for_engi")
	public ModelAndView reserve(ReserveDTO reserveDTO, ReserveTimeDTO reserveTimeDTO, String address, String detailAddress) {
		String fullAddress = address + " " + detailAddress;
		reserveDTO.setReserve_address(fullAddress);
		
		rs.monthAndCustIdSetForReserve(reserveDTO, reserveTimeDTO);
		
		ModelAndView mav = new ModelAndView("/reserve/reserve_result");
		String msg;
		int row1 = rs.reserve(reserveDTO);
		int row2 = rs.insertReserve(reserveTimeDTO);
		if(row1 == 1 && row2 == 1) {
			msg = "주문이 접수되었습니다";
		}
		else {
			msg = "주문 접수에 실패했습니다. 다시 시도해주세요";
		}
		mav.addObject("msg", msg);
		mav.addObject("value", "reserve_new");
		return mav;
	}
	
	
	//글 읽기/${dto.reserve_idx}?page=${map.page}&type=${map.type}&keyword=${map.keyword}&reserve_status=${map.reserve_status}
	@GetMapping("/read/{reserve_idx}")
	public ModelAndView read(@PathVariable int reserve_idx, @RequestParam HashMap<String, Object> map) {
		Boolean flag = rs.alreadyReviewWrite(reserve_idx);//flag==true라면 리뷰글이 작성된 상태
		List<CustMemoDTO> list = rs.custMemoList(reserve_idx);
		System.out.println("리스트 출력확인");
		System.out.println(list.toString());
		System.out.println("flag: " + flag);
		ModelAndView mav = new ModelAndView("/reserve/read");
		ReserveDTO dto = rs.selectOne(reserve_idx);
		mav.addObject("list", list);
		mav.addObject("dto", dto);
		mav.addObject("map", map);
		mav.addObject("flag", flag);
		return mav;
	}

	//글 수정
	@GetMapping("/modify/{reserve_idx}")
	public ModelAndView modify(@PathVariable int reserve_idx, @RequestParam HashMap<String, Object> map) {
		System.out.println("modify");
		ModelAndView mav = new ModelAndView("reserve/modify");
		ReserveDTO dto = rs.selectOne(reserve_idx);
		mav.addObject("dto", dto);
		mav.addObject("map", map);
		return mav;
	}
	
	//"redirect:/board/read/" + dto.getIdx() + "/?page=1";
	@PostMapping("/modify/{reserve_idx}")
	public String modify(@PathVariable int reserve_idx, ReserveDTO inputData, @RequestParam HashMap<String, Object> map) {
		String path = "redirect:/reserve/read/" + reserve_idx + 
				"?page=" + map.get("page") + "&type=" + map.get("type")+ 
				"&keyword=" + map.get("keyword") + "&reserve_status=" + map.get("reserve_status");
		System.out.println(path);
		ModelAndView mav = new ModelAndView(path);
//		int row = rs.modify(inputData);
		String msg = "글 수정 성공";
		return path;
	}
	
	//글 삭제
	@GetMapping("/delete/{idx}")
	public ModelAndView delete(@PathVariable int idx) {
		int row = rs.delete(idx);
		String msg;
		if(row != 0) {
			msg = "삭제가 완료되었습니다";
		}
		else {
			msg = "삭제에 실패했습니다. 다시 시도해주세요";
		}
		ModelAndView mav = new ModelAndView("/reserve/reserve_result");
		mav.addObject("msg", msg);
		mav.addObject("value", "delete");
		return mav;
	}

	//고객이 서비스 글 쓰기 폼으로 이동
	@GetMapping("/reserve_new_for_cust")
	public ModelAndView reserve_new_for_cust() {
		ModelAndView mav = new ModelAndView("/reserve/reserve_new_for_cust");
		
		int hourCount = 8;
		int dayCount = 14;
		
		List<String> engiIdList = rs.selectEngiIdAll();
		List<Integer> dayList = rs.dayList(dayCount);
		
		List<HashMap<String, Object>> reserveList = rs.reserveList(engiIdList, hourCount, dayCount);
		
		mav.addObject("engiIdList", engiIdList);
		mav.addObject("dayList", dayList);
		mav.addObject("reserveList", reserveList);
		return mav;
	}
	
	// 고객이 서비스 글 쓰기
	@PostMapping("/reserve_new_for_cust")
	public ModelAndView reserve_new_for_cust(ReserveDTO reserveDTO, ReserveTimeDTO reserveTimeDTO){
		ModelAndView mav = new ModelAndView();
		System.out.println("주소: " + reserveDTO.getReserve_address());
		PersonDTO cust = rs.selectOneById(reserveDTO.getReserve_custId());
		PersonDTO engi = rs.selectOneById(reserveDTO.getReserve_engiId());
		
		reserveDTO.setReserve_status("등록완료");
//		reserveDTO.setReserve_address(cust.getPerson_address());
		reserveDTO.setReserve_engiId(reserveDTO.getReserve_engiId());
		reserveDTO.setReserve_compBelong(engi.getPerson_belong());
		
		rs.monthAndCustIdSetForReserve(reserveDTO, reserveTimeDTO);
		
		int row1 = rs.reserve(reserveDTO);
		int row2 = rs.insertReserve(reserveTimeDTO);
		String msg = null;
		if(row1 == 1 && row2 == 1) {
			msg = "글쓰기, 예약 성공";
			System.out.println("글쓰기, 예약 성공");
		}
		else {
			msg = "실패";
			System.out.println("실패");
		}
		return mav;
	}
	
//	@PostMapping("/reserve_new_for_cust")
//	public ModelAndView reserve_new_for_cust(reserveDTO reserveDTO, ReserveDTO reserveDTO) {
//		ModelAndView mav = new ModelAndView("/reserve/reserve_result");
//		int row = os.reserve(reserveDTO);
//		int row2 = rs.setReserve(reserveDTO);
//		String msg;
//		if(row != 0) {
//			msg = "주문이 접수되었습니다";
//		}
//		else {
//			msg = "주문 접수에 실패했습니다. 다시 시도해주세요";
//		}
//		mav.addObject("msg", msg);
//		
//		return mav;
//	}
	
//	@PostMapping("/statusChange")
//	public ModelAndView statusChange(@PathVariable reserveDTO dto, HashMap<String, String> param) {
//		ModelAndView mav = new ModelAndView("/reserve/reserve_result");
//		String status = dto.getreserve_status();
//		for(int i = 0; i < status_list.length; i++) {
//			if(i != status_list.length-1 && status == status_list[i])
//				dto.setReserve_status(status_list[i+1]);
//		}
//		String msg=null;
//		int row = rs.change_status(dto);
//		if(row == 1) {
//			msg = "상태 변경! 변경된 상태를 확인해주세요";
//		} else {
//			msg = "상태 변경 실패! 다시 시도해주세요";
//		}
//		mav.addObject("param", param);
//		mav.addObject("value", "status_change");
//		mav.addObject("msg", msg);
//		return mav;
//	}
}