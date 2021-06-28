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
	int selectOne(String id);	// 넘겨받은 id값의 정보가 존재하는지 여부를 판단
	
	@Select("select * from person where person_id=#{person_id} and person_pw=#{person_pw} and person_check='n'")
	PersonDTO personLogin(PersonDTO dto);	// id와 pw, person_check 값이 일치하는 자료값을 PersonDTO 형식으로 반환
	
	//sqlmap-person.xml에 있습니다
	PersonDTO companyLogin(PersonDTO dto);

	//sqlmap-person.xml에 있습니다
	int join(PersonDTO inputData);

	@Select("select person_id from person where person_name=#{person_name} and person_phone=#{person_phone}")
	String findIdByPhone(PersonDTO inputData);	// 입력받은 name, phone 값과 일치하는 계정의 id값을 반환
	
	@Select("select person_id from person where person_name=#{person_name} and person_email=#{person_email}")
	String findIdByEmail(PersonDTO inputData);	// 입력받은 name, email 값과 일치하는 계정의 id값을 반환
	
	
	@Select("select * from person where person_id=#{person_id} and person_phone=#{person_phone}")
	PersonDTO repwByPhone(PersonDTO inputData);	// 입력받은 id, phone 값과 일치하는 계정의 정보값을 반환
	
	@Select("select * from person where person_id=#{person_id} and person_email=#{person_email}")
	PersonDTO repwByEmail(PersonDTO inputData);	// 입력받은 id, email 값과 일치하는 계정의 정보값을 반환
	
	//sqlmap-person.xml에 있습니다
	int selectOneCheckIdPw(PersonDTO inputData);
	
	@Update("update person set person_pw=#{person_pw} where person_id=#{person_id}")
	int updatePw(PersonDTO inputData);	// 입력받은 id 값과 일치하는 계정의 pw값을 입력받은 pw로 갱신
	
	@Select("select nvl(count(*), 0) from person where person_id=#{person_id}")
	int idCheck(String person_id);	// 이건 제가 적은게 아니라서 nvl이 뭔지 잘 모르겠네요


	@Insert("insert into companyList (companyList_idx, companyList_name, companyList_address) "
			+ "values (companyList_seq.nextval, #{companyList_name}, #{companyList_address})")
	int companyAdd(CompDTO comp);	// 입력받은 기업 정보값을 companyList에 추가

	@Insert("insert into reserve (year, month, day, hour) values (2021, #{i}, #{j}, #{k})")
	int timePlus(HashMap<String, Integer> map);	// 예약정보 같은데 이것도 제가 적은게 아닌것 같네요

	@Select("select nvl(count(*), 0) from person where person_email=#{person_email}")
	int emailCheck(String person_email);

	@Select("select * from companyList where companyList_name like '%${companyList_name}%'")
	List<HashMap<String, String>> compSearchList(String companyList_name);	// 입력받은 기업 검색내용을 토대로 companyList에 회사 정보 검색

	@Update("update person set person_email=#{person_Email} where person_id=#{person_id}")
	int updateEmail(PersonDTO dto);	// 입력받은 id 값과 일치하는 계정의 Email값을 입력받은 정보값으로 갱신

	@Update("update person set person_address=#{person_address} where person_id=#{person_id}")
	int updateAddress(PersonDTO dto);	// 입력받은 id 값과 일치하는 계정의 주소값을 입력받은 정보값으로 갱신

	@Select("select * from person where person_id=#{login_id}")
	PersonDTO selectOneById(String login_id);	// 입력받은 id 값과 일치하는 계정값을 반환

	@Update("update person set person_fax=#{person_fax} where person_idx=#{person_idx}")
	int updateFax(PersonDTO login);	// 입력받은 id 값과 일치하는 계정의 팩스번호를 입력받은 정보값으로 갱신

	@Update("update person set person_call=#{person_call} where person_idx=#{person_idx}")
	int updateCall(PersonDTO login);	// 입력받은 id 값과 일치하는 계정의 핸드폰번호를 입력받은 정보값으로 갱신

	@Select("select count(*) from person where person_name=#{person_name} and person_email=#{person_email}")
	int emailNameCheck(PersonDTO inputData);	// 입력받은 name과 email 값과 일치하는 계정의 정보의 갯수 반환, 있다면 1, 없다면 0
	
	@Select("select count(*) from person where person_id=#{person_id} and person_email=#{person_email}")
	int emailIdCheck(PersonDTO inputData);	// 입력받은 name과 email 값과 일치하는 계정의 정보의 갯수 반환, 있다면 1, 없다면 0

	@Update("update person set person_pw=#{person_pw} where person_id=#{person_id}")
	void replacePw(PersonDTO inputData);	// 입력받은 id와 일치하는 계정의 pw값을 입력받은 pw값으로 갱신
	
}
