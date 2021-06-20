package com.itbank.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.OrderDAO;
import com.itbank.dto.OrderDTO;
import com.itbank.dto.PersonDTO;
import com.itbank.dto.ReserveDTO;
import com.itbank.dto.ReviewBoardDTO;

@Service
public class OrderService {

	@Autowired OrderDAO dao;
	
	public List<OrderDTO> selectall(HashMap<String, String> param) {
		return dao.selectall(param);
	}
	
	public List<OrderDTO> selectStatus(HashMap<String, Object> param) {
		return dao.selectStatus(param);
	}

	public OrderDTO selectOne(int idx) {
		return dao.selectOne(idx);
	}

	public int order(OrderDTO dto) {
		return dao.order(dto);
	}

	public int modify(OrderDTO dto) {
		return dao.modify(dto);
	}

	public int delete(int idx) {
		return dao.delete(idx);
	}

	public ReserveDTO selectReserveOne(ReserveDTO inputData) {
		return dao.selectReserveOne(inputData);
	}

	public List<String> selectEngiIdAll() {
		return dao.selectEngiIdAll();
	}
	
	public int selectBoardCountList(HashMap<String, String> param) {
		return dao.selectBoardCountList(param);
	}

	public PersonDTO selectOneById(String service_custId) {
		return dao.selectOneById(service_custId);
	}

	public int insertReserve(ReserveDTO reserveDTO) {
		return dao.insertReserve(reserveDTO);
	}

	public int statusListCount(HashMap<String, Object> map) {
		return dao.statusListCount(map);
	}
	
	public HashMap<String, Object> job(String service_status, String type, String keyword, int page, HttpSession session){
		PersonDTO login = (PersonDTO)session.getAttribute("login");
		
		if(keyword == null || keyword.equals("")) {
			type = "service_title";
			keyword = "";
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("type", type);
		map.put("keyword", keyword);
		map.put("service_status", service_status);
		
		map.put("person_check", login.getPerson_check());
		map.put("person_id", login.getPerson_id());
		map.put("person_belong", login.getPerson_belong());
		
		int statusListCount = statusListCount(map);
		
		Paging paging = new Paging(page, statusListCount);
		map.put("offset", paging.getOffset() + "");
		map.put("nowD", paging.getNowD() + "");
		
		List<OrderDTO> list = selectStatus(map);
		
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
				ReserveDTO inputData = new ReserveDTO(year, month, day, hour, engiIdList.get(i));
				ReserveDTO dto = selectReserveOne(inputData);
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
	
	public void monthAndCustIdSetForReserve(OrderDTO orderDTO, ReserveDTO reserveDTO) {
		Calendar today = Calendar.getInstance();
		reserveDTO.setReserve_year(2021);
		if(reserveDTO.getReserve_day() >= 1 && reserveDTO.getReserve_day() <= 13) {
			reserveDTO.setReserve_month((today.get(Calendar.MONTH) + 2));
		}
		else {
			reserveDTO.setReserve_month((today.get(Calendar.MONTH) + 1));
		}
		reserveDTO.setReserve_custId(orderDTO.getService_custId());
	}

	//서비스글에 해당하는 리뷰글이 작성되어 있느냐? 있다면 true, 없다면 false
	public Boolean alreadyReviewWrite(int service_idx) {
		ReviewBoardDTO dto = dao.alreadyReviewWrite(service_idx);
		if(dto != null) return true;
		return false;
	}
}
