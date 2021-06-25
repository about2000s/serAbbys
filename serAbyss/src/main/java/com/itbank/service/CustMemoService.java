package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.CustMemoDAO;
import com.itbank.dto.CustMemoDTO;
import com.itbank.dto.ReserveDTO;

@Service
public class CustMemoService {
	
	@Autowired
	private CustMemoDAO dao;

	public List<ReserveDTO> crmOrder(HashMap<String, String> map) {
		return dao.crmReserve(map);
	}

	public List<HashMap<String, String>> selectList(int reserve_idx) {
		return dao.selectList(reserve_idx);
	}

	public int insert(CustMemoDTO dto) {
		return dao.insert(dto);
	}

	public List<HashMap<String, String>> crmRead(int reserve_idx) {
		return dao.crmRead(reserve_idx);
	}



//	public List<CustomerDTO> csCommentWrite(HashMap<String, String> param) {
//		return dao.csCommentWrite(param);
//	}
	
	

}
