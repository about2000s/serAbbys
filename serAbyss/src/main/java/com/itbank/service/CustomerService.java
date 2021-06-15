package com.itbank.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.CustomerDAO;
import com.itbank.dto.OrderDTO;

@Service
public class CustomerService {
	
	@Autowired
	private CustomerDAO dao;

	public OrderDTO crmOrder(Map<String, String> param) {
		return dao.crmOrder(param);
	}
	
	

}
