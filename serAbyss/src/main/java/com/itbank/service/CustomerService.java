package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.CustomerDAO;
import com.itbank.dto.OrderDTO;

@Service
public class CustomerService {
	
	@Autowired
	private CustomerDAO dao;

	public List<OrderDTO> crmOrder(HashMap<String, String> param) {
		return dao.crmOrder(param);
	}

	public List<HashMap<String, String>> selectList(int service_idx) {
		return dao.selectList(service_idx);
	}



//	public List<CustomerDTO> csCommentWrite(HashMap<String, String> param) {
//		return dao.csCommentWrite(param);
//	}
	
	

}
