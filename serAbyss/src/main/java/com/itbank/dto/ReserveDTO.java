package com.itbank.dto;

/*
 reserve

reserve_idx(PK)      sequence
reserve_custId      session 유저 id값 받아와서 저장
reserve_title      not null
reserve_content      not null
reserve_status      (R(접수)/A(배정)/P(지불)/C(완료))
reserve_address      session 유저 address 받아와서 저장
reserve_reg      default to_string('sysdate', 'yyyy-mm-dd')
reserve_engineer   글 작성시 '없음', 이후 기사가 배정 버튼 눌렀을때 바뀌도록
reserve_viewcount   default 0

*/
public class ReserveDTO {
	private int reserve_idx, reserve_viewCount, reserve_price;
	private String reserve_custId, reserve_title, reserve_content, reserve_status, reserve_address, reserve_reg, reserve_engiId, 
			reserve_compBelong , reserve_name, reserve_phone;
	
	public int getReserve_idx() {
		return reserve_idx;
	}
	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}
	public String getReserve_name() {
		return reserve_name;
	}
	public void setReserve_name(String reserve_name) {
		this.reserve_name = reserve_name;
	}
	public String getReserve_phone() {
		return reserve_phone;
	}
	public void setReserve_phone(String reserve_phone) {
		this.reserve_phone = reserve_phone;
	}
	public int getReserve_viewCount() {
		return reserve_viewCount;
	}
	public void setReserve_viewCount(int reserve_viewCount) {
		this.reserve_viewCount = reserve_viewCount;
	}
	public String getReserve_custId() {
		return reserve_custId;
	}
	public void setReserve_custId(String reserve_custId) {
		this.reserve_custId = reserve_custId;
	}
	public String getReserve_title() {
		return reserve_title;
	}
	public void setReserve_title(String reserve_title) {
		this.reserve_title = reserve_title;
	}
	public String getReserve_content() {
		return reserve_content;
	}
	public void setReserve_content(String reserve_content) {
		this.reserve_content = reserve_content;
	}
	public String getReserve_status() {
		return reserve_status;
	}
	public void setReserve_status(String reserve_status) {
		this.reserve_status = reserve_status;
	}
	public String getReserve_address() {
		return reserve_address;
	}
	public void setReserve_address(String reserve_address) {
		this.reserve_address = reserve_address;
	}
	public String getReserve_reg() {
		return reserve_reg;
	}
	public void setReserve_reg(String reserve_reg) {
		this.reserve_reg = reserve_reg;
	}
	public String getReserve_engiId() {
		return reserve_engiId;
	}
	public void setReserve_engiId(String reserve_engiId) {
		this.reserve_engiId = reserve_engiId;
	}
	public int getReserve_price() {
		return reserve_price;
	}
	public void setReserve_price(int reserve_price) {
		this.reserve_price = reserve_price;
	}
	public String getReserve_compBelong() {
		return reserve_compBelong;
	}
	public void setReserve_compBelong(String reserve_compBelong) {
		this.reserve_compBelong = reserve_compBelong;
	}
	
	
}
