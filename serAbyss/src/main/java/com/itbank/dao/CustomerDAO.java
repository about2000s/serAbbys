package com.itbank.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.itbank.dto.CustomerDTO;
import com.itbank.dto.OrderDTO;

public interface CustomerDAO {

	@Select("select * from service where ${selectedWord} = #{word}" )
	List<OrderDTO> crmOrder(HashMap<String, String> param);

	@Select("select * from customer where customer_service_idx=${service_idx}")
	List<HashMap<String, String>> selectList(int service_idx);


//	List<CustomerDTO> csCommentWrite(HashMap<String, String> param);
	
	

}
