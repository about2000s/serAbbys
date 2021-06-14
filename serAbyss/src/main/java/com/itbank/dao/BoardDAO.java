package com.itbank.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.itbank.dto.BoardDTO;
import com.itbank.dto.SerCenDTO;
import com.itbank.dto.ServiceBoardDTO;

public interface BoardDAO {

	@Select("select * from reviewboard where review_idx='1'")
	BoardDTO boardListAll();

	//회사 대표계정만이 자기 소속 회사 직원들이 올린 글들을 모두 볼 수 있다.
	@Select("select * from service where service_compBelong=#{person_belong}")
	List<ServiceBoardDTO> myCompList(String person_belong);

	@Select("select * from service where service_engiId=#{person_id}")
	List<ServiceBoardDTO> myList(String person_id);

	@Select("select * from serCen where belong=#{faq}")
	List<SerCenDTO> faqList();

	@Select("select * from serCen where belong=#{notice}")
	List<SerCenDTO> noticeList();

	

}
