package com.itbank.service;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
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
		dto.setPerson_pw(getHash(randomPw));//그 임시비밀번호를 해시처리 후 dto에 셋팅.
		return randomPw;
	}
	//메소드가 완전히 겹치지만... dao에서는 다르게 처리하기 때문에 일단 분리해뒀습니다.
	//나중에 동적쿼리 쓸 여유 되면 합쳐보겠습니다.
	public String repwByEmail(PersonDTO inputData) {
		PersonDTO dto = dao.repwByEmail(inputData);
		String randomPw = randomPw();//UUID 써서 임시 비밀번호 만들고
		dto.setPerson_pw(getHash(randomPw));//그 임시비밀번호를 해시처리 후 dto에 셋팅.
		return randomPw;
	}

	public int selectOneCheckIdPw(PersonDTO inputData) {
		return dao.selectOneCheckIdPw(inputData);
	}

	public int updatePw(PersonDTO inputData) {
//		String hash = getHash(inputData.getPerson_pw());
//		inputData.setPerson_pw(getHash(hash));
		return dao.updatePw(inputData);
	}

	public int idCheck(PersonDTO dto) {
		return dao.idCheck(dto);
	}
	
	//자기 회사의 최소 인덱스 구하는 메서드(이 인덱스번호와 일치하는 계정은, 대표계정임을 알 수 있음)
	public int getMinIdx(String person_belong) {
		return dao.getMinIdx(person_belong);
	}

	//내가 로그인한 계정이 회사의 대표계정이냐의 여부를 판별해주는 메서드
	public boolean iamCeo(PersonDTO login) {
		int minIdx = getMinIdx(login.getPerson_belong());
		if(login.getPerson_idx() != minIdx) {
			System.out.println("회사 대표계정이 아닌 직원이네요");
			return false;
		}
		else {
			System.out.println("회사 대표계정이네요!");
			return true;
		}
	}

	public int companyAdd(String person_belong) {
		return dao.companyAdd(person_belong);
	}

	public void timePlus() {//월 일 시
		int i = 1;
		int j = 1;
		int k = 1;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		for(i=6;i<=12;i++) {
			for(j=1;j<=31;j++) {
				for(k=8;k<=22;k+=2) {
					map.put("i", i);
					map.put("j", j);
					map.put("k", k);
					int row = dao.timePlus(map);
				}
			}
		}
	}
}
