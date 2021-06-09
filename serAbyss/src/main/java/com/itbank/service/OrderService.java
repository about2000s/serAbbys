package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.OrderDAO;
import com.itbank.dto.OrderDTO;

@Service
public class OrderService {

	@Autowired OrderDAO dao;
	
	public List<OrderDTO> selectall() {
		return dao.selectall();
	}
	
	public List<OrderDTO> selectStatus(String status) {
		return dao.selectStatus(status);
	}


}
