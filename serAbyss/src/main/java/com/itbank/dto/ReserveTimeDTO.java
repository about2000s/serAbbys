package com.itbank.dto;

public class ReserveTimeDTO {
	private int reserveTime_idx, reserveTime_year, reserveTime_month, reserveTime_day, reserveTime_hour;
	private String reserveTime_engiId, reserveTime_custId;
	
	public ReserveTimeDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public ReserveTimeDTO(int reserveTime_year, int reserveTime_month, int reserveTime_day, int reserveTime_hour, String reserveTime_engiId) {
		this.reserveTime_year = reserveTime_year;
		this.reserveTime_month = reserveTime_month;
		this.reserveTime_day = reserveTime_day;
		this.reserveTime_hour = reserveTime_hour;
		this.reserveTime_engiId = reserveTime_engiId;
	}

	public int getReserveTime_idx() {
		return reserveTime_idx;
	}

	public void setReserveTime_idx(int reserveTime_idx) {
		this.reserveTime_idx = reserveTime_idx;
	}

	public int getReserveTime_year() {
		return reserveTime_year;
	}

	public void setReserveTime_year(int reserveTime_year) {
		this.reserveTime_year = reserveTime_year;
	}

	public int getReserveTime_month() {
		return reserveTime_month;
	}

	public void setReserveTime_month(int reserveTime_month) {
		this.reserveTime_month = reserveTime_month;
	}

	public int getReserveTime_day() {
		return reserveTime_day;
	}

	public void setReserveTime_day(int reserveTime_day) {
		this.reserveTime_day = reserveTime_day;
	}

	public int getReserveTime_hour() {
		return reserveTime_hour;
	}

	public void setReserveTime_hour(int reserveTime_hour) {
		this.reserveTime_hour = reserveTime_hour;
	}

	public String getReserveTime_engiId() {
		return reserveTime_engiId;
	}

	public void setReserveTime_engiId(String reserveTime_engiId) {
		this.reserveTime_engiId = reserveTime_engiId;
	}

	public String getReserveTime_custId() {
		return reserveTime_custId;
	}

	public void setReserveTime_custId(String reserveTime_custId) {
		this.reserveTime_custId = reserveTime_custId;
	}
	
	
	
	
	
	
}
