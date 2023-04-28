package com.bbbox.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.lawyer.model.service.LawyerService;
import com.bbbox.lawyer.model.vo.LawAttachment;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.member.model.service.MemberService;
import com.bbbox.member.model.vo.Member;

/**
 * Servlet implementation class MemberApplyLawyerDetailController
 */
@WebServlet("/detail.apply.me")
public class MemberApplyLawyerDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberApplyLawyerDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int userNo = Integer.parseInt(request.getParameter("uno"));
		
		Lawyer lawInfo = new LawyerService().selectApply(userNo); //변호사 정보 
		
		String lat = new LawyerService().selectLawAttachment(userNo);
		
		Member applyMem = new MemberService().selectMemberInfo(userNo);
		
		request.setAttribute("lawInfo", lawInfo);
		request.setAttribute("applyMem", applyMem);
		request.setAttribute("lat", lat);
		request.getRequestDispatcher("views/manager/manage_applyLawyerDetailForm.jsp").forward(request, response);
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
