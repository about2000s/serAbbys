package com.itbank.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

import com.itbank.dto.OrderDTO;
import com.itbank.dto.PersonDTO;
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
	
	@GetMapping("/order_new_for_cust")
	public ModelAndView order_new_for_cust() {
		ModelAndView mav = new ModelAndView("/order/order_new_for_cust");
		
		SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
		SimpleDateFormat MM = new SimpleDateFormat("MM");
		SimpleDateFormat dd = new SimpleDateFormat("dd");
		Date date = new Date();
		String year = yyyy.format(date); // 2021
		String month = MM.format(date);
		String day = dd.format(date);
		int monthToInt = Integer.parseInt(month);
		int dayToInt = Integer.parseInt(day);
		int hour = 8;
		
		List<String> engiIdList = os.selectEngiIdAll();
		System.out.println("engiList: " + engiIdList);
		
		List<String> monthList = new ArrayList<String>(); // 06
		for(int i=0;i<2;i++) {
			monthList.add(i, (monthToInt + i) + "");
			if(monthList.get(i).length() == 1) {
				monthList.set(i, "0" + monthList.get(i));
			}
		}
		
		List<String> dayList = new ArrayList<String>(); // 16, 17
		for(int i=0;i<3;i++) {
			dayList.add(i, (dayToInt + i + 1) + "");
			if(dayList.get(i).length() == 1) {
				dayList.set(i, "0" + dayList.get(i));
			}
		}
		
//		List<List<String>> hList = new ArrayList<List<String>>();
		List<List<List<List<String>>>> aList = new ArrayList<List<List<List<String>>>>();
		
		// hour에 대한 리스트
		
		//day에 대응되는 hour리스트가 담긴 map1
		
		//month에 대응되는 map1이 담긴 map2
		
		//engiId에 대응되는 map2가 담긴 map3
		HashMap<String, HashMap<String, HashMap<String, List<String>>>> aMap = new HashMap<String, HashMap<String,HashMap<String,List<String>>>>();
		
		//지옥의 반복문 시작
		for(int a=0;a<engiIdList.size();a++) {
//			List<List<List<String>>> bList = new ArrayList<List<List<String>>>();
			HashMap<String, HashMap<String, List<String>>> bMap = new HashMap<String, HashMap<String,List<String>>>();
			
			for(int b=0;b<monthList.size();b++) {
//				List<List<String>> cList = new ArrayList<List<String>>();
				HashMap<String, List<String>> cMap = new HashMap<String, List<String>>();
				
				for(int c=0;c<dayList.size();c++) {
					
					List<String> dList = new ArrayList<String>(); //반복문을 돌릴 때마다 새로운 dList를 만든다!
					for(int d=0;d<8;d++) {	// 08 10 12 14 16 18 20 22
						dList.add(d, (hour + d*2) + "");
						if(dList.get(d).length() == 1) { // 길이가 1인 것(8)은 앞에 0을 붙여 08로 만든다
							dList.set(d, "0" + dList.get(d));
						}
					}
					
					for(int e=0;e<dList.size();e++) {
						String reserve_year = year;
						String reserve_month = monthList.get(b);
						String reserve_day = dayList.get(c);
						String reserve_hour = dList.get(e);
						String reserve_engiId = engiIdList.get(a);
						ReserveDTO inputData = new ReserveDTO(reserve_year, reserve_month, reserve_day, reserve_hour, reserve_engiId);
						
						ReserveDTO dto = os.selectReserveOne(inputData);
						if(dto != null) {
							dList.remove(dto.getReserve_hour());
						}
					}
//					cList.add(dList);
					cMap.put(dayList.get(c), dList);
				}
//				bList.add(cList);
				bMap.put(monthList.get(b), cMap);
			}
//			aList.add(bList);
			aMap.put(engiIdList.get(a), bMap);
		}
		int startDay = dayToInt + 1;
		
		mav.addObject("aMap", aMap);
		
		
		
		mav.addObject("aList", aList);
		mav.addObject("engiIdList", engiIdList);
		mav.addObject("engiIdListSize", engiIdList.size());
		mav.addObject("monthList", monthList);
		mav.addObject("monthListSize", monthList.size());
		mav.addObject("dayList", dayList);
		mav.addObject("dayListSize", dayList.size());
		mav.addObject("dayCount", dayList.size());
		mav.addObject("startDay", startDay);
		
		return mav;
	}

}
