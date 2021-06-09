package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.BoardDAO;
import com.itbank.dto.BoardDTO;

@Service
public class BoardService {
	
	@Autowired private BoardDAO dao;

	public BoardDTO boardListAll() {
		return dao.boardListAll();
	}
}
