package com.itbank.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.itbank.dto.OrderDTO;

public interface OrderDAO {

	@Select("select * from service order by service_idx")
	List<OrderDTO> selectall();

	@Select("select * from service where service_status=#{status} order by service_idx")
	List<OrderDTO> selectStatus(String status);

	@Select("select * from service where service_idx=#{idx}")
	OrderDTO selectOne(int idx);

	@Insert("insert into service (service_idx, service_id, service_title, service_content, "
			+ "service_address, service_engiId, service_uploadFile, service_status)"
			+ "values (service_seq.nextval, #{service_id}, #{service_title}, #{service_content}, "
			+ "#{service_address}, #{service_engineer}, '${service_uploadFile}', #{service_status})")
	int order(OrderDTO dto);

}