package com.itbank.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.dto.OrderDTO;
import com.itbank.dto.ReserveDTO;
import com.itbank.service.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {

	@GetMapping("/service_list_all")
	public ModelAndView ListAll() {
		ModelAndView mav = new ModelAndView("/order/list");
		List<OrderDTO> list = os.selectall();
		mav.addObject("list", list);
		return mav;
	}
	
	@Autowired OrderService os;
	
	@GetMapping("/statusList")
	public ModelAndView registList(@RequestParam String status) {
		ModelAndView mav = new ModelAndView("/order/list");
		List<OrderDTO> list = os.selectStatus(status);
		mav.addObject("list", list);
		return mav;
	}
	
	@GetMapping("/order_new")
	public String orderNew() {
		return "/order/order_new";
	}
	
	@PostMapping("/order_new")
	public ModelAndView order(OrderDTO dto) {
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
		return mav;
	}
	
	@GetMapping("/select/{idx}")
	public ModelAndView read(@PathVariable int idx, String value) {
		ModelAndView mav = new ModelAndView("/order/" + value);
		OrderDTO dto = os.selectOne(idx);
		mav.addObject("dto", dto);
		return mav;
	}

	@PostMapping("/select/{idx}")
	public ModelAndView modify(@PathVariable int idx, OrderDTO dto) {
		String msg;
		dto.setService_idx(idx);
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
	
	
//	ModelAndView mav = new ModelAndView("board/writeFaq");
//	SimpleDateFormat format1 = new SimpleDateFormat ("dd");
//	Date date = new Date();
//	String time1 = format1.format(date);
//	int day = Integer.parseInt(time1);
//	List<Integer> list = new ArrayList<Integer>();
//	for(int i=0;i<14;i++) {
//		list.add(i, day + i);
//	}
//	mav.addObject("list", list);
//	return mav;
	
	@GetMapping("/order_new_for_cust")
	public ModelAndView order_new_for_cust() {
		ModelAndView mav = new ModelAndView("/order/order_new_for_cust");
		
//		SimpleDateFormat nalzza = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
		SimpleDateFormat MM = new SimpleDateFormat("MM");
		SimpleDateFormat dd = new SimpleDateFormat("dd");
		Date date = new Date();
		String year = yyyy.format(date); // 2021
		String month = MM.format(date);
		String day = dd.format(date);
		int yearToInt = Integer.parseInt(year);
		int monthToInt = Integer.parseInt(month);
		int dayToInt = Integer.parseInt(day);
		int hour = 8;
		
		String engiId = "kim123";
		String custId = "lee123";
		
		List<String> monthList = new ArrayList<String>(); // 06, 07
		for(int i=0;i<1;i++) {
			monthList.add(i, (monthToInt + i) + "");
			if(monthList.get(i).length() == 1) {
				monthList.set(i, "0" + monthList.get(i));
			}
		}
		
		List<String> dayList = new ArrayList<String>(); // 16, 17 ...
		for(int i=0;i<7;i++) {
			dayList.add(i, (dayToInt + i + 1) + "");
			if(dayList.get(i).length() == 1) {
				dayList.set(i, "0" + dayList.get(i));
			}
		}
		
		
//		List<HashMap<String, String>> hashList = new ArrayList<HashMap<String,String>>();
		
		List<List<String>> hList = new ArrayList<List<String>>();
		
//		List<String> nalzzaList = new ArrayList<String>(); // 2021061608, 2021061610, ...
		for(int i=0;i<monthList.size();i++) {
			for(int j=0;j<dayList.size();j++) {
				List<String> dList = new ArrayList<String>();
				
				List<String> hourList = new ArrayList<String>(); //반복문을 돌릴 때마다 새로운 hourList를 만든다!
				for(int s=0;s<8;i++) {
					hourList.add(s, (hour + s*2) + "");
					if(hourList.get(s).length() == 1) {
						hourList.set(s, "0" + hourList.get(s));
					}
				}
				for(int k=0;k<hourList.size();k++) {
//					nalzzaList.add(year + monthList.get(i) + dayList.get(j) + hourList.get(k));
					String reserve_year = year;
					String reserve_month = monthList.get(i);
					String reserve_day = dayList.get(j);
					String reserve_hour = hourList.get(k);
					String reserve_engiId = engiId;
					String reserve_custId = custId;
					
					HashMap<String, String> map = new HashMap<String, String>();
					map.put("reserve_year", reserve_year);
					map.put("reserve_month", reserve_month);
					map.put("reserve_day", reserve_day);
					map.put("reserve_hour", reserve_hour);
					map.put("reserve_engiId", reserve_engiId);
					map.put("reserve_custId", reserve_custId);
					
					ReserveDTO inputData = new ReserveDTO(reserve_year, reserve_month, reserve_day, reserve_hour, reserve_engiId, reserve_custId);
					
					ReserveDTO dto = os.selectReserveOne(inputData);
					if(dto == null) {
						hourList.remove(dto.getReserve_hour());
					}
					hList.add(hourList);
				}
			}
		}
		
		mav.addObject("monthList", monthList);
		mav.addObject("dayList", dayList);
		
		mav.addObject("hList", hList);
		
//		for(int i=0;i<dayList.size();i++) {
//			mav.addObject("hourOf" + dayList.get(i), hList.get(i));
//		}
		
		return mav;
	}

}
