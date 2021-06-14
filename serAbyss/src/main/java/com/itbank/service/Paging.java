package com.itbank.service;

public class Paging {
	private int pageCount;	// 총 페이지의 개수. 예를들어 게시글이 79개 이다. 이걸 한 페이지당 5개씩 끊어서 보여주고 싶을 때 이때 pageCount = 16;
	private int nowD = 5;	// 한 페이지에서 보여지는 최대 게시글의 수. 
	private int pageD = 10;	// 페이지에서 보여지는 아래의 페이지숫자의 최댓값. 예: [1] [2] ... [9] [10]
	private int offset;		// 쿼리문 'offset ? rows' 에서 '?'에 들어가는 값이다. 앞에 게시글 몇 개를 건너뛸 것인가?
	private int startNum;	// 밑에 페이지숫자에 [1] [2] [3] [4] [5] 또는 [6] [7] [8] 이렇게 있을 때 
	private int endNum;		// 첫번째 것은 startNum = 1, endNum = 5; 두 번째 것은 startNum = 6, endNum = 8;
	// select * from board2 
	// offset 20 rows
	// fetch first 10 rows only;
	
	//현재 페이지와 게시글 수만 넣어주면 페이징처리 해주는 메서드.
	public Paging(int page, int boardCount) { // page: 현재 내가 있는 페이지. boardCount: 총 게시글의 수(select count(*) from board;)
		// 게시글 수가 nowD에 나눠떨어지면 그대로 나누기. 나눠떨어지지 않으면 + 1
		pageCount = boardCount%nowD == 0 ? boardCount/nowD : boardCount/nowD + 1;
		
//		page 1이면 offset은 0 / 2이면 offset은 nowD(=5). 즉 5번 인덱스까지 건너뛰고 6번 인덱스 글부터 보여주겠다
		offset = (page-1) * nowD;
		
		startNum = pageD*((page-1)/pageD) + 1;
		endNum = startNum + (pageD - 1);
		
		// 밑에 페이지를 1부터 10까지 띄워야 하는데 부득이하게 마지막 페이지가 8 까지라면 그 8을 endNum으로 한다.
		if(pageCount < endNum) endNum = pageCount;
	}
	
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getStartNum() {
		return startNum;
	}
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	public int getEndNum() {
		return endNum;
	}
	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}
	public int getNowD() {
		return nowD;
	}
	public void setNowD(int nowD) {
		this.nowD = nowD;
	}
	public int getPageD() {
		return pageD;
	}
	public void setPageD(int pageD) {
		this.pageD = pageD;
	}
}
