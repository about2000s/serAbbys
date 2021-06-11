package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.dto.BoardDTO;
import com.itbank.dto.ServiceBoardDTO;
import com.itbank.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService bs; 
	
	@GetMapping	("/review_list_all")
	public String boardListAll() {
		
		BoardDTO dto = bs.boardListAll();
		

		return "board/review_list_all";
		}

	
	
	//여기서 부터 재훈이가 건드렸습니다
	@GetMapping("/myCompList/{person_belong}")
	public ModelAndView myCompList(@PathVariable String person_belong) {
		ModelAndView mav = new ModelAndView("board/myCompList");
		List<ServiceBoardDTO> list = bs.myCompList(person_belong);
		mav.addObject("list", list);
		return mav;
	}
	
	@GetMapping("myList/{person_id}")
	public ModelAndView myList(@PathVariable String person_id) {
		ModelAndView mav = new ModelAndView("board/myList");
		List<ServiceBoardDTO> list = bs.myList(person_id);
		mav.addObject("list", list);
		return mav;
		
	}
}
