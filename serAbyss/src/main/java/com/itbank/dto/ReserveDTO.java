package com.itbank.dto;

public class ReserveDTO {
	private int reserve_idx;
	private String reserve_fullDate, reserve_engiId, reserve_custId;
	
	public ReserveDTO(String reserve_fullDate, String reserve_engiId) {
		this.reserve_fullDate = reserve_fullDate;
		this.reserve_engiId = reserve_engiId;
	}
}
