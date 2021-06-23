package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.BoardDAO;
import com.itbank.dto.ReserveDTO;
import com.itbank.dto.ReplyDTO;
import com.itbank.dto.ReviewBoardDTO;
import com.itbank.dto.SerCenDTO;

@Service
public class BoardService {
	
	@Autowired private BoardDAO dao;

	public List<ReviewBoardDTO> boardListAll() {
		return dao.boardListAll();
	}

	public List<SerCenDTO> faqList(HashMap<String, String> map) {
		return dao.faqList(map);
	}

	public List<SerCenDTO> noticeList() {
		return dao.noticeList();
	}

	public SerCenDTO selectOneNotice(HashMap<String, String> map) {
		return dao.selectOneNotice(map);
	}

	public int selectBoardCountFaq(HashMap<String, String> map) {
		return dao.selectBoardCountFaq(map);
	}

	public ReviewBoardDTO selectOneReview(int review_idx) {
		return dao.selectOneReview(review_idx);
	}

	public int reviewUpdate(ReviewBoardDTO inputData) {
		return dao.reviewUpdate(inputData);
	}

	public int reviewViewCountPlus(ReviewBoardDTO dto) {
		return dao.reviewViewCountPlus(dto);
	}

	public ReserveDTO selectOneByIdx(int reserve_idx) {
		return dao.selectOneByIdx(reserve_idx);
	}

	public int reviewWrite(ReviewBoardDTO dto) {
		return dao.reviewWrite(dto);
	}

	public int reviewBoardCount(HashMap<String, Object> map) {
		return dao.reviewBoardCount(map);
	}

	public List<ReviewBoardDTO> reviewListAll(HashMap<String, Object> map) {
		return dao.reviewListAll(map);
	}

	public int replyWrite(ReplyDTO dto) {
		return dao.replyWrite(dto);
	}
	
	public void setStarInList(List<ReviewBoardDTO> list) {
		for(int i=0;i<list.size();i++) {
			int starScore = list.get(i).getReview_starScore();
			String star = "";
			for (int k = 0; k < starScore; k++) {
				star += "★";
			}
			for (int j = 0; j < 10 - starScore; j++) {
				star += "☆";
			}
			list.get(i).setStar(star);
		}
	}

	public List<ReplyDTO> replyList(int review_idx) {
		return dao.replyList(review_idx);
	}

	public int replyCount(int review_idx) {
		return dao.replyCount(review_idx);
	}
}
