package com.itbank.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.itbank.dto.BoardDTO;
import com.itbank.dto.SerCenDTO;
import com.itbank.dto.ServiceBoardDTO;

public interface BoardDAO {

	@Select("select * from review where review_idx='1'")
	BoardDTO boardListAll();

	//회사 대표계정만이 자기 소속 회사 직원들이 올린 글들을 모두 볼 수 있다.
	@Select("select * from service where service_compBelong=#{person_belong}")
	List<ServiceBoardDTO> myCompList(String person_belong);

	@Select("select * from service where service_engiId=#{person_id}")
	List<ServiceBoardDTO> myList(String person_id);

	// sqlmap-board.xml에 있습니다
	List<SerCenDTO> faqList(HashMap<String, String> map);

	@Select("select * from serCen where serCen_belong='notice'")
	List<SerCenDTO> noticeList();

	@Select("select * from serCen where serCen_belong=#{serCen_belong} and serCen_idx=#{serCen_idx}")
	SerCenDTO selectOneNotice(HashMap<String, String> map);

//	select count(*) from board2
//	where ${type} like '%${keyword}%'
	
	@Select("select count(*) from serCen where serCen_belong='faq' and ${type} like '%${keyword}%'")
	int selectBoardCountFaq(HashMap<String, String> map);

	

}
