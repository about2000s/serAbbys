package com.itbank.dto;
/*
 *    고객 / 기사

user_idx(PK)   sequence
user_id      unique
user_pw      not null
user_name   not null
user_email   not null
user_address   default 다음 api로 받아온값
user_phone   not null
user_call   not null
user_fax   not null
user_check   (고객 C/기사 E)
user_belong   외래키 회사관리자_idx (가입할 때 select 하게끔, 고객은 자동으로 '없음' 선택)

 */
public class CustomerDTO {
	private int user_idx;
	private String user_id, user_pw, user_name, user_email, user_address, user_phone, user_call, user_fax, user_check, user_belong;
	
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_call() {
		return user_call;
	}
	public void setUser_call(String user_call) {
		this.user_call = user_call;
	}
	public String getUser_fax() {
		return user_fax;
	}
	public void setUser_fax(String user_fax) {
		this.user_fax = user_fax;
	}
	public String getUser_check() {
		return user_check;
	}
	public void setUser_check(String user_check) {
		this.user_check = user_check;
	}
	public String getUser_belong() {
		return user_belong;
	}
	public void setUser_belong(String user_belong) {
		this.user_belong = user_belong;
	}
	
	
}
