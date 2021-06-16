package com.itbank.controller;

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
import com.itbank.service.OrderService;
import com.itbank.service.Paging;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired OrderService os;
	
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
		mav.addObject("value", "order_new");
		return mav;
	}
	
	@GetMapping("/select/{idx}")
	public ModelAndView read(@PathVariable int idx, HashMap<String, String> param, String value) {
		param.put("value", value);
		ModelAndView mav = new ModelAndView("/order/" + param.get("value"));
		OrderDTO dto = os.selectOne(idx);
		mav.addObject("dto", dto);
		return mav;
	}

	@PostMapping("/select/{idx}")
	public ModelAndView modify(@PathVariable int idx, OrderDTO dto) {
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

}
