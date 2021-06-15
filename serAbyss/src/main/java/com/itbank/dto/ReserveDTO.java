package com.itbank.dto;

public class ReserveDTO {
	private int reserve_idx;
	private String reserve_year, reserve_month, reserve_day, reserve_hour, reserve_engiId, reserve_custId;
	
	public ReserveDTO(String reserve_year, String reserve_month, String reserve_day, String reserve_hour,
			String reserve_engiId, String reserve_custId) {
		super();
		this.reserve_year = reserve_year;
		this.reserve_month = reserve_month;
		this.reserve_day = reserve_day;
		this.reserve_hour = reserve_hour;
		this.reserve_engiId = reserve_engiId;
		this.reserve_custId = reserve_custId;
	}
	public int getReserve_idx() {
		return reserve_idx;
	}
	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}
	public String getReserve_year() {
		return reserve_year;
	}
	public void setReserve_year(String reserve_year) {
		this.reserve_year = reserve_year;
	}
	public String getReserve_month() {
		return reserve_month;
	}
	public void setReserve_month(String reserve_month) {
		this.reserve_month = reserve_month;
	}
	public String getReserve_day() {
		return reserve_day;
	}
	public void setReserve_day(String reserve_day) {
		this.reserve_day = reserve_day;
	}
	public String getReserve_hour() {
		return reserve_hour;
	}
	public void setReserve_hour(String reserve_hour) {
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
