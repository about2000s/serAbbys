package com.itbank.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.itbank.dto.OrderDTO;

public interface OrderDAO {

	@Select("select * from service")
	List<OrderDTO> selectall();

	@Select("select * from service where service_status=#{status}")
	List<OrderDTO> selectStatus(String status);

}