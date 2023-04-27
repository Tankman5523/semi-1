package com.bbbox.manager.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.member.model.service.MemberService;

/**
 * Servlet implementation class ManagerApplyLawyerAcceptController
 */
@WebServlet("/apply.ac")
public class ManagerApplyLawyerAcceptController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerApplyLawyerAcceptController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//변호사 회원 승인
		
		int uno = Integer.parseInt(request.getParameter("uno"));
		
		int resultNum = Integer.parseInt(request.getParameter("resultNum"));
		
		int result = new MemberService().acceptLawyer(uno, resultNum);	
		
		if(result>0) {
			response.getWriter().print("YY");
		}else {
			response.getWriter().print("NN");
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
