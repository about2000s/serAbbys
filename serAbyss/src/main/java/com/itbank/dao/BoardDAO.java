package com.itbank.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.itbank.dto.ReserveDTO;
import com.itbank.dto.ReplyDTO;
import com.itbank.dto.ReviewBoardDTO;
import com.itbank.dto.SerCenDTO;

public interface BoardDAO {

	@Select("select * from review")
	List<ReviewBoardDTO> boardListAll();

	// sqlmap-board.xml에 있습니다
	List<SerCenDTO> faqList(HashMap<String, String> map);

	@Select("select * from serCen where serCen_belong='notice'")
	List<SerCenDTO> noticeList();

	@Select("select * from serCen where serCen_belong=#{serCen_belong} and serCen_idx=#{serCen_idx}")
	SerCenDTO selectOneNotice(HashMap<String, String> map);

	@Select("select count(*) from serCen where serCen_belong='faq' and ${type} like '%${keyword}%'")
	int selectBoardCountFaq(HashMap<String, String> map);

	@Select("select * from review where review_idx=#{review_idx}")
	ReviewBoardDTO selectOneReview(int review_idx);

	@Update("update review set review_title=#{review_title}, review_content=#{review_content} where review_idx=#{review_idx}")
	int reviewUpdate(ReviewBoardDTO inputData);

	@Update("update review set review_viewCount=review_viewCount+1 where review_idx=#{review_idx}")
	int reviewViewCountPlus(ReviewBoardDTO dto);

	@Select("select * from service where service_idx=#{service_idx}")
	ReserveDTO selectOneByIdx(int service_idx);

	// sqlmap-board.xml에 있습니다
	int reviewWrite(ReviewBoardDTO dto);

	@Select("select count(*) from review where ${type} like '%${keyword}%'")
	int reviewBoardCount(HashMap<String, Object> map);

	// sqlmap-board.xml에 있습니다
	List<ReviewBoardDTO> reviewListAll(HashMap<String, Object> map);

	@Insert("insert into reply (reply_idx, reply_bnum, reply_content, reply_id) "
			+ "values (reply_seq.nextval, #{reply_bnum}, #{reply_content}, #{reply_id})")
	int replyWrite(ReplyDTO dto);

	@Select("select * from reply where reply_bnum=#{review_idx}")
	List<ReplyDTO> replyList(int review_idx);

	@Select("select count(*) from reply where reply_bnum=#{review_idx}")
	int replyCount(int review_idx);
}
