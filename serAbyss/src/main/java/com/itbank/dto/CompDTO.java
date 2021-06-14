package com.itbank.dto;

public class CompDTO {
	private int companyList_idx;
	private String companyList_name, companyList_address;
	
	
	
	
	public CompDTO(String companyList_name, String companyList_address) {
		this.companyList_name = companyList_name;
		this.companyList_address = companyList_address;
	}
	int getCompanyList_idx() {
		return companyList_idx;
	}
	void setCompanyList_idx(int companyList_idx) {
		this.companyList_idx = companyList_idx;
	}
	String getCompanyList_name() {
		return companyList_name;
	}
	void setCompanyList_name(String companyList_name) {
		this.companyList_name = companyList_name;
	}
	String getCompanyList_address() {
		return companyList_address;
	}
	void setCompanyList_address(String companyList_address) {
		this.companyList_address = companyList_address;
	}
	
	
	
	
}
