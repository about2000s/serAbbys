package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.AdminDAO;

@Service
public class AdminService {
	@Autowired private AdminDAO dao;
}
