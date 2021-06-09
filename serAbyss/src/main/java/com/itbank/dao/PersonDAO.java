package com.itbank.dao;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.itbank.dto.PersonDTO;

public interface PersonDAO {

	@Select("select count(*) from person where person_id=#{id}")
	int selectOne(String id);
	//오타났네여 membre -> person으로 변경했습니다.
	@Select("select * from person where person_id=#{person_id} and person_pw=#{person_pw}")
	PersonDTO personLogin(PersonDTO dto);
	//오타났네여 membre -> person로 변경했습니다.
	@Select("select * from person where person_id=#{person_id} and person_pw=#{person_pw} and belong is not null")
	PersonDTO companyLogin(PersonDTO dto);

	//sqlmap-person.xml에 있습니다
	int join(PersonDTO inputData);

	@Select("select person_id from person where person_name=#{person_name} and person_phone=#{person_phone}")
	String findIdByPhone(PersonDTO inputData);
	
	@Select("select person_id from person where person_name=#{person_name} and person_phone=#{person_phone}")
	String findIdByEmail(PersonDTO inputData);
	
	
	@Select("select * from person where person_id=#{person_id} and person_phone=#{person_phone}")
	PersonDTO repwByPhone(PersonDTO inputData);
	
	@Select("select * from person where person_id=#{person_id} and person_email=#{person_email}")
	PersonDTO repwByEmail(PersonDTO inputData);
	
	//sqlmap-person.xml에 있습니다
	int selectOneCheckIdPw(PersonDTO inputData);
	
	@Update("update person set person_pw=#{person_pw} where person_id=#{person_id}")
	int updatePw(PersonDTO inputData);
	
}
