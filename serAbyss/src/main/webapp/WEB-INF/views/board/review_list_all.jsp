<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/reviewleftmenu.jsp"%>


<!--  


create table reviewboard (
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

 -->


<h2>리뷰보기</h2>
<div class="container">
	<table>
		<tr>
			<th width="5%">no</th>
			<th width="10%">평점</th>
			<th width="50%">제목</th>
			<th width="10%">담당 엔지니어</th>
			<th width="10%">날짜</th>
			<th width="10%">조회수</th>
		</tr>


		<tr>
				<td>${dto.review_idx}</td>
				<td>${star }</td>
				<td><a href="">${dto.review_title}</a></td>
				<td>${dto.review_engineer}</td>
				<td>${dto.review_reg }</td>
				<td>${dto.review_viewCount }</td>
		</tr>

	</table>
</div>

<%@ include file="../layout/footer.jsp"%>
