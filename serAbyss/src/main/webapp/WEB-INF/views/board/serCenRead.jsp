<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<div>
	제목: ${dto.serCen_title }
	작성자: ${dto.serCen_id }
	조회수: ${dto.serCen_viewCount }
	내용: ${dto.serCen_content }
</div>

<%@ include file="../layout/footer.jsp" %>