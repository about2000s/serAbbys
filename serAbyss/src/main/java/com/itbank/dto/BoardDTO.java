package com.itbank.dto;

import org.springframework.web.multipart.MultipartFile;

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


public class BoardDTO {

	private int review_idx, review_viewCount, review_starCount;
	private String review_id, review_engineer, review_title, review_content, review_reg, review_uploadFile;
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
	public int getReview_starCount() {
		return review_starCount;
	}
	public void setReview_starCount(int review_starCount) {
		this.review_starCount = review_starCount;
	}
	public String getReview_id() {
		return review_id;
	}
	public void setReview_id(String review_id) {
		this.review_id = review_id;
	}
	public String getReview_engineer() {
		return review_engineer;
	}
	public void setReview_engineer(String review_engineer) {
		this.review_engineer = review_engineer;
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
	public String getReview_uploadFile() {
		return review_uploadFile;
	}
	public void setReview_uploadFile(String review_uploadFile) {
		this.review_uploadFile = review_uploadFile;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	@Override
	public String toString() {
		return "BoardDTO [review_idx=" + review_idx + ", review_viewCount=" + review_viewCount + ", review_starCount="
				+ review_starCount + ", review_id=" + review_id + ", review_engineer=" + review_engineer
				+ ", review_title=" + review_title + ", review_content=" + review_content + ", review_reg=" + review_reg
				+ ", review_uploadFile=" + review_uploadFile + ", file=" + file + "]";
	}
	
	
	
}
