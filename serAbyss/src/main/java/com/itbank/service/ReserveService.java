package com.itbank.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.ReserveDAO;
import com.itbank.dto.ReserveDTO;
import com.itbank.dto.PersonDTO;
import com.itbank.dto.ReserveTimeDTO;
import com.itbank.dto.ReviewBoardDTO;

@Service
public class ReserveService {

	@Autowired ReserveDAO dao;
	@Autowired PersonService ps;
	
	public List<ReserveDTO> selectStatus(HashMap<String, Object> param) {
		return dao.selectStatus(param);
	}

	public ReserveDTO selectOne(int idx) {
		return dao.selectOne(idx);
	}

	public int reserve(ReserveDTO dto) {
		return dao.reserve(dto);
	}

	public int modify(ReserveDTO dto) {
		return dao.modify(dto);
	}

	public int deleteReserve(int idx) {
		return dao.deleteReserve(idx);
	}

	public ReserveTimeDTO selectReserveOne(ReserveTimeDTO inputData) {
		return dao.selectReserveOne(inputData);
	}

	public List<PersonDTO> selectEngiAll() {
		return dao.selectEngiAll();
	}
	
//	public int selectBoardCountList(HashMap<String, String> param) {
//		return dao.selectBoardCountList(param);
//	}

	public int change_status(ReserveDTO dto) {
		return dao.change_status(dto);
	}
	
	public PersonDTO selectOneById(String reserve_custId) {
		return dao.selectOneById(reserve_custId);
	}

	public int insertReserveTime(ReserveTimeDTO reserveTimeDTO) {
		return dao.insertReserve(reserveTimeDTO);
	}

	public int statusListCount(HashMap<String, Object> map) {
		return dao.statusListCount(map);
	}
	
	public HashMap<String, Object> job(String reserve_status, String type, String keyword, int page, HttpSession session){
		PersonDTO login = (PersonDTO)session.getAttribute("login");
		
		if(keyword == null || keyword.equals("")) {
			type = "reserve_title";
			keyword = "";
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("type", type);
		map.put("keyword", keyword);
		map.put("reserve_status", reserve_status);
		
		map.put("person_check", login.getPerson_check());
		map.put("person_id", login.getPerson_id());
		map.put("person_belong", login.getPerson_belong());
		
		int statusListCount = statusListCount(map);
		
		Paging paging = new Paging(page, statusListCount);
		map.put("offset", paging.getOffset() + "");
		map.put("nowD", paging.getNowD() + "");
		
		List<ReserveDTO> list = selectStatus(map);
		
		map.put("page", page);
		map.put("paging", paging);
		map.put("list", list);
		return map;
	}
	
	public List<Integer> dayList(int dayCount){
		Calendar today = Calendar.getInstance();
		int nowDay = today.get(Calendar.DATE);
		int nowMonth = today.get(Calendar.MONTH) + 1;
		List<Integer> dayList = new ArrayList<Integer>();
		for(int i=0;i<dayCount;i++) {
			if(nowDay == 30) {
				if(nowMonth == 6 || nowMonth == 9 || nowMonth == 11) {
					nowDay = 1;
				}
			}
			else if(nowDay == 31) {
				if(nowMonth == 7 || nowMonth == 8 || nowMonth == 10 || nowMonth == 12) {
					nowDay = 1;
				}
			}
			else {
				nowDay++;
			}
			dayList.add(nowDay);
		}
		return dayList;
	}
	
	public List<HashMap<String, Object>> reserveTimeList(List<PersonDTO> engiList, int hourCount, int dayCount){
		Calendar today = Calendar.getInstance();
		
		List<HashMap<String, Object>> reserveList = new ArrayList<HashMap<String,Object>>();
		for(int i=0;i<engiList.size();i++) {
			int year = today.get(Calendar.YEAR);
			int month = today.get(Calendar.MONTH) + 1;
			int day = today.get(Calendar.DATE) + 1;
			int hour = 6; // for문으로 반복문을 돌려놓고 숫자계산 후 "" 더해서 HashMap에 넣자!
			for(int j=0;j<hourCount*(dayCount + 1);j++) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				if(hour == 22) {
					if(day == 30) {
						if(month == 6 || month == 9 || month == 11) {
							month++;
							day = 1;
							hour = 8;
						}
					}
					else if(day == 31) {
						if(month == 7 || month == 8 || month == 10 || month == 12) {
							month++;
							day = 1;
							hour = 8;
						}
					}
					else {
						day++;
						hour = 8;
					}
				}else {
					hour += 2;
				}
				ReserveTimeDTO inputData = new ReserveTimeDTO(year, month, day, hour, engiList.get(i).getPerson_id());
				ReserveTimeDTO dto = selectReserveOne(inputData);
				if(dto != null) continue;
				map.put("engiId", engiList.get(i).getPerson_id());
				map.put("year", year);
				map.put("month", month);
				map.put("day", day);
				map.put("hour", hour);
				reserveList.add(map);
			}
		}
		return reserveList;
	}
	
	
	
	public void monthAndCustIdSetForReserve(ReserveDTO reserveDTO, ReserveTimeDTO reserveTimeDTO) {
		Calendar today = Calendar.getInstance();
		reserveTimeDTO.setReserveTime_year(2021);
		if(reserveTimeDTO.getReserveTime_day() >= 1 && reserveTimeDTO.getReserveTime_day() <= 13) {
			reserveTimeDTO.setReserveTime_month((today.get(Calendar.MONTH) + 2));
		}
		else {
			reserveTimeDTO.setReserveTime_month((today.get(Calendar.MONTH) + 1));
		}
		if(reserveDTO.getReserve_custId() != null) {
			reserveTimeDTO.setReserveTime_custId(reserveDTO.getReserve_custId());
		}
		else {
			reserveTimeDTO.setReserveTime_custId(reserveDTO.getReserve_name());
		}
	}

	//서비스글에 해당하는 리뷰글이 작성되어 있느냐? 있다면 true, 없다면 false
	public Boolean alreadyReviewWrite(int reserve_idx) {
		ReviewBoardDTO dto = dao.alreadyReviewWrite(reserve_idx);
		if(dto != null) return true;
		return false;
	}

	public int selectMaxIdxInReserve(String reserve_engiId) {
		return dao.selectMaxIdxInReserve(reserve_engiId);
	}

	public PersonDTO selectEngiOneByIdx(int reserve_idx) {
		String engiId = dao.selectEngiIdOneByIdx(reserve_idx);
		PersonDTO engi = dao.selectEngiById(engiId);
		return engi;
	}

	public int changeReserveTime(ReserveTimeDTO reserveTimeDTO) {
		return dao.changeReserveTime(reserveTimeDTO);
	}

	public int reserveTitleChange(ReserveDTO reserveDTO) {
		return dao.reserveTitleChange(reserveDTO);
	}

	public int deleteReserveTime(int reserve_idx) {
		return dao.deleteReserveTime(reserve_idx);
	}

	public int statusChange(ReserveDTO dto) {
		return dao.statusChange(dto);
	}

	public int reserveViewCountPlus(int reserve_idx) {
		return dao.reserveViewCountPlus(reserve_idx);
	}
	
	public List<String> statusList(){
		List<String> statusList = new ArrayList<String>();
		statusList.add("전체");
		statusList.add("예약완료");
		statusList.add("서비스중");
		statusList.add("서비스완료");
		statusList.add("결제완료");
		statusList.add("환불접수");
		statusList.add("처리완료");
		return statusList;
	}
	
	public void addressAndTitleSetting(ReserveDTO reserveDTO, ReserveTimeDTO reserveTimeDTO, String address, String detailAddress) {
		String fullAddress = address + " " + detailAddress;
		reserveDTO.setReserve_address(fullAddress);
		
		monthAndCustIdSetForReserve(reserveDTO, reserveTimeDTO);
		
		String title = String.format("[2021년 %d월 %d일 %d시 %s 고객님이 예약하셨습니다.]", 
				reserveTimeDTO.getReserveTime_month(), reserveTimeDTO.getReserveTime_day(), 
				reserveTimeDTO.getReserveTime_hour(), reserveDTO.getReserve_name());
		reserveDTO.setReserve_title(title);
		
		try {
			String msg = ps.any(reserveDTO.getReserve_phone(), title);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public HashMap<String, String> statusChangeBtn(ReserveDTO dto) {
		HashMap<String, String> btnList = new HashMap<String, String>();
		String b1 = "";
		String b2 = "";
		switch(dto.getReserve_status()) {
		case "예약완료":
			b1 = "서비스중";
			break;
		case "서비스중":
			b1 = "서비스완료";
			break;
		case "서비스완료":
			b1 = "결제완료";
			break;
		case "결제완료":
			b1 = "처리완료";//하루 내에 환불신청 가능
			b2 = "환불신청";//하루 지나면 가능한걸로
			break;
		case "환불접수":
			b1 = "처리완료";
			break;
		case "처리완료":
			b1 = "";
			break;
		}
		btnList.put("b1", b1);
		btnList.put("b2", b2);
		return btnList;
	}
}
