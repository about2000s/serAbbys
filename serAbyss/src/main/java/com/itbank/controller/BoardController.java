package com.itbank.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.dto.ReviewBoardDTO;
import com.itbank.dto.SerCenDTO;
import com.itbank.dto.ServiceBoardDTO;
import com.itbank.service.BoardService;
import com.itbank.service.Paging;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService bs;

	@GetMapping("/review_list_all")
	public ModelAndView boardListAll(String type, String keyword, int page) {
		ModelAndView mav = new ModelAndView("board/review_list_all");
		
		if(keyword == null || keyword.equals("")) {
			type = "review_title";
			keyword = "";
		}
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("type", type);
		map.put("keyword", keyword);
		
		int reviewBoardCount = bs.reviewBoardCount(map);
		Paging paging = new Paging(page, reviewBoardCount);
		map.put("offset", paging.getOffset() + "");
		map.put("nowD", paging.getNowD() + "");
		
		
		
		
		List<ReviewBoardDTO> list = bs.reviewListAll(map);
		for(int i=0;i<list.size();i++) {
			int starScore = list.get(i).getReview_starScore();
			String star = "";
			for (int k = 0; k < starScore; k++) {
				star += "★";
			}
			for (int j = 0; j < 10 - starScore; j++) {
				star += "☆";
			}
			list.get(i).setStar(star);
		}
		mav.addObject("paging", paging);
		mav.addObject("page", page);
		mav.addObject("list", list);
		mav.addObject("type", type);
		mav.addObject("keyword", keyword);

		return mav;
	}

	//여기서 부터 재훈이가 건드렸습니다
	@GetMapping("/myCompList/{person_belong}")
	public ModelAndView myCompList(@PathVariable String person_belong) {
		ModelAndView mav = new ModelAndView("board/myCompList");
		List<ServiceBoardDTO> list = bs.myCompList(person_belong);
		mav.addObject("list", list);
		return mav;
	}
	
	@GetMapping("/myList/{person_id}")
	public ModelAndView myList(@PathVariable String person_id) {
		ModelAndView mav = new ModelAndView("board/myList");
		List<ServiceBoardDTO> list = bs.myList(person_id);
		mav.addObject("list", list);
		return mav;
		
	}
	
	@GetMapping("/serCen")
	public ModelAndView serCen(String type, String keyword, int page) {
		ModelAndView mav = new ModelAndView("board/faq");
		if(keyword == null || keyword.equals("")) {
			type = "serCen_title";
			keyword = "";
		}//map에 type, keyword, page, offset, nowD를 담을 거임
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("type", type);
		map.put("keyword", keyword);
		int boardCountFaq = bs.selectBoardCountFaq(map);
		Paging paging = new Paging(page, boardCountFaq);
		map.put("offset", paging.getOffset() + "");
		map.put("nowD", paging.getNowD() + "");
		
		List<SerCenDTO> list = bs.faqList(map);
		mav.addObject("paging", paging);
		mav.addObject("page", page);
		mav.addObject("list", list);
		mav.addObject("type", type);
		mav.addObject("keyword", keyword);
		mav.setViewName("board/faq");
		
		return mav;
	}
	
	
	@GetMapping("/serCenRead")
	public ModelAndView noticeRead(int serCen_idx, String serCen_belong) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("serCen_idx", serCen_idx + "");
		map.put("serCen_belong", serCen_belong);
		ModelAndView mav = new ModelAndView("board/serCenRead");
		SerCenDTO dto = bs.selectOneNotice(map);
		mav.addObject("dto", dto);
		return mav;
	}
	
	@GetMapping("/reviewRead")
	public ModelAndView reviewRead(int review_idx) {
		ModelAndView mav = new ModelAndView("board/reviewRead");
		ReviewBoardDTO dto = bs.selectOneReview(review_idx);
		int row = bs.reviewViewCountPlus(dto);
		System.out.println("조회수 1 증가");
		mav.addObject("dto", dto);
		return mav;
	}
	
	@GetMapping("reviewUpdate")
	public ModelAndView reviewUpdate(int review_idx) {
		ModelAndView mav = new ModelAndView("board/reviewUpdate");
		ReviewBoardDTO dto = bs.selectOneReview(review_idx);
		mav.addObject("dto", dto);
		return mav;
	}
	@PostMapping("reviewUpdate")
	public ModelAndView reviewUpdate(ReviewBoardDTO inputData) {
		ModelAndView mav = new ModelAndView("alert");
		int row = bs.reviewUpdate(inputData);
		String msg = null;
		if(row == 1) {
			msg = "글수정 성공";
			mav.addObject("msg", msg);
			mav.addObject("review_idx", inputData.getReview_idx());
		}
		return mav;
	}
	
	@GetMapping("reviewWrite")
	public ModelAndView reviewWrite(int service_idx) {
		ModelAndView mav = new ModelAndView("board/reviewWrite");
		ServiceBoardDTO dto = bs.selectOneByIdx(service_idx);
		mav.addObject("dto", dto);
		return mav;
	}
	@PostMapping("reviewWrite")
	public ModelAndView reviewWrite(ReviewBoardDTO dto) {
		ModelAndView mav = new ModelAndView("alert");
		int row = bs.reviewWrite(dto);
		String msg = null;
		if(row == 1) {
			msg = "리뷰작성 성공";
		}
		else {
			msg = "리뷰작성 실패";
		}
		mav.addObject("msg", msg);
		return mav;
	}
	
//	@GetMapping("/notice")
//	public ModelAndView notice(String type, String keyword, int page) {
//		
//	}
	
}
