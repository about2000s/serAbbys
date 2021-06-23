package com.itbank.dto;

public class CustMemoDTO {

	private int custMemo_idx , custMemo_reserve_idx;
	private String custMemo_comments, custMemo_reg;
	
	public int getCustMemo_idx() {
		return custMemo_idx;
	}
	public void setCustMemo_idx(int custMemo_idx) {
		this.custMemo_idx = custMemo_idx;
	}
	public int getCustMemo_reserve_idx() {
		return custMemo_reserve_idx;
	}
	public void setCustMemo_reserve_idx(int custMemo_reserve_idx) {
		this.custMemo_reserve_idx = custMemo_reserve_idx;
	}
	public String getCustMemo_comments() {
		return custMemo_comments;
	}
	public void setCustMemo_comments(String custMemo_comments) {
		this.custMemo_comments = custMemo_comments;
	}
	public String getCustMemo_reg() {
		return custMemo_reg;
	}
	public void setCustMemo_reg(String custMemo_reg) {
		this.custMemo_reg = custMemo_reg;
	}
	
	

	
}
