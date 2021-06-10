package com.itbank.service;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.PersonDAO;
import com.itbank.dto.PersonDTO;

@Service
public class PersonService {
	@Autowired private PersonDAO dao;
	
	//해시처리 메서드
	private String getHash(String text){
		String hash = null;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			md.reset();
			md.update(text.getBytes("UTF-8"));
			hash = String.format("%0128x", new BigInteger(1, md.digest()));
		}catch(NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return hash;
	}
	
	//랜덤비밀번호 받아오는 메서드
	public String randomPw() {
		return UUID.randomUUID().toString().split("-")[0];
	}

	public int selectOne(String id) {
		int row = dao.selectOne(id);
		return row;
	}

	public PersonDTO personLogin(PersonDTO dto) {
		return dao.personLogin(dto);
	}

	public PersonDTO companyLogin(PersonDTO dto) {
		return dao.companyLogin(dto);
	}

	public int join(PersonDTO inputData) {
		return dao.join(inputData);
	}

	public String findIdByPhone(PersonDTO inputData) {
		return dao.findIdByPhone(inputData);
	}
	public String findIdByEmail(PersonDTO inputData) {
		return dao.findIdByEmail(inputData);
	}

	public String repwByPhone(PersonDTO inputData) {
		PersonDTO dto = dao.repwByPhone(inputData);
		String randomPw = randomPw();//UUID 써서 임시 비밀번호 만들고
		dto.setperson_pw(getHash(randomPw));//그 임시비밀번호를 해시처리 후 dto에 셋팅.
		return randomPw;
	}
	//메소드가 완전히 겹치지만... dao에서는 다르게 처리하기 때문에 일단 분리해뒀습니다.
	//나중에 동적쿼리 쓸 여유 되면 합쳐보겠습니다.
	public String repwByEmail(PersonDTO inputData) {
		PersonDTO dto = dao.repwByEmail(inputData);
		String randomPw = randomPw();//UUID 써서 임시 비밀번호 만들고
		dto.setperson_pw(getHash(randomPw));//그 임시비밀번호를 해시처리 후 dto에 셋팅.
		return randomPw;
	}

	public int selectOneCheckIdPw(PersonDTO inputData) {
		return dao.selectOneCheckIdPw(inputData);
	}

	public int updatePw(PersonDTO inputData) {
		String hash = getHash(inputData.getperson_pw());
		inputData.setperson_pw(getHash(hash));
		return dao.updatePw(inputData);
	}
}
