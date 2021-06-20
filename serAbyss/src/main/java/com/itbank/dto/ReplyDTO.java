package com.itbank.dto;
/*
 *    reply

reply_idx(PK)      sequence
reply_bnum      외래키 review_idx
reply_content      not null
reply_id      session.getid 아이디값 불러오게
reply_reg      default to_string('sysdate', 'yyyy-mm-dd')
 */
public class ReplyDTO {
	private int reply_idx, reply_bnum;
	private String reply_content, reply_id, reply_reg;
	
	public int getReply_idx() {
		return reply_idx;
	}
	public void setReply_idx(int reply_idx) {
		this.reply_idx = reply_idx;
	}
	public int getReply_bnum() {
		return reply_bnum;
	}
	public void setReply_bnum(int reply_bnum) {
		this.reply_bnum = reply_bnum;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getReply_id() {
		return reply_id;
	}
	public void setReply_id(String reply_id) {
		this.reply_id = reply_id;
	}
	public String getReply_reg() {
		return reply_reg;
	}
	public void setReply_reg(String reply_reg) {
		this.reply_reg = reply_reg;
	}
	
	
}
