package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.BoardDAO;
import com.itbank.dto.BoardDTO;
import com.itbank.dto.ReviewBoardDTO;
import com.itbank.dto.SerCenDTO;
import com.itbank.dto.ServiceBoardDTO;

@Service
public class BoardService {
	
	@Autowired private BoardDAO dao;

	public List<ReviewBoardDTO> boardListAll() {
		return dao.boardListAll();
	}

	public List<ServiceBoardDTO> myCompList(String person_belong) {
		return dao.myCompList(person_belong);
	}

	public List<ServiceBoardDTO> myList(String person_id) {
		return dao.myList(person_id);
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

	public ServiceBoardDTO selectOneByIdx(int service_idx) {
		return dao.selectOneByIdx(service_idx);
	}

	public int reviewWrite(ReviewBoardDTO dto) {
		return dao.reviewWrite(dto);
	}

	public int reviewBoardCount(HashMap<String, String> map) {
		return dao.reviewBoardCount(map);
	}

	public List<ReviewBoardDTO> reviewListAll(HashMap<String, String> map) {
		return dao.reviewListAll(map);
	}

	
}
