package com.itbank.dao;

import org.apache.ibatis.annotations.Select;

import com.itbank.dto.OrderDTO;

public interface CustomerDAO {

	@Select("select * from service where idx=1")
	OrderDTO crmOrder(String c_word);
	
	

}
