package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.ReplyDAO;

@Service
public class ReplyService {
	@Autowired private ReplyDAO dao;
	
}
