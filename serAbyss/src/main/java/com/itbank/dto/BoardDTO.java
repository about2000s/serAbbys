package com.itbank.dto;

import org.springframework.web.multipart.MultipartFile;

/*
 *    review

 
 --만들어짐
create table review (
	review_idx number primary key references service(service_idx),--인덱스(service글을 참조하되, 단 하나만)
	review_id varchar2(20) not null,--게시글 작성자
	review_engineer varchar2(20),--수리기사(service 글의 engineer) @@@@@나의 생각: 이건 외래키를 써도 되지 않을 까요??
	review_uploadfile varchar2(200),--업로드 파일()
	review_title varchar2(50) not null,--리뷰글 제목
	review_content varchar2(2000) not null,--리뷰글 내용
	review_reg varchar2(20)		DEFAULT to_char(sysdate, 'yyyy-MM-dd hh24:mi'),
	review_starScore number not null,--별점(0.5 , 1.0 ... 4.5 , 5.0)*2 => (1, ... , 10)
	review_viewCount number default 0--조회수
);

 */


public class BoardDTO {

	private int review_idx, review_viewCount, review_starScore;
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
	public int getReview_starScore() {
		return review_starScore;
	}
	public void setReview_starScore(int review_starScore) {
		this.review_starScore = review_starScore;
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
		return "BoardDTO [review_idx=" + review_idx + ", review_viewCount=" + review_viewCount + ", review_starScore="
				+ review_starScore + ", review_id=" + review_id + ", review_engineer=" + review_engineer
				+ ", review_title=" + review_title + ", review_content=" + review_content + ", review_reg=" + review_reg
				+ ", review_uploadFile=" + review_uploadFile + ", file=" + file + "]";
	}

	
}
