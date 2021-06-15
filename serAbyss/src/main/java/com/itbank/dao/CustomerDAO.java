package com.itbank.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import com.itbank.dto.OrderDTO;

public interface CustomerDAO {

	@Select("select * from service where ${selectedWord} = #{word}" )
	OrderDTO crmOrder(Map<String, String> param);
	
	

}
