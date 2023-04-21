package com.bbbox.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.member.model.service.MemberService;
import com.bbbox.member.model.vo.Member;

/**
 * Servlet implementation class MemberEmailCheck
 */
@WebServlet("/email.chk.me")
public class MemberEmailCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberEmailCheck() {
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
	
		String testEmail = request.getParameter("testEmail");
		
		System.out.println(testEmail); //잘 넘어오는지 확인하기
		
		//이메일 중복 확인
		
		Member m = new MemberService().selectEmail(testEmail);
		
//		System.out.println(m); //확인용도
		
		if(m != null ) { //이메일 중복
			response.getWriter().print("NNNNN");

		}else{ //이메일 사용가능 - 인증 메일 보내기
			response.getWriter().print("YYYYY");
		}
	}
}
