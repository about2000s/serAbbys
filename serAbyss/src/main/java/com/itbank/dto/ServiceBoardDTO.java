package com.itbank.dto;
/*
 service

service_idx(PK)      sequence
service_id      session 유저 id값 받아와서 저장
service_title      not null
service_content      not null
service_status      (R(접수)/A(배정)/P(지불)/C(완료))
service_address      session 유저 address 받아와서 저장
service_reg      default to_string('sysdate', 'yyyy-mm-dd')
service_engineer   글 작성시 '없음', 이후 기사가 배정 버튼 눌렀을때 바뀌도록
service_viewcount   default 0

*/
public class ServiceBoardDTO {
	private int service_idx, service_viewCount;
	private String service_id, service_title, service_content, service_status, service_address, service_reg, service_engineer;
	
	public int getService_idx() {
		return service_idx;
	}
	public void setService_idx(int service_idx) {
		this.service_idx = service_idx;
	}
	public int getService_viewCount() {
		return service_viewCount;
	}
	public void setService_viewCount(int service_viewCount) {
		this.service_viewCount = service_viewCount;
	}
	public String getService_id() {
		return service_id;
	}
	public void setService_id(String service_id) {
		this.service_id = service_id;
	}
	public String getService_title() {
		return service_title;
	}
	public void setService_title(String service_title) {
		this.service_title = service_title;
	}
	public String getService_content() {
		return service_content;
	}
	public void setService_content(String service_content) {
		this.service_content = service_content;
	}
	public String getService_status() {
		return service_status;
	}
	public void setService_status(String service_status) {
		this.service_status = service_status;
	}
	public String getService_address() {
		return service_address;
	}
	public void setService_address(String service_address) {
		this.service_address = service_address;
	}
	public String getService_reg() {
		return service_reg;
	}
	public void setService_reg(String service_reg) {
		this.service_reg = service_reg;
	}
	public String getService_engineer() {
		return service_engineer;
	}
	public void setService_engineer(String service_engineer) {
		this.service_engineer = service_engineer;
	}
	
	
	
}
