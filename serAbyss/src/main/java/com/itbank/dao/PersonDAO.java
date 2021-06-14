package com.itbank.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.itbank.dto.CompDTO;
import com.itbank.dto.PersonDTO;

public interface PersonDAO {

	@Select("select count(*) from person where person_id=#{id}")
	int selectOne(String id);
	
	@Select("select * from person where person_id=#{person_id} and person_pw=#{person_pw} and person_check='n'")
	PersonDTO personLogin(PersonDTO dto);
	
	@Select("select * from person where person_id=#{person_id} and person_pw=#{person_pw} and person_check='y'")
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
	
	@Select("select nvl(count(*), 0) from person where person_id=#{person_id}")
	int idCheck(String person_id);

	@Select("select min(person_idx) from person where person_belong=#{person_belong}")
	int getMinIdx(String person_belong);

	@Insert("insert into companyList (companyList_idx, companyList_name, companyList_address) "
			+ "values (companyList_seq.nextval, #{companyList_name}, #{companyList_address})")
	int companyAdd(CompDTO comp);

	@Insert("insert into reserve (year, month, day, hour) values (2021, #{i}, #{j}, #{k})")
	int timePlus(HashMap<String, Integer> map);

	@Select("select nvl(count(*), 0) from person where person_email=#{person_email}")
	int emailCheck(String person_email);

	@Select("select * from companyList where companyList_name like '%${companyList_name}%'")
	List<HashMap<String, String>> compSearchList(String companyList_name);
	
}
