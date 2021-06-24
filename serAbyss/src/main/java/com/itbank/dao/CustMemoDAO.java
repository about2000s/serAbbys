package com.itbank.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.itbank.dto.CustMemoDTO;
import com.itbank.dto.ReserveDTO;

public interface CustMemoDAO {

	@Select("select * from reserve where ${selectedWord} = #{word}" )
	List<ReserveDTO> crmReserve(HashMap<String, String> param);

	@Select("select * from custMemo where custMemo_reserve_idx=${reserve_idx}")
	List<HashMap<String, String>> selectList(int reserve_idx);

	@Insert("insert into custMemo values (custMemo_seq.nextval , #{custMemo_comments}, to_char(sys_date,'yyyy-MM-dd hh24:mi'), #{custMemo_reserve_idx})")
	int insert(CustMemoDTO dto);
	
	@Select("select * from custMemo where custMemo_reserve_idx=${reserve_idx}") //고객 응대 기록 가져오기
	List<CustMemoDTO> crmRead(int reserve_idx);
	
	
	//@Insert("insert into customer values ( customer_seq.nextval , customer_comments=${custMemo} , "
		//	+ "customer_reg=to_char(sysdate, 'yyyy-MM-dd hh24:mi') , customer_reserve_idx=${reserve_idx}" )
	//Integer crmInsert(HashSet<String, Integer> recordOne);


//	List<CustomerDTO> csCommentWrite(HashMap<String, String> param);
	
	

}
