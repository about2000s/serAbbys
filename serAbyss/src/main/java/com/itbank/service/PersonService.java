package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.PersonDAO;
import com.itbank.dto.PersonDTO;

@Service
public class PersonService {
	@Autowired private PersonDAO dao;

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
}
