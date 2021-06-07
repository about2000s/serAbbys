package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.ReviewBoardDAO;

@Service
public class ReviewBoardService {
	@Autowired private ReviewBoardDAO dao;
}
