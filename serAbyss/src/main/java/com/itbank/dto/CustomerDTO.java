package com.itbank.dto;

public class CustomerDTO {
	
	private int customer_idx , customer_service_idx;
	private String customer_comments, customer_reg;
	
	public int getCustomer_idx() {
		return customer_idx;
	}
	public void setCustomer_idx(int customer_idx) {
		this.customer_idx = customer_idx;
	}
	public int getCustomer_service_idx() {
		return customer_service_idx;
	}
	public void setCustomer_service_idx(int customer_service_idx) {
		this.customer_service_idx = customer_service_idx;
	}
	public String getCustomer_comments() {
		return customer_comments;
	}
	public void setCustomer_comments(String customer_comments) {
		this.customer_comments = customer_comments;
	}
	public String getCustomer_reg() {
		return customer_reg;
	}
	public void setCustomer_reg(String customer_reg) {
		this.customer_reg = customer_reg;
	}

	
	
}
