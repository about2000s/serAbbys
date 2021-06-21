package com.itbank.service;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.PersonDAO;
import com.itbank.dto.CompDTO;
import com.itbank.dto.PersonDTO;

@Service
public class PersonService {
	@Autowired private PersonDAO dao;
	
	//해시처리 메서드
	private String getHash(String text){
		String hash = null;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			md.reset();
			md.update(text.getBytes("UTF-8"));
			hash = String.format("%0128x", new BigInteger(1, md.digest()));
		}catch(NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return hash;
	}
	//
	//랜덤비밀번호 받아오는 메서드
	public String randomPw() {
		return UUID.randomUUID().toString().split("-")[0];
	}

	public int selectOne(String id) {
		int row = dao.selectOne(id);
		return row;
	}

	public PersonDTO personLogin(PersonDTO dto) {
		dto.setPerson_pw(getHash(dto.getPerson_pw()));
		return dao.personLogin(dto);
	}

	public PersonDTO companyLogin(PersonDTO dto) {
		dto.setPerson_pw(getHash(dto.getPerson_pw()));
		return dao.companyLogin(dto);
	}

	public int join(PersonDTO inputData) {
		inputData.setPerson_pw(getHash(inputData.getPerson_pw()));
		return dao.join(inputData);
	}

	public String findIdByPhone(PersonDTO inputData) {
		return dao.findIdByPhone(inputData);
	}
	public String findIdByEmail(PersonDTO inputData) {
		return dao.findIdByEmail(inputData);
	}

	public String repwByPhone(PersonDTO inputData) {
		PersonDTO dto = dao.repwByPhone(inputData);
		String randomPw = randomPw();//UUID 써서 임시 비밀번호 만들고
		dto.setPerson_pw(getHash(randomPw));//그 임시비밀번호를 해시처리 후 dto에 셋팅.
		return randomPw;
	}
	//메소드가 완전히 겹치지만... dao에서는 다르게 처리하기 때문에 일단 분리해뒀습니다.
	//나중에 동적쿼리 쓸 여유 되면 합쳐보겠습니다.
	public String repwByEmail(PersonDTO inputData) {
		PersonDTO dto = dao.repwByEmail(inputData);
		String randomPw = randomPw();//UUID 써서 임시 비밀번호 만들고
		dto.setPerson_pw(getHash(randomPw));//그 임시비밀번호를 해시처리 후 dto에 셋팅.
		return randomPw;
	}

	public int selectOneCheckIdPw(PersonDTO inputData) {
		inputData.setPerson_pw(getHash(inputData.getPerson_pw()));
		return dao.selectOneCheckIdPw(inputData);
	}

	public int updatePw(PersonDTO inputData) {
//		String hash = getHash(inputData.getPerson_pw());
//		inputData.setPerson_pw(getHash(hash));
		inputData.setPerson_pw(getHash(inputData.getPerson_pw()));
		return dao.updatePw(inputData);
	}

	public int idCheck(String person_id) {
		return dao.idCheck(person_id);
	}
	
	//자기 회사의 최소 인덱스 구하는 메서드(이 인덱스번호와 일치하는 계정은, 대표계정임을 알 수 있음)
	public int getMinIdx(String person_belong) {
		return dao.getMinIdx(person_belong);
	}

	//내가 로그인한 계정이 회사의 대표계정이냐의 여부를 판별해주는 메서드
	public boolean iamCeo(PersonDTO login) {
		int minIdx = getMinIdx(login.getPerson_belong());
		if(login.getPerson_idx() != minIdx) {
			System.out.println("회사 대표계정이 아닌 직원이네요");
			return false;
		}
		else {
			System.out.println("회사 대표계정이네요!");
			return true;
		}
	}

	public int companyAdd(CompDTO comp) {
		return dao.companyAdd(comp);
	}


	public int emailCheck(String person_email) {
		return dao.emailCheck(person_email);
	}

	public List<HashMap<String, String>> compSearchList(String companyList_name) {
		return dao.compSearchList(companyList_name);
	}

	public String getAuthNumber() {
		Random ran = new Random();
		String authNumber = "";
		for(int i=0;i<6;i++) {
			authNumber += ran.nextInt(9);
		}
		return authNumber;
	}

	public String sendMail(String person_email, String authNumber, String account) {

		String host = "smtp.naver.com";
		final String username = account.split("/")[0];
		final String password = account.split("/")[1];
		int port = 465;
		
		String subject = "[SIR-ABYSS] 인증번호입니다.";
		String body = "인증번호는 [%s] 입니다\n\n";
		body = String.format(body, authNumber);
		
		Properties props = System.getProperties();
		
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.trust", host);
		
		Session mailSession = Session.getDefaultInstance(props, new Authenticator() {
			String un = username;
			String pw = password;
			
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pw);
			}
		});
		mailSession.setDebug(true);
		
		Message mimeMessage = new MimeMessage(mailSession);
		
		try {
			mimeMessage.setFrom(new InternetAddress(username + "@naver.com"));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(person_email));
			mimeMessage.setSubject(subject);
			mimeMessage.setText(body);
			Transport.send(mimeMessage);
			
		} catch(MessagingException e) {
			return "주소가 잘못되었습니다";
		}
		
		return authNumber;
	}
}















