package com.itbank.dto;

public class ReserveTimeDTO {
	private int reserve_idx, reserve_year, reserve_month, reserve_day, reserve_hour;
	private String reserve_engiId, reserve_custId;
	
	public ReserveTimeDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public ReserveTimeDTO(int reserve_year, int reserve_month, int reserve_day, int reserve_hour, String reserve_engiId) {
		this.reserve_year = reserve_year;
		this.reserve_month = reserve_month;
		this.reserve_day = reserve_day;
		this.reserve_hour = reserve_hour;
		this.reserve_engiId = reserve_engiId;
	}
	public int getReserve_idx() {
		return reserve_idx;
	}
	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}
	public int getReserve_year() {
		return reserve_year;
	}
	public void setReserve_year(int reserve_year) {
		this.reserve_year = reserve_year;
	}
	public int getReserve_month() {
		return reserve_month;
	}
	public void setReserve_month(int reserve_month) {
		this.reserve_month = reserve_month;
	}
	public int getReserve_day() {
		return reserve_day;
	}
	public void setReserve_day(int reserve_day) {
		this.reserve_day = reserve_day;
	}
	public int getReserve_hour() {
		return reserve_hour;
	}
	public void setReserve_hour(int reserve_hour) {
		this.reserve_hour = reserve_hour;
	}
	public String getReserve_engiId() {
		return reserve_engiId;
	}
	public void setReserve_engiId(String reserve_engiId) {
		this.reserve_engiId = reserve_engiId;
	}
	public String getReserve_custId() {
		return reserve_custId;
	}
	public void setReserve_custId(String reserve_custId) {
		this.reserve_custId = reserve_custId;
	}
	
	
	
	
}
