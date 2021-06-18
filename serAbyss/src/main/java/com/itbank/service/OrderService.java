package com.itbank.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.OrderDAO;
import com.itbank.dto.OrderDTO;
import com.itbank.dto.ReserveDTO;

@Service
public class OrderService {

	@Autowired OrderDAO dao;
	
	private final String uploadPath = "D:\\upload";
	
	public OrderService() {
		File dir = new File(uploadPath);
		if(dir.exists() == false) {
			dir.mkdirs();		// mkdir-p [경로] : 상위 경로가 없으면 상위 경로도 같이 만들어라
		}
	}
	
	public OrderDTO Filename(OrderDTO dto) {
		if(dto.getFile().getOriginalFilename().equals("") == false) {
			String fileName = UUID.randomUUID().toString().replaceAll("-", "");
			int beginIndex = dto.getFile().getOriginalFilename().indexOf(".");
			String extName = dto.getFile().getOriginalFilename().substring(beginIndex);
			fileName += extName;
			
			File f = new File(uploadPath, fileName);
			
			try {
				dto.getFile().transferTo(f);
				
			} catch (IllegalStateException | IOException e) {
				System.out.println("업로드 문제 발생 : " + e);
			}
			dto.setService_uploadFile1(fileName);
		} else dto.setService_uploadFile1(null);
		return dto;
	}
	
	public List<OrderDTO> selectall(HashMap<String, String> param) {
		return dao.selectall(param);
	}
	
	public List<OrderDTO> selectStatus(HashMap<String, String> param) {
		return dao.selectStatus(param);
	}

	public OrderDTO selectOne(int idx) {
		return dao.selectOne(idx);
	}

	public int order(OrderDTO dto) {
		return dao.order(Filename(dto));
	}

	public int modify(OrderDTO dto) {
		return dao.modify(Filename(dto));
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
	
	public HashMap<String, List<String>> complicateJob(){
		int hourCount = 8;
		int dayCount = 7;
		
		SimpleDateFormat yyyyMM = new SimpleDateFormat("yyyyMM");
		SimpleDateFormat dd = new SimpleDateFormat("dd");
		
		Date date = new Date();
		
		String yyyyMMDate = yyyyMM.format(date);
		String ddDate = dd.format(date);//현재 일(day). 하지만 우리는 내일부터 예약을 받을 거다.
		
		int ddDateToInt = Integer.parseInt(ddDate);//현재 일(day)에 1을 더하기 위해 정수로 변환
		ddDateToInt++;// 더하기 1
		ddDate = ddDateToInt + ""; //1이 더해진 일(day)를 문자열로 변환
		String FullDate = yyyyMMDate + ddDate + "06"; // 그러니까 오늘이 20210616일 때, 2021061706부터 시작한다!
		List<String> engiIdList = selectEngiIdAll();
		//			 기사		 예약시간대~~
		
		//시작이 2021061706
		//case1
		
		//case2
//		HashMap<String, HashMap<String, String>> 
		
		List<HashMap<String, List<String>>> outerList = new ArrayList<HashMap<String,List<String>>>();
		for(int i=0;i<engiIdList.size();i++) {// 오늘로부터 7일까지만 표기 ex)오늘이 16일이면 16, 17, ... , 22
			int FullDateToInt = Integer.parseInt(FullDate);
			HashMap<String, List<String>> map = null;
			for(int j=0;j<16;j++) {
				map = new HashMap<String, List<String>>();
				List<String> innerList = new ArrayList<String>();
				
				String yearPart = (FullDateToInt + "").substring(0, 4);
				String monthPart = (FullDateToInt + "").substring(4, 6);
				String dayPart = (FullDateToInt + "").substring(6, 8);
				String hourPart = (FullDateToInt + "").substring(8, 10);
				
				if(hourPart.equals("22")) {
					if(dayPart.equals("30")) {
						if(monthPart.equals("06") || monthPart.equals("09") || monthPart.equals("11")) {
							FullDateToInt += 7084;
							continue;
						}
					}
					else if(dayPart.equals("31")) {
						if(monthPart.equals("07") || monthPart.equals("08") || monthPart.equals("10") || monthPart.equals("12")) {
							FullDateToInt += 6984;
							continue;
						}
					}
					else {
						FullDateToInt += 86;
					}
				}else {
					FullDateToInt += 2;
				}
				String reserve_engiId = engiIdList.get(i);
				String reserve_fullDate = FullDateToInt + "";
				ReserveDTO inputData = new ReserveDTO(reserve_fullDate, reserve_engiId);
				ReserveDTO dto = dao.selectReserveOne(inputData);
				if(dto != null) continue;
				
				innerList.add(yearPart);
				innerList.add(monthPart);
				innerList.add(dayPart);
				innerList.add(hourPart);
				map.put(engiIdList.get(i), innerList);
			}
			outerList.add(map);
		}
		
		System.out.println(outerList);
		
		return null;
		
//		SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
//		SimpleDateFormat MM = new SimpleDateFormat("MM");
//		SimpleDateFormat dd = new SimpleDateFormat("dd");
//		String year = yyyy.format(date); // 2021
//		String month = MM.format(date);
//		String day = dd.format(date);
//		int monthToInt = Integer.parseInt(month);
//		int dayToInt = Integer.parseInt(day);
//		int hour = 8;
//		
//		List<String> engiIdList = selectEngiIdAll();
//		
//		List<String> monthList = new ArrayList<String>(); // 06
//		for(int i=0;i<2;i++) {
//			monthList.add(i, (monthToInt + i) + "");
//			if(monthList.get(i).length() == 1) {
//				monthList.set(i, "0" + monthList.get(i));
//			}
//		}
//		
//		List<String> dayList = new ArrayList<String>(); // 16, 17
//		for(int i=0;i<3;i++) {
//			dayList.add(i, (dayToInt + i + 1) + "");
//			if(monthToInt == 6 && dayToInt + i + 1 == 30) {
//				
//			}
//			if(dayList.get(i).length() == 1) {
//				dayList.set(i, "0" + dayList.get(i));
//			}
//		}
//		
//		HashMap<String, HashMap<String, HashMap<String, List<String>>>> aMap = new HashMap<String, HashMap<String,HashMap<String,List<String>>>>();
//		
//		//지옥의 반복문 시작
//		for(int a=0;a<engiIdList.size();a++) {
//			HashMap<String, HashMap<String, List<String>>> bMap = new HashMap<String, HashMap<String,List<String>>>();
//			
//			for(int b=0;b<monthList.size();b++) {
//				HashMap<String, List<String>> cMap = new HashMap<String, List<String>>();
//				
//				for(int c=0;c<dayList.size();c++) {
//					
//					List<String> dList = new ArrayList<String>(); //반복문을 돌릴 때마다 새로운 dList를 만든다!
//					for(int d=0;d<8;d++) {	// 08 10 12 14 16 18 20 22
//						dList.add(d, (hour + d*2) + "");
//						if(dList.get(d).length() == 1) { // 길이가 1인 것(8)은 앞에 0을 붙여 08로 만든다
//							dList.set(d, "0" + dList.get(d));
//						}
//					}
//					
//					for(int e=0;e<dList.size();e++) {
//						String reserve_year = year;
//						String reserve_month = monthList.get(b);
//						String reserve_day = dayList.get(c);
//						String reserve_hour = dList.get(e);
//						String reserve_engiId = engiIdList.get(a);
//						ReserveDTO inputData = new ReserveDTO(reserve_year, reserve_month, reserve_day, reserve_hour, reserve_engiId);
//						
//						ReserveDTO dto = selectReserveOne(inputData);
//						if(dto != null) {
//							dList.remove(dto.getReserve_hour());
//						}
//					}
//					cMap.put(dayList.get(c), dList);
//				}
//				bMap.put(monthList.get(b), cMap);
//			}
//			aMap.put(engiIdList.get(a), bMap);
//		}
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		map.put("aMap", aMap);
//		map.put("engiIdList", engiIdList);
//		map.put("monthList", monthList);
//		map.put("dayList", dayList);
//		return map;
		
	}

//	public int setReserve(ReserveDTO reserveDTO) {
//		return dao.setReserve(reserveDTO);
//	}
	
	public int selectBoardCountList(HashMap<String, String> param) {
		return dao.selectBoardCountList(param);
	}

	public int change_status(HashMap<String, String> param) {
		return dao.change_status(param);
	}
	
//	public int order(OrderDTO dto) {
//		if(dto.ready()) {
//			File target = new File(uploadPath, dto.getService_uploadFile());
//			try {
//				dto.getFile().transferTo(target);
//				
//			} catch (IllegalStateException | IOException e) {
//				e.printStackTrace();
//			}
//			
//		}
//		return dao.order(dto);
//	}

}
