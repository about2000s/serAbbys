package com.itbank.dto;

import org.springframework.web.multipart.MultipartFile;

//test

/*
 *    review

review_idx      PK, 외래키 service_idx
review_id      service_id값 받아와서 저장
review_engineer      service_engineer값 받아와서 저장
review_title      not null
review_content      not null
review_reg      default to_string('sysdate', 'yyyy-mm-dd')
review_count      (0~10) 별 갯수 * 2로 설정, 별 0개~5개(viewCount와 구분하기 위해 starCount)
review_viewcount   default 0
 +  review_uploadFile

 */
public class ReviewBoardDTO {
	private int review_idx, review_viewCount, review_starScore;
	private String review_custId, review_engiId, review_title, review_content, review_reg, review_uploadFile1, review_compBelong;
	private MultipartFile file;
	
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public int getReview_viewCount() {
		return review_viewCount;
	}
	public void setReview_viewCount(int review_viewCount) {
		this.review_viewCount = review_viewCount;
	}
	public String getReview_custId() {
		return review_custId;
	}
	public void setReview_custId(String review_custId) {
		this.review_custId = review_custId;
	}
	public String getReview_engiId() {
		return review_engiId;
	}
	public void setReview_engiId(String review_engiId) {
		this.review_engiId = review_engiId;
	}
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public String getReview_reg() {
		return review_reg;
	}
	public void setReview_reg(String review_reg) {
		this.review_reg = review_reg;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public int getReview_starScore() {
		return review_starScore;
	}
	public void setReview_starScore(int review_starScore) {
		this.review_starScore = review_starScore;
	}
	public String getReview_uploadFile1() {
		return review_uploadFile1;
	}
	public void setReview_uploadFile1(String review_uploadFile1) {
		this.review_uploadFile1 = review_uploadFile1;
	}
	public String getReview_compBelong() {
		return review_compBelong;
	}
	public void setReview_compBelong(String review_compBelong) {
		this.review_compBelong = review_compBelong;
	}
	
}
