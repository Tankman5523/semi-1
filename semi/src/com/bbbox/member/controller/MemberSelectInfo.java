package com.bbbox.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.member.model.service.MemberService;
import com.bbbox.member.model.vo.Member;
import com.google.gson.Gson;


/**
 * Servlet implementation class MemberFindId
 */
@WebServlet("/find_info.me")
public class MemberSelectInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberSelectInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String email = request.getParameter("email");
		
		Member user = new MemberService().selectEmail(email);
		
		response.setContentType("json/application; charset=UTF-8");
		
		Gson gson = new Gson();
		
		if(user != null) { //회원정보 존재 
			
			gson.toJson(user, response.getWriter());
			
		}else{
			
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
