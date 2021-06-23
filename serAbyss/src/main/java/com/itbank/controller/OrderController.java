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

import com.itbank.dto.OrderDTO;
import com.itbank.dto.PersonDTO;
import com.itbank.dto.ReserveDTO;
import com.itbank.service.OrderService;
import com.itbank.service.Paging;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired OrderService os;
	
	String[] status_list = {"등록완료", "접수완료", "fixing", "fixed", "payed", "cancleRegister", "cancleComplete", "success"};
	
	@GetMapping("/statusList")
	public ModelAndView statusList(String service_status, String type, String keyword, int page, HttpSession session) {
		ModelAndView mav = new ModelAndView("/order/list");
		HashMap<String, Object> map = os.job(service_status, type, keyword, page, session);
		mav.addObject("map", map);
		return mav;
	}
	
	//기사가 서비스 글 작성하는 폼으로 이동
	@GetMapping("/order_new_for_engi")
	public ModelAndView orderNew(HttpSession session) {
		ModelAndView mav = new ModelAndView("/order/order_new_for_engi");
		int hourCount = 8;
		int dayCount = 14;
		
		List<String> engiIdList = new ArrayList<String>();
		engiIdList.add(((PersonDTO)session.getAttribute("login")).getPerson_id());
		
		List<Integer> dayList = os.dayList(dayCount);
		List<HashMap<String, Object>> reserveList = os.reserveList(engiIdList, hourCount, dayCount);
		
		mav.addObject("engiIdList", engiIdList);
		mav.addObject("dayList", dayList);
		mav.addObject("reserveList", reserveList);
		return mav;
	}
	
	//기사가 서비스 글 작성
	@PostMapping("/order_new_for_engi")
	public ModelAndView order(OrderDTO orderDTO, ReserveDTO reserveDTO, String address, String detailAddress) {
		String fullAddress = address + " " + detailAddress;
		orderDTO.setService_address(fullAddress);
		//[2021년 6월 23일 20시 홍길동 고객님께서 예약하셨습니다.]
		os.monthAndCustIdSetForReserve(orderDTO, reserveDTO);
		String title = String.format("[%d년 %d월 %d일 %d시 %s 고객님께서 예약하셨습니다.]",
				2021, reserveDTO.getReserve_month(), reserveDTO.getReserve_day(),
				reserveDTO.getReserve_hour(), orderDTO.getService_name());
		orderDTO.setService_title(title);
		
		ModelAndView mav = new ModelAndView("/order/order_result");
		String msg;
		int row1 = os.order(orderDTO);
		int row2 = os.insertReserve(reserveDTO);
		if(row1 == 1 && row2 == 1) {
			msg = "주문이 접수되었습니다";
		}
		else {
			msg = "주문 접수에 실패했습니다. 다시 시도해주세요";
		}
		mav.addObject("msg", msg);
		mav.addObject("value", "order_new");
		return mav;
	}
	
	
	//글 읽기/${dto.service_idx}?page=${map.page}&type=${map.type}&keyword=${map.keyword}&service_status=${map.service_status}
	@GetMapping("/read/{service_idx}")
	public ModelAndView read(@PathVariable int service_idx, @RequestParam HashMap<String, Object> map) {
		Boolean flag = os.alreadyReviewWrite(service_idx);//flag==true라면 리뷰글이 작성된 상태
		System.out.println("flag: " + flag);
		ModelAndView mav = new ModelAndView("/order/read");
		OrderDTO dto = os.selectOne(service_idx);
		mav.addObject("dto", dto);
		mav.addObject("map", map);
		mav.addObject("flag", flag);
		return mav;
	}

	//글 수정
	@GetMapping("/modify/{service_idx}")
	public ModelAndView modify(@PathVariable int service_idx, @RequestParam HashMap<String, Object> map) {
		System.out.println("modify");
		ModelAndView mav = new ModelAndView("order/modify");
		OrderDTO dto = os.selectOne(service_idx);
		mav.addObject("dto", dto);
		mav.addObject("map", map);
		return mav;
	}
	
	//"redirect:/board/read/" + dto.getIdx() + "/?page=1";
	@PostMapping("/modify/{service_idx}")
	public String modify(@PathVariable int service_idx, OrderDTO inputData, @RequestParam HashMap<String, Object> map) {
		String path = "redirect:/order/read/" + service_idx + 
				"?page=" + map.get("page") + "&type=" + map.get("type")+ 
				"&keyword=" + map.get("keyword") + "&service_status=" + map.get("service_status");
		System.out.println(path);
		ModelAndView mav = new ModelAndView(path);
//		int row = os.modify(inputData);
		String msg = "글 수정 성공";
		return path;
	}
	
	//글 삭제
	@GetMapping("/delete/{idx}")
	public ModelAndView delete(@PathVariable int idx) {
//		int row1 = os.deleteService(idx);
//		int row2 = os.cancelReserve(idx);//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@이거 해야 해
		String msg;
//		if(row1 != 0 && row2 != 0) {
//			msg = "삭제가 완료되었습니다";
//		}
//		else {
//			msg = "삭제에 실패했습니다. 다시 시도해주세요";
//		}
		ModelAndView mav = new ModelAndView("/order/order_result");
//		mav.addObject("msg", msg);
		mav.addObject("value", "delete");
		return mav;
	}

	//고객이 서비스 글 쓰기 폼으로 이동
	@GetMapping("/order_new_for_cust")
	public ModelAndView order_new_for_cust() {
		ModelAndView mav = new ModelAndView("/order/order_new_for_cust");
		
		int hourCount = 8;
		int dayCount = 14;
		
		List<String> engiIdList = os.selectEngiIdAll();
		List<Integer> dayList = os.dayList(dayCount);
		
		List<HashMap<String, Object>> reserveList = os.reserveList(engiIdList, hourCount, dayCount);
		
		mav.addObject("engiIdList", engiIdList);
		mav.addObject("dayList", dayList);
		mav.addObject("reserveList", reserveList);
		return mav;
	}
	
	// 고객이 서비스 글 쓰기
	@PostMapping("/order_new_for_cust")
	public ModelAndView order_new_for_cust(OrderDTO orderDTO, ReserveDTO reserveDTO){
		ModelAndView mav = new ModelAndView();
		System.out.println("주소: " + orderDTO.getService_address());
		PersonDTO cust = os.selectOneById(orderDTO.getService_custId());
		PersonDTO engi = os.selectOneById(reserveDTO.getReserve_engiId());
		
		orderDTO.setService_status("등록완료");
//		orderDTO.setService_address(cust.getPerson_address());
		orderDTO.setService_engiId(reserveDTO.getReserve_engiId());
		orderDTO.setService_compBelong(engi.getPerson_belong());
		
		os.monthAndCustIdSetForReserve(orderDTO, reserveDTO);
		
		int row1 = os.order(orderDTO);
		int row2 = os.insertReserve(reserveDTO);
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
	
//	@PostMapping("/order_new_for_cust")
//	public ModelAndView order_new_for_cust(OrderDTO orderDTO, ReserveDTO reserveDTO) {
//		ModelAndView mav = new ModelAndView("/order/order_result");
//		int row = os.order(orderDTO);
//		int row2 = os.setReserve(reserveDTO);
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
//	public ModelAndView statusChange(@PathVariable OrderDTO dto, HashMap<String, String> param) {
//		ModelAndView mav = new ModelAndView("/order/order_result");
//		String status = dto.getService_status();
//		for(int i = 0; i < status_list.length; i++) {
//			if(i != status_list.length-1 && status == status_list[i])
//				dto.setService_status(status_list[i+1]);
//		}
//		String msg=null;
//		int row = os.change_status(dto);
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