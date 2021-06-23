package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.CustMemoDAO;
import com.itbank.dto.CustMemoDTO;
import com.itbank.dto.ReserveDTO;

@Service
public class CustomerService {
	
	@Autowired
	private CustMemoDAO dao;

	public List<ReserveDTO> crmOrder(HashMap<String, String> param) {
		return dao.crmReserve(param);
	}

	public List<HashMap<String, String>> selectList(int service_idx) {
		return dao.selectList(service_idx);
	}

	public int insert(CustMemoDTO dto) {
		return dao.insert(dto);
	}



//	public List<CustomerDTO> csCommentWrite(HashMap<String, String> param) {
//		return dao.csCommentWrite(param);
//	}
	
	

}
