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
	private String content, id, reg;
	
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReg() {
		return reg;
	}
	public void setReg(String reg) {
		this.reg = reg;
	}
	
	
}
