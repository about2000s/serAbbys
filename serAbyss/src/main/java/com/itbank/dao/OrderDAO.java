package com.itbank.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.itbank.dto.OrderDTO;

public interface OrderDAO {

	List<OrderDTO> selectall(HashMap<String, String> param);

	List<OrderDTO> selectStatus(HashMap<String, String> param);

	@Select("select * from service where service_idx=#{idx}")
	OrderDTO selectOne(int idx);

	@Insert("insert into service (service_idx, service_custid, service_title, service_content, "
			+ "service_address, service_engiId, service_uploadFile1, service_status)"
			+ "values (service_seq.nextval, #{service_custid}, #{service_title}, #{service_content}, "
			+ "#{service_address}, #{service_engiId}, '${service_uploadFile1}', #{service_status})")
	int order(OrderDTO dto);

	@Update("update service set service_title=#{service_title}, service_content=#{service_content}, "
			+ "service_uploadFile1='${service_uploadFile1}', service_address=#{service_address}, service_reg=to_char(sysdate, 'yyyy-MM-dd hh24:mi') "
			+ "where service_idx=#{service_idx}")
	int modify(OrderDTO dto);

	@Delete("delete from service where service_idx=#{idx}")
	int delete(int idx);

}