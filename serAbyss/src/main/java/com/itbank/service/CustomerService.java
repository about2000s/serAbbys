package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.CustomerDAO;

@Service
public class CustomerService {
	@Autowired private CustomerDAO dao;
}
