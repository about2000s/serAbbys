package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.CustomerDAO;
import com.itbank.dto.OrderDTO;

@Service
public class CustomerService {
	
	@Autowired
	private CustomerDAO dao;

	public OrderDTO crmOrder(String c_word) {
		return dao.crmOrder(c_word);
	}
	
	

}
