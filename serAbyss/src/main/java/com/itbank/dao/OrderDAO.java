package com.itbank.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.itbank.dto.OrderDTO;
import com.itbank.dto.PersonDTO;
import com.itbank.dto.ReserveDTO;

public interface OrderDAO {

	List<OrderDTO> selectall(HashMap<String, String> param);

	List<OrderDTO> selectStatus(HashMap<String, String> param);

	@Select("select * from service where service_idx=#{idx}")
	OrderDTO selectOne(int idx);

	@Insert("insert into service (service_idx, service_custId, service_title, service_content, "
			+ "service_status, service_address, service_uploadFile1, service_engiId, service_compBelong, service_name, service_phone)"
			+ "values (service_seq.nextval, #{service_custId}, #{service_title}, #{service_content}, "
			+ "#{service_status}, #{service_address}, '${service_uploadFile1}', #{service_engiId}, "
			+ "#{service_compBelong}, #{service_name}, #{service_phone})")
	int order(OrderDTO dto);

	@Update("update service set service_title=#{service_title}, service_content=#{service_content}, "
			+ "service_uploadFile1='${service_uploadFile1}', service_address=#{service_address}, service_reg=to_char(sysdate, 'yyyy-MM-dd hh24:mi') "
			+ "where service_idx=#{service_idx}")
	int modify(OrderDTO dto);

	@Delete("delete from service where service_idx=#{idx}")
	int delete(int idx);

	@Select("select * from reserve where reserve_year=#{reserve_year} and reserve_month=#{reserve_month} and reserve_day=#{reserve_day} and reserve_hour=#{reserve_hour} and reserve_engiId=#{reserve_engiId}")
	ReserveDTO selectReserveOne(ReserveDTO inputData);

	@Select("select person_id from person where person_check='y'")
	List<String> selectEngiIdAll();

//	@Insert("insert into reserve (reserve_idx, reserve_year, reserve_month, reserve_day, reserve_hour, reserve_engiId,  reserve_custId) " + 
//			"    values(reserve_seq.nextval, '2021', '06', '16', '14', 'kim123', 'lee123');")
//	int setReserve(ReserveDTO reserveDTO);
	int selectBoardCountList(HashMap<String, String> param);

	@Select("select * from person where person_id=#{service_custId}")
	PersonDTO selectOneById(String service_custId);

	@Insert("insert into reserve (reserve_idx, reserve_year, reserve_month, reserve_day, reserve_hour, reserve_engiId,  reserve_custId)" + 
			"    values(reserve_seq.nextval, #{reserve_year}, #{reserve_month}, #{reserve_day}, #{reserve_hour}, #{reserve_engiId}, #{reserve_custId})")
	int insertReserve(ReserveDTO reserveDTO);

}