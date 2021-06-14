package com.itbank.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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

	@Update("update service set service_title=#{service_title}, service_content=#{service_content}, "
			+ "service_uploadFile='${service_uploadFile}', service_address=#{service_address}, service_reg=to_char(sysdate, 'yyyy-MM-dd hh24:mi') "
			+ "where service_idx=#{service_idx}")
	int modify(OrderDTO dto);

	@Delete("delete from service where service_idx=#{idx}")
	int delete(int idx);

}