package com.itbank.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.itbank.dto.OrderDTO;

public interface CustomerDAO {

	@Select("select * from service where ${selectedWord} = #{word}" )
	List<OrderDTO> crmOrder(HashMap<String, String> param);

	@Select("select * from customer where customer_service_idx=${service_idx}")
	List<HashMap<String, String>> selectList(int service_idx);
	
	
	//@Insert("insert into customer values ( customer_seq.nextval , customer_comments=${custMemo} , "
		//	+ "customer_reg=to_char(sysdate, 'yyyy-MM-dd hh24:mi') , customer_service_idx=${service_idx}" )
	//Integer crmInsert(HashSet<String, Integer> recordOne);


//	List<CustomerDTO> csCommentWrite(HashMap<String, String> param);
	
	

}
