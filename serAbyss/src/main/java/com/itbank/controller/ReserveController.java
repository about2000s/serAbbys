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
import com.itbank.dto.PersonDTO;
import com.itbank.dto.ReserveTimeDTO;
import com.itbank.service.ReserveService;

@Controller
@RequestMapping("/reserve")
public class ReserveController {
	
	@Autowired ReserveService rs;
	
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
		
		List<String> engiIdList = new ArrayList<String>();//기사의 아이디를 담는 리스트 선언 및 초기화
		engiIdList.add(((PersonDTO)session.getAttribute("login")).getPerson_id());//기사 리스트에 세션에 저장된 아이디를 담는다.
		
		List<Integer> dayList = rs.dayList(dayCount);//날짜 리스트를 담는 메서드
		List<HashMap<String, Object>> reserveTimeList = rs.reserveTimeList(engiIdList, hourCount, dayCount);
		//기사에 따른 예약가능한 예약시간을 담아두는 메서드
		
		mav.addObject("engiIdList", engiIdList);
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
		
		Boolean flag = rs.alreadyReviewWrite(reserve_idx);//flag==true라면 리뷰글이 작성된 상태
		System.out.println("flag: " + flag);
		ModelAndView mav = new ModelAndView("/reserve/read");
		int row = rs.reserveViewCountPlus(reserve_idx);//예약글의 조회수 증가시키는 메서드
		ReserveDTO dto = rs.selectOne(reserve_idx);//idx값을 통해 예약글 하나를 받아오는 메서드
		
		String b1 = "";
		String b2 = "";
		String ment = "(으)로 처리 상태 변경하기";
		
		rs.statusChangeBtn(dto, b1, b2);//현재 상태에 따라 바꿀 상태값의 버튼 이름 정하는 메서드
		
		mav.addObject("b1", b1);
		mav.addObject("b2", b2);
		mav.addObject("ment", ment);
		mav.addObject("dto", dto);
		mav.addObject("map", map);
		mav.addObject("flag", flag);
		return mav;
	}
	//미완성. 아직 더 봐야 해
	@GetMapping("statusChange/{reserve_idx}")
	public ModelAndView statusChange(@PathVariable int reserve_idx, String b1, String b2) {
		ModelAndView mav = new ModelAndView("redirect:/reserve/read/" + reserve_idx);
		ReserveDTO dto = rs.selectOne(reserve_idx);
		if(b1.equals("서비스중")) {
			b1 = "서비스중";
		}
		else if(b1.equals("서비스완료")) {
			b1 = "서비스완료";
		}
		else if(b1.equals("결제완료")) {
			b1 = "결제완료";
		}
		else if(b1.equals("환불신청")){
				b1 = "환불접수";
			}
		else if(b1.equals("처리완료")) {
			b1 = "처리완료";
		}
		dto.setReserve_status(b1);
		int row = rs.statusChange(dto);
		mav.addObject("b1", b1);
		mav.addObject("b2", b2);
		return mav;
	}
	
	@GetMapping("/changeReserveTime/{reserve_idx}")
	public ModelAndView changeReserveTime(@PathVariable int reserve_idx) {
		ModelAndView mav = new ModelAndView("reserve/changeReserveTime");
		int hourCount = 8;
		int dayCount = 14;
		String engiId = rs.selectEngiIdOneByIdx(reserve_idx);
		List<String> engiIdList = new ArrayList<String>();
		engiIdList.add(engiId);
		
		List<Integer> dayList = rs.dayList(dayCount);
		
		List<HashMap<String, Object>> reserveTimeList = rs.reserveTimeList(engiIdList, hourCount, dayCount);
		
		mav.addObject("engiIdList", engiIdList);
		mav.addObject("dayList", dayList);
		mav.addObject("reserveTimeList", reserveTimeList);
		return mav;
	}
	@PostMapping("/changeReserveTime/{reserve_idx}")
	public ModelAndView changeReserveTime(@PathVariable int reserve_idx, ReserveTimeDTO reserveTimeDTO) {
		ModelAndView mav = new ModelAndView("reserve/alert");
		
		ReserveDTO reserveDTO = rs.selectOne(reserve_idx);
		
		rs.monthAndCustIdSetForReserve(reserveDTO, reserveTimeDTO);
		
		String title = null;
		
		if(reserveDTO.getReserve_custId() == null) {
			title = String.format("[2021년 %d월 %d일 %d시 %s 고객님이 예약하셨습니다.]", 
				reserveTimeDTO.getReserveTime_month(), reserveTimeDTO.getReserveTime_day(), 
				reserveTimeDTO.getReserveTime_hour(), reserveDTO.getReserve_name());
		}
		else {
			title = String.format("[2021년 %d월 %d일 %d시 %s(%s) 고객님이 예약하셨습니다.]", 
				reserveTimeDTO.getReserveTime_month(), reserveTimeDTO.getReserveTime_day(), 
				reserveTimeDTO.getReserveTime_hour(), reserveDTO.getReserve_name(), reserveDTO.getReserve_custId());
		}
		reserveDTO.setReserve_title(title);
		int row1 = rs.reserveTitleChange(reserveDTO);
		
		reserveTimeDTO.setReserveTime_idx(reserve_idx);
		int row2 = rs.changeReserveTime(reserveTimeDTO);
		String msg = null;
		if(row1 != 0 && row2 != 0) {
			msg = "예약시간 변경 성공";
			mav.addObject("reserve_idx", reserve_idx);
		}
		else {
			msg = "예약시간 변경 실패";
		}
		mav.addObject("msg", msg);
		
		return mav;
	}

	//게시글 수정
	@GetMapping("/modify/{reserve_idx}")
	public ModelAndView modify(@PathVariable int reserve_idx, @RequestParam HashMap<String, Object> map) {
		
		
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
		int row = rs.modify(inputData);
		return path;
	}
	
	//글 삭제 및 예약 취소
	@GetMapping("/delete/{reserve_idx}")
	public ModelAndView delete(@PathVariable int reserve_idx) {
		ModelAndView mav = new ModelAndView("/reserve/alert");
		int row2 = rs.deleteReserveTime(reserve_idx);
		int row1 = rs.deleteReserve(reserve_idx);
		String msg;
		if(row1 != 0 && row2 != 0) {
			msg = "예약이 취소됨";
		}
		else {
			msg = "예약취소 실패";
		}
		mav.addObject("msg", msg);
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
		
		List<HashMap<String, Object>> reserveTimeList = rs.reserveTimeList(engiIdList, hourCount, dayCount);
		
		mav.addObject("engiIdList", engiIdList);
		mav.addObject("dayList", dayList);
		mav.addObject("reserveTimeList", reserveTimeList);
		return mav;
	}
	
	// 고객이 서비스 글 쓰기
	@PostMapping("/reserve_new_for_cust")
	public ModelAndView reserve_new_for_cust(ReserveDTO reserveDTO, ReserveTimeDTO reserveTimeDTO){
		ModelAndView mav = new ModelAndView("reserve/alert");
		PersonDTO cust = rs.selectOneById(reserveDTO.getReserve_custId());
		PersonDTO engi = rs.selectOneById(reserveTimeDTO.getReserveTime_engiId());
		
		reserveDTO.setReserve_engiId(reserveTimeDTO.getReserveTime_engiId());
		reserveDTO.setReserve_compBelong(engi.getPerson_belong());
		
		rs.monthAndCustIdSetForReserve(reserveDTO, reserveTimeDTO);
		
		String title = String.format("[2021년 %d월 %d일 %d시 %s(%s) 고객님이 예약하셨습니다.]", 
				reserveTimeDTO.getReserveTime_month(), reserveTimeDTO.getReserveTime_day(), 
				reserveTimeDTO.getReserveTime_hour(), reserveDTO.getReserve_name(), reserveDTO.getReserve_custId());
		reserveDTO.setReserve_title(title);
		
		int row1 = rs.reserve(reserveDTO);
		int reserve_idx = rs.selectMaxIdxInReserve(reserveDTO.getReserve_engiId());
		reserveTimeDTO.setReserveTime_idx(reserve_idx);
		int row2 = rs.insertReserveTime(reserveTimeDTO);
		
		String msg = null;
		if(row1 == 1 && row2 == 1) {
			msg = "예약 성공";
			mav.addObject("reserve_idx", reserve_idx);
		}
		else {
			msg = "예약 실패";
		}
		mav.addObject("msg", msg);
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