package com.itbank.dao;

import org.apache.ibatis.annotations.Select;

import com.itbank.dto.BoardDTO;

public interface BoardDAO {

	@Select("select * from reviewboard where service_idx  = #{service_idx }")
	BoardDTO boardListAll();

}
