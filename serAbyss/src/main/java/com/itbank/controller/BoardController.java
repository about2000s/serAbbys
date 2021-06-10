package com.itbank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.dto.BoardDTO;
import com.itbank.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService bs;

	@GetMapping("/review_list_all")
	public ModelAndView boardListAll() {
		ModelAndView mav = new ModelAndView();
		BoardDTO dto = bs.boardListAll();
		int starScore = dto.getReview_starScore();
		String star = "";
		for (int i = 0; i < starScore; i++) {
			star += "★";
		}
		for (int i = 0; i < 10 - starScore; i++) {
			star += "☆";
		}
		mav.addObject("dto", dto);
		mav.addObject("star", star);

		return mav;
	}

}
