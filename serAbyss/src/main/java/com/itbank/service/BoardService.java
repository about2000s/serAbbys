package com.itbank.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.BoardDAO;
import com.itbank.dto.OrderDTO;
import com.itbank.dto.ReplyDTO;
import com.itbank.dto.ReviewBoardDTO;
import com.itbank.dto.SerCenDTO;

@Service
public class BoardService {
	
	@Autowired private BoardDAO dao;

	public List<ReviewBoardDTO> boardListAll() {
		return dao.boardListAll();
	}

	public List<SerCenDTO> faqList(HashMap<String, Object> map) {
		return dao.faqList(map);
	}

	public List<SerCenDTO> noticeList() {
		return dao.noticeList();
	}

	public SerCenDTO selectOneNotice(HashMap<String, String> map) {
		return dao.selectOneNotice(map);
	}

	public int selectBoardCountFaq(HashMap<String, Object> map) {
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

	public OrderDTO selectOneByIdx(int reserve_idx) {
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

	public HashMap<String, Object> reviewJob(String type, String keyword, int page) {
		
		if(keyword == null || keyword.equals("")) {
			type = "review_title";
			keyword = "";
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("type", type);
		map.put("keyword", keyword);
		
		int reviewBoardCount = reviewBoardCount(map);
		
		Paging paging = new Paging(page, reviewBoardCount);
		map.put("offset", paging.getOffset());
		map.put("nowD", paging.getNowD());
		
		List<ReviewBoardDTO> list = reviewListAll(map);
		setStarInList(list);
		
		List<HashMap<String, Object>> mapList = new ArrayList<HashMap<String,Object>>();
		for(int i=0;i<list.size();i++) {
			HashMap<String, Object> hashmap = new HashMap<String, Object>();
			hashmap.put("review_idx", list.get(i).getReview_idx());
			hashmap.put("review_star", list.get(i).getStar());
			hashmap.put("review_title", list.get(i).getReview_title());
			hashmap.put("review_custId", list.get(i).getReview_custId());
			hashmap.put("review_reg", list.get(i).getReview_reg());
			hashmap.put("review_viewCount", list.get(i).getReview_viewCount());
			hashmap.put("review_replyCount", replyCount(list.get(i).getReview_idx()));
			mapList.add(hashmap);
		}
		map.put("page", page);
		map.put("paging", paging);
		map.put("mapList", mapList);
		return map;
	}
}
