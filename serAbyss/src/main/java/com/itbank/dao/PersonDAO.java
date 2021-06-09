package com.itbank.dao;

import org.apache.ibatis.annotations.Select;

import com.itbank.dto.PersonDTO;

public interface PersonDAO {

	@Select("select count(*) from person where person_id=#{id}")
	int selectOne(String id);

	@Select("select count* from person where membre_id=#{membre_id} and member_pw=#{member_pw}")
	PersonDTO personLogin(PersonDTO dto);

	@Select("select count* from person where membre_id=#{membre_id} and member_pw=#{member_pw} and belong is not null")
	PersonDTO companyLogin(PersonDTO dto);

	int join(PersonDTO inputData);

}
