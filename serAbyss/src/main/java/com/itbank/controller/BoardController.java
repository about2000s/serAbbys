package com.itbank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itbank.dto.BoardDTO;
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

	
}
