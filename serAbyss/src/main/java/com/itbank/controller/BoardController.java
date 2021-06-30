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

import com.itbank.dto.ReserveDTO;
import com.itbank.dto.ReplyDTO;
import com.itbank.dto.ReviewBoardDTO;
import com.itbank.dto.SerCenDTO;
import com.itbank.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService bs;

	//리뷰글의 모든 리스트 보러 가기
	@GetMapping("/review_list_all")
	public ModelAndView boardListAll(String type, String keyword, int page) {
		ModelAndView mav = new ModelAndView("board/review_list_all");
		HashMap<String, Object> map = bs.reviewJob(type, keyword, page);//리뷰글의 페이징 작업 수행하는 메서드
		mav.addObject("map", map);
		mav.addObject("page", page);
		return mav;
	}

	//고객센터로 가기(자주 묻는 질문)
	@GetMapping("/faq")
	public ModelAndView faq(String type, String keyword, int page) {
		ModelAndView mav = new ModelAndView("board/faq");
		HashMap<String, Object> map = bs.faqJob(type, keyword, page);//FAQ글의 페이징 작업 수행하는 메서드
		mav.addObject("map", map);
		mav.addObject("page", page);
		return mav;
	}
	//고객센터로 가기(공지사항)
	@GetMapping("/notice")
	public ModelAndView notice(String type, String keyword, int page) {
		ModelAndView mav = new ModelAndView("board/notice");
		HashMap<String, Object> map = bs.noticeJob(type, keyword, page);//공지사항글의 페이징 작업 수행하는 메서드
		mav.addObject("map", map);
		mav.addObject("page", page);
		return mav;
	}
	
	//고객센터의 글 읽기
	@GetMapping("/serCenRead/{serCen_idx}")
	public ModelAndView serCenRead(@PathVariable int serCen_idx, @RequestParam HashMap<String, Object> map) {
		ModelAndView mav = new ModelAndView("board/serCenRead");
		map.put("serCen_idx", serCen_idx);
		int row = bs.serCenViewCountPlus(serCen_idx);//조회수 1 증가시키는 메서드
		SerCenDTO dto = bs.selectOneSerCen(serCen_idx);//idx값을 이용해 게시글 하나를 불러오는 메서드
		mav.addObject("dto", dto);
		mav.addObject("map", map);
		return mav;
	}
	
	//고객센터 글 수정하는 페이지로 이동
	@GetMapping("/serCenModify/{serCen_idx}")
	public ModelAndView serCenModify(@PathVariable int serCen_idx, @RequestParam HashMap<String, Object> map) {
		ModelAndView mav = new ModelAndView("board/serCenModify");
		SerCenDTO dto = bs.selectOneSerCen(serCen_idx);//idx값을 이용해 게시글 하나를 불러오는 메서드
		mav.addObject("map", map);
		mav.addObject("dto", dto);
		return mav;
	}
	//고객센터 글 수정하기
	@PostMapping("/serCenModify/{serCen_idx}")
	public ModelAndView serCenModify(@PathVariable int serCen_idx, SerCenDTO inputData, @RequestParam HashMap<String, Object> map) {
		String path = "redirect:/board/serCenRead/" + serCen_idx
				+ "?type=" + map.get("type")
				+ "&keyword=" + map.get("keyword")
				+ "&page=" + map.get("page");
		ModelAndView mav = new ModelAndView(path);//글이 수정되면 바로 수정된 글을 읽는 페이지로 가겠다.
		int row = bs.serCenModify(inputData);//SerCenDTO 객체를 매개변수로 해서 고객센터 글 수정하는 메서드
		String msg = null;
		if(row == 1) {
			msg = "글수정 성공";
			mav.addObject("msg", msg);
		}
		System.out.println("글 수정 성공");
		return mav;
	}
	
	//고객센터 글 쓰는 페이지로 이동
	@GetMapping("/serCenWrite")
	public ModelAndView serCenWrite(String serCen_belong) {
		ModelAndView mav = new ModelAndView("board/serCenWrite");
		mav.addObject("serCen_belong", serCen_belong);//내가 작성하는 고객센터 글이 FAQ인지, 공지사항인지 알 수 있게 한다!
		return mav;
	}
	//고객센터 글 쓰기
	@PostMapping("/serCenWrite")
	public ModelAndView serCenWrite(SerCenDTO dto) {
		ModelAndView mav = new ModelAndView();
		String path = null;
		int row = bs.serCenWrite(dto);
		if(row != 0) {
			if(dto.getSerCen_belong().equals("faq")) {//belong값이 faq이면 FAQ 첫 페이지로 이동
				path = "redirect:/board/faq?page=1";
			}
			if(dto.getSerCen_belong().equals("notice")) {//belong값이 notice이면 공지사항 첫 페이지로 이동
				path = "redirect:/board/notice?page=1";
			}
		}
		mav.setViewName(path);
		return mav;
	}
	
	//리뷰글 읽기
	@GetMapping("/reviewRead/{review_idx}")
	public ModelAndView reviewRead(@PathVariable int review_idx, @RequestParam HashMap<String, Object> map) {
		ModelAndView mav = new ModelAndView("board/reviewRead");
		ReviewBoardDTO dto = bs.selectOneReview(review_idx);//idx값을 통해 리뷰글 하나를 받아오는 메서드
		int row = bs.reviewViewCountPlus(dto);//리뷰글 조회수 증가하는 메서드
		List<ReplyDTO> replyList = bs.replyList(review_idx);//댓글리스트 담는 메서드
		
		int replyCount = replyList.size();//댓글 개수
		int nowD = 10;//현재 한 페이지에서 보여줄 최대 댓글 개수
		int replyPageCount = replyCount%nowD == 0 ? replyCount/nowD : replyCount/nowD + 1;//댓글 페이지 개수
		
		List<Integer> replyPageList = new ArrayList<Integer>();//페이지번호(1, 2, 3 .. )를 리스트에 ArrayList로 담는다.
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
		ModelAndView mav = new ModelAndView(path);//댓글작성이 완료되면 내가 댓글 쓴 게시글을 read하는 페이지로 이동하겠다.
		int row = bs.replyWrite(dto);//댓글 작성하는 메서드
		if(row != 0) {
			System.out.println("댓글 작성 성공");
		}
		return mav;
	}
	
	//리뷰글 수정하는 페이지로 이동하기
	@GetMapping("/reviewModify/{review_idx}")
	public ModelAndView reviewUpdate(@PathVariable int review_idx, @RequestParam HashMap<String, Object> map) {
		ModelAndView mav = new ModelAndView("board/reviewModify");
		ReviewBoardDTO dto = bs.selectOneReview(review_idx);//idx값을 통해 리뷰글 하나를 받아오는 메서드
		mav.addObject("dto", dto);
		mav.addObject("map", map);
		return mav;
	}
	//리뷰글 수정하기
	@PostMapping("/reviewModify/{review_idx}")
	public ModelAndView reviewUpdate(@PathVariable int review_idx, ReviewBoardDTO inputData, @RequestParam HashMap<String, Object> map) {
		String path = "redirect:/board/reviewRead/" + review_idx
				+ "?type=" + map.get("type")
				+ "&keyword=" + map.get("keyword")
				+ "&page=" + map.get("page");
		ModelAndView mav = new ModelAndView(path);//리뷰가 작성되면 작성된 글을 바로 read하는 페이지로 이동하겠다!
		int row = bs.reviewUpdate(inputData);//리뷰글 수정하는 메서드
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
	@GetMapping("/reviewWrite")
	public ModelAndView reviewWrite(int reserve_idx) {
		ModelAndView mav = new ModelAndView("board/reviewWrite");
		ReserveDTO dto = bs.selectOneByIdx(reserve_idx);//idx값을 통해 리뷰글 하나를 받아오는 메서드
		mav.addObject("dto", dto);
		return mav;
	}
	//리뷰글 작성하기
	@PostMapping("/reviewWrite")
	public ModelAndView reviewWrite(ReviewBoardDTO dto) {
		String path = "redirect:/board/reviewRead/" + dto.getReview_idx() + "?page=1";
		ModelAndView mav = new ModelAndView(path);//작성한 리뷰글로 redirect
		int row = bs.reviewWrite(dto);
		System.out.println("댓글 작성 성공");
		return mav;
	}
	
	@GetMapping("/reviewDelete/{review_idx}")
	public ModelAndView reviewDelete(@PathVariable int review_idx) {
		ModelAndView mav = new ModelAndView("redirect:/board/review_list_all");
		int row = bs.reviewDelete(review_idx);
		System.out.println("리뷰 삭제 성공");
		
		return mav;
	}
	
	@GetMapping("/replyDelete/{reply_idx}")
	public ModelAndView replyDelete(@PathVariable int reply_idx) {
		System.out.println(reply_idx);
		int review_idx = bs.selectReview_idx(reply_idx);
		ModelAndView mav = new ModelAndView("redirect:/board/reviewRead/" + review_idx + "?page=1");
		int row = bs.replyDelete(reply_idx);
		System.out.println("리뷰 삭제 성공");
		
		return mav;
	}
	
	
}
