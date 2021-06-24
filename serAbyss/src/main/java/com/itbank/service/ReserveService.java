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
import com.itbank.dto.CustMemoDTO;
import com.itbank.dto.PersonDTO;
import com.itbank.dto.ReserveTimeDTO;
import com.itbank.dto.ReviewBoardDTO;

@Service
public class ReserveService {

	@Autowired ReserveDAO dao;
	
	
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

	public int delete(int idx) {
		return dao.delete(idx);
	}

	public ReserveTimeDTO selectReserveOne(ReserveTimeDTO inputData) {
		return dao.selectReserveOne(inputData);
	}

	public List<String> selectEngiIdAll() {
		return dao.selectEngiIdAll();
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

	public int insertReserve(ReserveTimeDTO reserveTimeDTO) {
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
	
	public List<HashMap<String, Object>> reserveList(List<String> engiIdList, int hourCount, int dayCount){
		Calendar today = Calendar.getInstance();
		
		List<HashMap<String, Object>> reverveList = new ArrayList<HashMap<String,Object>>();
		for(int i=0;i<engiIdList.size();i++) {
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
				ReserveTimeDTO inputData = new ReserveTimeDTO(year, month, day, hour, engiIdList.get(i));
				ReserveTimeDTO dto = selectReserveOne(inputData);
				if(dto != null) continue;
				map.put("engiId", engiIdList.get(i));
				map.put("year", year);
				map.put("month", month);
				map.put("day", day);
				map.put("hour", hour);
				reverveList.add(map);
			}
		}
		return reverveList;
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
		reserveTimeDTO.setReserveTime_custId(reserveDTO.getReserve_custId());
	}

	//서비스글에 해당하는 리뷰글이 작성되어 있느냐? 있다면 true, 없다면 false
	public Boolean alreadyReviewWrite(int reserve_idx) {
		ReviewBoardDTO dto = dao.alreadyReviewWrite(reserve_idx);
		if(dto != null) return true;
		return false;
	}

	public List<CustMemoDTO> custMemoList(int reserve_idx) {
		return dao.custMemoList(reserve_idx);
	}
}
