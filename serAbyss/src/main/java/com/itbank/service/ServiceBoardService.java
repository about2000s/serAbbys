package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.ServiceBoardDAO;

@Service
public class ServiceBoardService {
	@Autowired private ServiceBoardDAO dao;
}
