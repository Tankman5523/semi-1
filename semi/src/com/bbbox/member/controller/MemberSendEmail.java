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

import com.bbbox.member.model.service.MemberService;
import com.bbbox.member.model.vo.Member;

/**
 * Servlet implementation class MemberEmailSend
 */
@WebServlet("/email_id.me")
public class MemberSendEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberSendEmail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//비밀번호 찾기 
		String email = request.getParameter("email");
		
		//SMTP서버 정보 설정
		Properties prop = new Properties();
		prop.put("mail.smtp.starttls.enable","true");
		prop.put("mail.smtp.auth","true");
		prop.put("mail.smtp.port", "587"); 
		prop.put("mail.smtp.host","smtp.naver.com");


		Authenticator auth = new MyAuthentication();
		Session session = Session.getDefaultInstance(prop, auth);
		MimeMessage msg = new MimeMessage(session);
		
		try {
			msg.setSentDate(new Date());	
			InternetAddress from = new InternetAddress();
			
			from = new InternetAddress("bb_box<mmute96@naver.com>");
			msg.setFrom(from);
			
			InternetAddress to = new InternetAddress(email);
			msg.setRecipient(Message.RecipientType.TO, to);
			
			//메일 제목 
			msg.setSubject("안녕하세요 블변의법칙입니다.", "UTF-8");
			
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
			
			String tempPwd = temp.toString(); //난수 스트링화 
			
			int updatePwd = new MemberService().updatePwd(email, tempPwd); //비밀번호 업데이트 
			
			
			//jsp로 넘기기
			response.setContentType("text/html; charset=UTF-8");
			
			response.getWriter().print("Y");
			
			//메일 내용
			msg.setText("회원님의 임시 비밀번호는 [" + temp +"] 입니다. 로그인 후 마이페이지 - 비밀번호 변경을통해 회원 정보 변경을 해주세요.");
			msg.setHeader("content-Type","text/html");
			
			javax.mail.Transport.send(msg); //메일발송 


			
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	//아이디찾	기 
		
		String email = request.getParameter("email");
		
//		System.out.println(email); //잘 넘어오는지 확인하기
		
		
		//SMTP 서버 정보 설정
		Properties prop = new Properties();
		prop.put("mail.smtp.starttls.enable","true");
		prop.put("mail.smtp.auth","true");
		prop.put("mail.smtp.port", "587"); 
		prop.put("mail.smtp.host","smtp.naver.com");


		Authenticator auth = new MyAuthentication();
		Session session = Session.getDefaultInstance(prop, auth);
		MimeMessage msg = new MimeMessage(session);
		
		try {
			msg.setSentDate(new Date());	
			InternetAddress from = new InternetAddress();
			
			from = new InternetAddress("bb_box<mmute96@naver.com>");
			msg.setFrom(from);
			
			InternetAddress to = new InternetAddress(email);
			msg.setRecipient(Message.RecipientType.TO, to);
			
			//메일 제목 
			msg.setSubject("안녕하세요 블변의법칙입니다.", "UTF-8");
			
			//아이디 조회해오기 
			
			Member user = new MemberService().selectEmail(email);
			
			
			String userId = user.getUserId();
			
			System.out.println(userId);
			
			//jsp로 넘기기
			response.setContentType("text/html; charset=UTF-8");
			
			response.getWriter().print("Y");
			
			//메일 내용
			msg.setText("회원님의 아이디는 [" + userId +"] 입니다.");
			msg.setHeader("content-Type","text/html");
			
			javax.mail.Transport.send(msg); //메일발송 


			
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		
	}

	class MyAuthentication extends Authenticator{
		PasswordAuthentication account;
		 
		public MyAuthentication() {
			String id = "mmute96@naver.com";
			String password = "dmadkrgkwk77";
			account = new PasswordAuthentication(id,password);
			
	}
		
	public PasswordAuthentication getPasswordAuthentication() {
			
			return account;
		}
	
	}
	

}
