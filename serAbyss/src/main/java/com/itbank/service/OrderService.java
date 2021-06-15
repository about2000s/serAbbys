package com.itbank.service;

import java.io.File;
import java.io.IOException;
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
			dto.setService_uploadFile(fileName);
		} else dto.setService_uploadFile(null);
		return dto;
	}
	
	public List<OrderDTO> selectall() {
		return dao.selectall();
	}
	
	public List<OrderDTO> selectStatus(String status) {
		return dao.selectStatus(status);
	}

	public OrderDTO selectOne(int idx) {
		return dao.selectOne(idx);
	}

	public int order(OrderDTO dto) {
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
			dto.setService_uploadFile(fileName);
		} else dto.setService_uploadFile(null);
		return dao.order(dto);
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
