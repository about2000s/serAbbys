package com.itbank.dto;
/*
 *     admin / 회사관리자

admin_idx(PK)   sequence
admin_id   unique
admin_pw   not null
admin_name   not null
admin_email   not null
admin_address   default 다음 api로 받아온값
admin_phone   not null
admin_call   not null
admin_fax   not null
admin_check   (개발자는 미리 만들어두기 a/새로 만드는 계정은 전부 c)


 */
public class AdminDTO {
	private int admin_idx;
	private String admin_id, admin_pw, admin_name, admin_email, admin_address, admin_phone, admin_call, admin_fax, admin_check;
	
	public int getAdmin_idx() {
		return admin_idx;
	}
	public void setAdmin_idx(int admin_idx) {
		this.admin_idx = admin_idx;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getAdmin_pw() {
		return admin_pw;
	}
	public void setAdmin_pw(String admin_pw) {
		this.admin_pw = admin_pw;
	}
	public String getAdmin_name() {
		return admin_name;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	public String getAdmin_email() {
		return admin_email;
	}
	public void setAdmin_email(String admin_email) {
		this.admin_email = admin_email;
	}
	public String getAdmin_address() {
		return admin_address;
	}
	public void setAdmin_address(String admin_address) {
		this.admin_address = admin_address;
	}
	public String getAdmin_phone() {
		return admin_phone;
	}
	public void setAdmin_phone(String admin_phone) {
		this.admin_phone = admin_phone;
	}
	public String getAdmin_call() {
		return admin_call;
	}
	public void setAdmin_call(String admin_call) {
		this.admin_call = admin_call;
	}
	public String getAdmin_fax() {
		return admin_fax;
	}
	public void setAdmin_fax(String admin_fax) {
		this.admin_fax = admin_fax;
	}
	public String getAdmin_check() {
		return admin_check;
	}
	public void setAdmin_check(String admin_check) {
		this.admin_check = admin_check;
	}
	
	
	
	
}
