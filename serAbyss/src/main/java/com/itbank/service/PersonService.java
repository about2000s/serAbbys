package com.itbank.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.InetAddress;
import java.net.Socket;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
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
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

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
		inputData.setPerson_pw(getHash(inputData.getPerson_pw()));	// 입력받은 inputData의 pw값을 해쉬처리하여 다시 갱신시킴
		return dao.updatePw(inputData);
	}

	public int idCheck(String person_id) {
		return dao.idCheck(person_id);
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
			authNumber += ran.nextInt(9); // 랜덤한 0~9 사이의 숫자를 총 6자리를 만들어 저장
		}
		return authNumber;
	}

	public String sendMail(String person_email, String authNumber, String account) {

		String host = "smtp.naver.com";	// host 주소를 설정
		final String username = account.split("/")[0];	// account의 / 앞 정보값을 username으로 저장
		final String password = account.split("/")[1];	// account의 / 뒤 정보값을 password로 저장
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
	
	public int updateEmail(PersonDTO dto) {
		return dao.updateEmail(dto);
	}
	
	public int updateAddress(PersonDTO dto) {
		return dao.updateAddress(dto);
	}
	
	public PersonDTO selectOneById(String login_id) {
		return dao.selectOneById(login_id);
	}
	
	public int updateFax(PersonDTO login) {
		return dao.updateFax(login);
	}
	
	public int updateCall(PersonDTO login) {
		return dao.updateCall(login);
	}
	
	public int emailNameCheck(PersonDTO inputData) {
		return dao.emailNameCheck(inputData);
	}
	
	public int emailIdCheck(PersonDTO inputData) {
		return dao.emailIdCheck(inputData);
	}
	
	public String findPwByEmail(PersonDTO inputData) {
		String authNumber = getAuthNumber();
		String hashNumber = Hash.getHash(authNumber);
		inputData.setPerson_pw(hashNumber);
		dao.replacePw(inputData);
		return authNumber;
	}
	
	public String any(String person_phone, String content) throws Exception{
		String charsetType = "UTF-8";
		
		String tel1 = person_phone.substring(0, 3);
		String tel2 = person_phone.substring(3, 7);
		String tel3 = person_phone.substring(7, 11);
		
		String realTel = tel1 + "-" + tel2 + "-" + tel3;
		
		String sms_url = "";
        sms_url = "https://sslsms.cafe24.com/sms_sender.php"; // SMS 전송요청 URL
        String user_id = base64Encode("wjdwogns2860"); // SMS아이디
        String secure = base64Encode("6f1e994f48ad93c3df95fc6cc917d30c");//인증키
        String msg = base64Encode(nullcheck(content, ""));
        String rphone = base64Encode(nullcheck(realTel, ""));
        String sphone1 = base64Encode(nullcheck("010", ""));
        String sphone2 = base64Encode(nullcheck("2860", ""));
        String sphone3 = base64Encode(nullcheck("2892", ""));
        String mode = base64Encode("1");
        String subject = "";

        String[] host_info = sms_url.split("/");
        String host = host_info[2];
        String path = "/" + host_info[3];
        int port = 80;

        // 데이터 맵핑 변수 정의
        String arrKey[]
            = new String[] {"user_id","secure","msg", "rphone","sphone1","sphone2","sphone3","rdate","rtime"
                        ,"mode","testflag","destination","repeatFlag","repeatNum", "repeatTime", "smsType", "subject"};
        String valKey[]= new String[arrKey.length] ;
        valKey[0] = user_id;
        valKey[1] = secure;
        valKey[2] = msg;
        valKey[3] = rphone;
        valKey[4] = sphone1;
        valKey[5] = sphone2;
        valKey[6] = sphone3;
        valKey[7] = "";
        valKey[8] = "";
        valKey[9] = mode;
        valKey[10] = "";
        valKey[11] = "";
        valKey[12] = "";
        valKey[13] = "";
        valKey[14] = "";
        valKey[15] = "";
        valKey[16] = subject;

        String boundary = "";
        Random rnd = new Random();
        String rndKey = Integer.toString(rnd.nextInt(32000));
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] bytData = rndKey.getBytes();
        md.update(bytData);
        byte[] digest = md.digest();
        for(int i =0;i<digest.length;i++)
        {
            boundary = boundary + Integer.toHexString(digest[i] & 0xFF);
        }
        boundary = "---------------------"+boundary.substring(0,11);

        // 본문 생성
        String data = "";
        String index = "";
        String value = "";
        for (int i=0;i<arrKey.length; i++)
        {
            index =  arrKey[i];
            value = valKey[i];
            data +="--"+boundary+"\r\n";
            data += "Content-Disposition: form-data; name=\""+index+"\"\r\n";
            data += "\r\n"+value+"\r\n";
            data +="--"+boundary+"\r\n";
        }
        
        InetAddress addr = InetAddress.getByName(host);
        Socket socket = new Socket(host, port);
        // 헤더 전송
        BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), charsetType));
        wr.write("POST "+path+" HTTP/1.0\r\n");
        wr.write("Content-Length: "+data.length()+"\r\n");
        wr.write("Content-type: multipart/form-data, boundary="+boundary+"\r\n");
        wr.write("\r\n");

        // 데이터 전송
        wr.write(data);
        wr.flush();

        // 결과값 얻기
        BufferedReader rd = new BufferedReader(new InputStreamReader(socket.getInputStream(),charsetType));
        String line;
        String alert = "";
        ArrayList<Object> tmpArr = new ArrayList<Object>();
        while ((line = rd.readLine()) != null) {
            tmpArr.add(line);
        }
        wr.close();
        rd.close();

        String tmpMsg = (String)tmpArr.get(tmpArr.size()-1);
        String[] rMsg = tmpMsg.split(",");
        String Result= rMsg[0]; //발송결과
        String Count= ""; //잔여건수
        if(rMsg.length>1) {Count= rMsg[1]; }

                        //발송결과 알림
        if(Result.equals("success")) {
            alert = "성공적으로 발송하였습니다.";
            alert += " 잔여건수는 "+ Count+"건 입니다.";
        }
        else if(Result.equals("reserved")) {
            alert = "성공적으로 예약되었습니다";
            alert += " 잔여건수는 "+ Count+"건 입니다.";
        }
        else if(Result.equals("3205")) {
            alert = "잘못된 번호형식입니다.";
        }
        else {
            alert = "[Error]"+Result;
        }
        
        return msg;
	}
	
	public static String nullcheck(String str,  String Defaultvalue ) throws Exception
    {
         String ReturnDefault = "" ;
         if (str == null)
         {
             ReturnDefault =  Defaultvalue ;
         }
         else if (str == "" )
        {
             ReturnDefault =  Defaultvalue ;
         }
         else
         {
                     ReturnDefault = str ;
         }
          return ReturnDefault ;
    }
   public static String base64Encode(String str)  throws java.io.IOException {
       sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
       byte[] strByte = str.getBytes();
       String result = encoder.encode(strByte);
       return result ;
   }
   public static String base64Decode(String str)  throws java.io.IOException {
       sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
       byte[] strByte = decoder.decodeBuffer(str);
       String result = new String(strByte);
       return result ;
   }
	public List<HashMap<String, String>> regionSearchList(String keyword) {
		return dao.regionSearchList(keyword);
	}
	
	public ModelAndView loginProcess(ModelAndView mav, PersonDTO login, HttpSession session) {
		if(login != null) {
			session.setAttribute("login", login);
			// session으로 login을 등록하여 로그인 정보를 저장
		}
		else {
			String msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
			mav.addObject("msg", msg);
			mav.addObject("value", "loginFail");
			mav.setViewName("common/alert");//msg를 띄우고, value에 따른 페이지 이동을 하게 된다.
		}
		return mav;
	}
	
	public void joinProcess(String address, String detailAddress, PersonDTO inputData, String any) {
		String fullAddress = address + " " + detailAddress;// 넘겨받은 기본주소 + 상세주소를 합쳐서 완성된 주소를 저장
		inputData.setPerson_address(fullAddress);// 입력받은 inputData의 주소를 위에서 완성한 주소로 수정
		if(any != null) {
			if(any.equals("comp")) {//회사대표계정 회원가입시 진행됨.
				inputData.setPerson_belong(inputData.getPerson_belong().split(",")[0]);
				// 가입 조건의 회사이름을 가져와서 belong으로 세팅
				CompDTO comp = new CompDTO(inputData.getPerson_belong(), fullAddress);
				// 입력값과 합쳐진 완성된 주소값을 통해 CompDTO 객체 생성
				int row2 = companyAdd(comp);
				// 생성된 객체를 PersonService로 넘겨 DB에 회사정보를 추가시킴
			}
			if(any.equals("empl")) {//회사직원 가입시 진행됨
				inputData.setPerson_belong(inputData.getPerson_belong().split(",")[1]);
				// 가입 조건에서 선택한 회사이름을 가져와서 belong으로 세팅
			}
			if(any.equals("mu")) {//회사직원 가입시 진행됨
				inputData.setPerson_belong("무소속");
				// 가입 조건에서 선택한 회사이름을 가져와서 belong으로 세팅
			}
		}
	}
	public int updatePhone(PersonDTO login) {
		return dao.updatePhone(login);
	}
	public int phoneCheck(String person_phone) {
		return dao.phoneCheck(person_phone);
	}
}

