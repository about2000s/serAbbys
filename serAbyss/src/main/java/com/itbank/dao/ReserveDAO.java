package com.itbank.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.itbank.dto.ReserveDTO;
import com.itbank.dto.CustMemoDTO;
import com.itbank.dto.PersonDTO;
import com.itbank.dto.ReserveTimeDTO;
import com.itbank.dto.ReviewBoardDTO;

public interface ReserveDAO {

	List<ReserveDTO> selectStatus(HashMap<String, Object> param);

	@Select("select * from reserve where reserve_idx=#{idx}")
	ReserveDTO selectOne(int idx);

	@Insert("insert into reserve (reserve_idx, reserve_custId, reserve_title, reserve_content, "
			+ "reserve_status, reserve_address, reserve_engiId, reserve_compBelong, reserve_name, reserve_phone)"
			+ "values (reserve_seq.nextval, #{reserve_custId}, #{reserve_title}, #{reserve_content}, "
			+ "#{reserve_status}, #{reserve_address}, #{reserve_engiId}, "
			+ "#{reserve_compBelong}, #{reserve_name}, #{reserve_phone})")
	int reserve(ReserveDTO dto);

	@Update("update reserve set reserve_title=#{reserve_title}, reserve_content=#{reserve_content}, "
			+ "reserve_reg=to_char(sysdate, 'yyyy-MM-dd hh24:mi') "
			+ "where reserve_idx=#{reserve_idx}")
	int modify(ReserveDTO dto);

	@Delete("delete from reserve where reserve_idx=#{idx}")
	int delete(int idx);

	@Select("select * from reserveTime where reserveTime_year=#{reserveTime_year} "
			+ "and reserveTime_month=#{reserveTime_month} and reserveTime_day=#{reserveTime_day} "
			+ " and reserveTime_hour=#{reserveTime_hour} and reserveTime_engiId=#{reserveTime_engiId}")
	ReserveTimeDTO selectReserveOne(ReserveTimeDTO inputData);

	@Select("select person_id from person where person_check='y'")
	List<String> selectEngiIdAll();

	@Insert("insert into reserveTime (reserveTime_idx, reserveTime_year, reserveTime_month, reserveTime_day, reserveTime_hour, reserveTime_engiId,  reserveTime_custId) " + 
			"    values(reserveTime_seq.nextval, '2021', '06', '16', '14', 'kim123', 'lee123');")
	int setReserve(ReserveDTO reserveTimeDTO);
	
//	int selectBoardCountList(HashMap<String, String> param);

	@Update("update reserve set reserve_status=#{reserve_status} where reserve_idx=#{reserve_idx}")
	int change_status(ReserveDTO dto);

	@Select("select * from person where person_id=#{reserve_custId}")
	PersonDTO selectOneById(String reserve_custId);

	@Insert("insert into reserveTime (reserveTime_idx, reserveTime_year, reserveTime_month, reserveTime_day, reserveTime_hour, reserveTime_engiId,  reserveTime_custId)" + 
			"    values(reserveTime_seq.nextval, #{reserveTime_year}, #{reserveTime_month}, #{reserveTime_day}, #{reserveTime_hour}, #{reserveTime_engiId}, #{reserveTime_custId})")
	int insertReserve(ReserveTimeDTO reserveTimeDTO);


	// order-order.xml에 있습니다
	int statusListCount(HashMap<String, Object> map);

	@Select("select * from review where review_idx=#{reserve_idx}")
	ReviewBoardDTO alreadyReviewWrite(int reserve_idx);

	@Select("select * from custMemo where custMemo_reserve_idx=#{reserve_idx}")
	ArrayList<CustMemoDTO> custMemoList(int reserve_idx);

}