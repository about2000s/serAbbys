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
	public ModelAndView registList(@RequestParam HashMap<String, String> param, int page) {
		ModelAndView mav = new ModelAndView("/order/list");
		int orderCountList = os.selectBoardCountList(param);
		Paging paging = new Paging(page, orderCountList);
		param.put("offset", paging.getOffset() + "");
		param.put("nowD", paging.getNowD() + "");
		List<OrderDTO> list = os.selectStatus(param);
		mav.addObject("page", page);
		mav.addObject("list", list);
		mav.addObject("param", param);
		mav.addObject("paging", paging);
		return mav;
	}
	
	@PostMapping("/statusList")
	public ModelAndView postRegistList(@RequestParam HashMap<String, String> param) {
		ModelAndView mav = new ModelAndView("/order/list");
		int orderCountList = os.selectBoardCountList(param);
		Paging paging = new Paging(Integer.parseInt(param.get("page")), orderCountList);
		param.put("offset", paging.getOffset() + "");
		param.put("nowD", paging.getNowD() + "");
		List<OrderDTO> list = os.selectStatus(param);
		mav.addObject("list", list);
		mav.addObject("param", param);
		mav.addObject("paging", paging);
		return mav;
	}
	
	@GetMapping("/order_new")
	public String orderNew() {
		return "/order/order_new";
	}
	
	@PostMapping("/order_new")
	public ModelAndView order(OrderDTO dto, String address, String detailAddress) {
		String fullAddress = address + " " + detailAddress;
		dto.setService_address(fullAddress);
		ModelAndView mav = new ModelAndView("/order/order_result");
		String msg;
		int row = os.order(dto);
		if(row != 0) {
			msg = "주문이 접수되었습니다";
		}
		else {
			msg = "주문 접수에 실패했습니다. 다시 시도해주세요";
		}
		mav.addObject("msg", msg);
		mav.addObject("value", "order_new");
		return mav;
	}
	
	@GetMapping("/select/{idx}")
	public ModelAndView read(@PathVariable int idx, HashMap<String, String> param, String value, HttpSession session) {
		param.put("value", value);
		ModelAndView mav = new ModelAndView("/order/" + param.get("value"));
		OrderDTO dto = os.selectOne(idx);
		session.setAttribute("dto", dto);
		mav.addObject("dto", dto);
		mav.addObject("param", param);
		return mav;
	}

	@PostMapping("/select/{idx}")
	public ModelAndView modify(@PathVariable int idx, OrderDTO dto, HashMap<String, String> param, HttpSession session) {
		String msg;
		int row = os.modify(dto);
		if(row != 0) {
			msg = "수정이 완료되었습니다";
		}
		else {
			msg = "수정에 실패했습니다. 다시 시도해주세요";
		}
		ModelAndView mav = new ModelAndView("/order/order_result");
		mav.addObject("msg", msg);
		mav.addObject("value", "modify");
		mav.addObject("idx", idx);
		mav.addObject("param", param);
		return mav;
	}
	
	@GetMapping("/delete/{idx}")
	public ModelAndView delete(@PathVariable int idx) {
		int row = os.delete(idx);
		String msg;
		if(row != 0) {
			msg = "삭제가 완료되었습니다";
		}
		else {
			msg = "삭제에 실패했습니다. 다시 시도해주세요";
		}
		ModelAndView mav = new ModelAndView("/order/order_result");
		mav.addObject("msg", msg);
		mav.addObject("value", "delete");
		return mav;
	}
	
//	@GetMapping("/order_new_for_cust")
//	public ModelAndView order_new_for_cust() {
//		ModelAndView mav = new ModelAndView("/order/order_new_for_cust");
//		
//		HashMap<String, List<String>> map = os.complicateJob();
//		
//		SimpleDateFormat dd = new SimpleDateFormat("dd");
//		Date date = new Date();
//		String day = dd.format(date);
//		int dayToInt = Integer.parseInt(day);
//		List<String> dayList = new ArrayList<String>();
//		for(int i=0;i<7;i++) {
//			dayToInt++;
//			dayList.add(dayToInt + "");
//		}
//		
//		mav.addObject("dayList", dayList);
//		mav.addObject("map", map);
//		//			engiId   
//		List<HashMap<String, HashMap<String, String>>> newMap = new ArrayList<HashMap<String,HashMap<String,String>>>();
//		
//		mav.addObject("aMap", map.get("aMap"));
//		mav.addObject("engiIdList", map.get("engiIdList"));
//		mav.addObject("monthList", map.get("monthList"));
//		mav.addObject("dayList", map.get("dayList"));
		
//		return mav;
//	}
	

	@GetMapping("/order_new_for_cust")
	public ModelAndView order_new_for_cust() {
		ModelAndView mav = new ModelAndView("/order/order_new_for_cust");
		Calendar today = Calendar.getInstance();
		
//		int yoil = today.get(Calendar.DAY_OF_WEEK);
		int lastDayOfThisMonth = today.getActualMaximum(Calendar.DATE);
		
		int hourCount = 8;
		int dayCount = 14;
		
		List<String> engiIdList = os.selectEngiIdAll();
		
		int nowDay = today.get(Calendar.DATE);
		int nowMonth = today.get(Calendar.MONTH) + 1;
		List<String> dayList = new ArrayList<String>();
		for(int i=0;i<dayCount;i++) {
			if(nowDay == 30) {
				if(nowMonth == 6 || nowMonth == 9 || nowMonth == 11) {
					nowDay = 1;
				}
			}
			else if(nowDay == 31) {
				if(nowMonth == 7 || nowMonth == 8 || nowMonth == 10 || nowMonth == 12) {
					nowDay = 1;
				}
			}
			else {
				nowDay++;
			}
			dayList.add(nowDay + "");
		}
		
		List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
		for(int i=0;i<engiIdList.size();i++) {
			int year = today.get(Calendar.YEAR);
			int month = today.get(Calendar.MONTH) + 1;
			int day = today.get(Calendar.DATE) + 1;
			int hour = 6; // for문으로 반복문을 돌려놓고 숫자계산 후 "" 더해서 HashMap에 넣자!
			for(int j=0;j<hourCount*(dayCount + 1);j++) {
				HashMap<String, String> map = new HashMap<String, String>();
				if(hour == 22) {
					if(day == 30) {
						if(month == 6 || month == 9 || month == 11) {
							month++;
							day = 1;
							hour = 8;
						}
					}
					else if(day == 31) {
						if(month == 7 || month == 8 || month == 10 || month == 12) {
							month++;
							day = 1;
							hour = 8;
						}
					}
					else {
						day++;
						hour = 8;
					}
				}else {
					hour += 2;
				}
				ReserveDTO inputData = new ReserveDTO(year + "", month + "", day + "", hour + "", engiIdList.get(i));
				ReserveDTO dto = os.selectReserveOne(inputData);
				if(dto != null) continue;
				map.put("engiId", engiIdList.get(i));
				map.put("year", year + "");
				map.put("month", month + "");
				map.put("day", day + "");
				map.put("hour", hour + "");
				list.add(map);
			}
			
		}
		mav.addObject("engiIdList", engiIdList);
		mav.addObject("dayList", dayList);
		mav.addObject("list", list);
		return mav;
	}
	//service_title, service_content, file, engiId, day, hour
	@PostMapping("/order_new_for_cust")
	public ModelAndView order_new_for_cust(OrderDTO orderDTO, ReserveDTO reserveDTO){
		
		Calendar today = Calendar.getInstance();
		
		ModelAndView mav = new ModelAndView();
		PersonDTO cust = os.selectOneById(orderDTO.getService_custId());
		PersonDTO engi = os.selectOneById(reserveDTO.getReserve_engiId());
		orderDTO.setService_status("register");
		orderDTO.setService_address(cust.getPerson_address());
		orderDTO.setService_engiId(reserveDTO.getReserve_engiId());
		orderDTO.setService_compBelong(engi.getPerson_belong());
		
		reserveDTO.setReserve_year("2021");
		if(Integer.parseInt(reserveDTO.getReserve_day()) >= 1 && Integer.parseInt(reserveDTO.getReserve_day()) <= 13) {
			reserveDTO.setReserve_month((today.get(Calendar.MONTH) + 2) + "");
		}
		else {
			reserveDTO.setReserve_month((today.get(Calendar.MONTH) + 1) + "");
		}
		reserveDTO.setReserve_custId(cust.getPerson_id());
		
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
