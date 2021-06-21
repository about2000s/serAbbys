package com.itbank.controller;

import java.util.ArrayList;
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
import com.itbank.dto.PersonDTO;
import com.itbank.dto.ReplyDTO;
import com.itbank.dto.ReviewBoardDTO;
import com.itbank.dto.SerCenDTO;
import com.itbank.service.BoardService;
import com.itbank.service.Paging;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService bs;

	//리뷰글의 모든 리스트 보러 가기
	@GetMapping("/review_list_all")//map에 page, type, keyword 담음
	public ModelAndView boardListAll(@RequestParam HashMap<String, Object> map) {
		ModelAndView mav = new ModelAndView("board/review_list_all");
		
		if(map.get("keyword") == null || map.get("keyword").equals("")) {
			map.put("type", "review_title");
			map.put("keyword", "");
		}
		
		int page = Integer.parseInt(String.valueOf(map.get("page")));
		int reviewBoardCount = bs.reviewBoardCount(map);
		Paging paging = new Paging(page, reviewBoardCount);
		map.put("offset", paging.getOffset());
		map.put("nowD", paging.getNowD());
		
		List<ReviewBoardDTO> list = bs.reviewListAll(map);
		bs.setStarInList(list);
		mav.addObject("paging", paging);
		mav.addObject("list", list);
		mav.addObject("map", map);
		return mav;
	}

	//고객센터로 가기
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
	
	//고객센터의 글 읽기
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
	
	//리뷰글 읽기
	@GetMapping("/reviewRead/{review_idx}")
	public ModelAndView reviewRead(@PathVariable int review_idx, @RequestParam HashMap<String, Object> map) {
		System.out.println("map" + map);
		ModelAndView mav = new ModelAndView("board/reviewRead");
		ReviewBoardDTO dto = bs.selectOneReview(review_idx);
		int row = bs.reviewViewCountPlus(dto);
		List<ReplyDTO> replyList = bs.replyList(review_idx);
		
//		int replyCount = bs.replyCount(review_idx);
		int replyCount = replyList.size();//댓글 개수
		int nowD = 10;
		int pageD = 10;
		int replyPageCount = replyCount%nowD == 0 ? replyCount/nowD : replyCount/nowD + 1;//댓글 페이지 개수
		
		System.out.println("replyCount: " + replyCount);
		System.out.println("replyPageCount: " + replyPageCount);
		
		List<Integer> replyPageList = new ArrayList<Integer>();
		if(replyCount != 0) {
			for(int i=1;i<=replyPageCount;i++) {
				replyPageList.add(i);
			}
		}
		
		
		mav.addObject("replyCount", replyCount);
		mav.addObject("replyPageList", replyPageList);
		mav.addObject("nowD", nowD);
		
		
		mav.addObject("dto", dto);
		mav.addObject("replyList", replyList);
		mav.addObject("map", map);
		return mav;
	}
	// 리뷰 게시판에 댓글 쓰기
	@PostMapping("/reviewRead/{review_idx}")
	public ModelAndView replyWrite(@PathVariable int review_idx, ReplyDTO dto, @RequestParam HashMap<String, Object> map) {
		String path = "redirect:/board/reviewRead/" + review_idx
				+ "?type=" + map.get("type")
				+ "&keyword=" + map.get("keyword")
				+ "&page=" + map.get("page");
		ModelAndView mav = new ModelAndView(path);
		int row = bs.replyWrite(dto);
		if(row != 0) {
			System.out.println("댓글 작성 성공");
		}
		return mav;
	}
	
	//리뷰글 수정하는 폼으로 이동하기
	@GetMapping("reviewModify/{review_idx}")
	public ModelAndView reviewUpdate(@PathVariable int review_idx, @RequestParam HashMap<String, Object> map) {
		ModelAndView mav = new ModelAndView("board/reviewModify");
		ReviewBoardDTO dto = bs.selectOneReview(review_idx);
		mav.addObject("dto", dto);
		mav.addObject("map", map);
		return mav;
	}
	//리뷰글 수정하기
	@PostMapping("reviewModify/{review_idx}")
	public ModelAndView reviewUpdate(@PathVariable int review_idx, ReviewBoardDTO inputData, @RequestParam HashMap<String, Object> map) {
		String path = "redirect:/board/reviewRead/" + review_idx
				+ "?type=" + map.get("type")
				+ "&keyword=" + map.get("keyword")
				+ "&page=" + map.get("page");
		ModelAndView mav = new ModelAndView(path);
		int row = bs.reviewUpdate(inputData);
		String msg = null;
		if(row == 1) {
			msg = "글수정 성공";
			mav.addObject("msg", msg);
			mav.addObject("review_idx", inputData.getReview_idx());
		}
		System.out.println("글 수정 성공");
		return mav;
	}
	
	//리뷰글 작성하는 폼으로 이동하기
	@GetMapping("reviewWrite")
	public ModelAndView reviewWrite(int service_idx) {
		ModelAndView mav = new ModelAndView("board/reviewWrite");
		OrderDTO dto = bs.selectOneByIdx(service_idx);
		mav.addObject("dto", dto);
		return mav;
	}
	//리뷰글 작성하기
	@PostMapping("reviewWrite")
	public ModelAndView reviewWrite(ReviewBoardDTO dto) {
		String path = "redirect:/board/reviewRead/" + dto.getReview_idx() + "?page=1";
		ModelAndView mav = new ModelAndView(path);
		int row = bs.reviewWrite(dto);
		System.out.println("댓글 작성 성공");
		return mav;
	}
	
//	@GetMapping("/notice")
//	public ModelAndView notice(String type, String keyword, int page) {
//		
//	}
	
}
