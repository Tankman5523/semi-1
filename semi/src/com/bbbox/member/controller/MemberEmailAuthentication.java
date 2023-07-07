package com.bbbox.member.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.member.model.vo.AuthKey;
import com.google.gson.Gson;

/**
 * Servlet implementation class MemberEmailAuthentication
 */
@WebServlet("/authentication.me")
public class MemberEmailAuthentication extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberEmailAuthentication() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String sendEmail = request.getParameter("sendEmail");
		
		System.out.println(sendEmail); //잘 넘어오는지 확인하기
		
		
		//SMTP 서버 정보 설정
		Properties prop = new Properties();
		prop.put("mail.smtp.starttls.enable","true");
		prop.put("mail.smtp.auth","true");
		prop.put("mail.smtp.port", "587"); 
		prop.put("mail.smtp.host","smtp.naver.com");


		Authenticator auth = new MyAuthentication();
		Session session = Session.getDefaultInstance(prop, auth);
		MimeMessage msg = new MimeMessage(session);
		
		try{
			msg.setSentDate(new Date());	
			InternetAddress from = new InternetAddress();
			
			from = new InternetAddress("bb_box<mmute96@naver.com>");
			msg.setFrom(from);
			
			InternetAddress to = new InternetAddress(sendEmail);
			msg.setRecipient(Message.RecipientType.TO, to);
			
			//메일 제목 
			msg.setSubject("안녕하세요 블변의법칙 인증 메일입니다", "UTF-8");
		
	
			//인증번호 생성하기
			StringBuffer temp = new StringBuffer();
			
			Random ran = new Random();
			for(int i = 0 ; i <10; i++) {
				
				int ranIndex = ran.nextInt(3);
				
				switch(ranIndex) {
				case 0 : //a-z
					temp.append((char)((int)(ran.nextInt(26))+97)); break;
					
				case 1 : //A-Z
					temp.append((char)((int)(ran.nextInt(26))+65)); break;
					
				case 2 : //0-9
					
					temp.append(ran.nextInt(10)); break;
					}
			}
				String AuthenticationKey = temp.toString(); //난수 스트링화 
				
				System.out.println(AuthenticationKey); //난수 확인용 
				
				//jsp로 넘기기
				response.setContentType("json/application; charset=UTF-8");
				
				AuthKey key = new AuthKey("Y", AuthenticationKey);
				
				Gson gson = new Gson();
				//gson.toJson(응답객체, 스트림);
				
				gson.toJson(key, response.getWriter()); //변환시 전달되는 키값은 vo의 필드명으로 지정한다
				
				//메일 내용
				msg.setText("이메일 확인 인증 번호는 [" + temp +"] 입니다. 인증번호란에 정확히 입력해 주세요.");
				msg.setHeader("content-Type","text/html");
				
				javax.mail.Transport.send(msg); //메일발송 
		
			}catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
	}
	
	class MyAuthentication extends Authenticator{
		PasswordAuthentication account;
		 
		public MyAuthentication() {
			String id = "";
			String password =""; 
			account = new PasswordAuthentication(id,password);
			
		}
		
		public PasswordAuthentication getPasswordAuthentication() {
			
			return account;
		}
	
	}
				

	
}
			
		
		
		

