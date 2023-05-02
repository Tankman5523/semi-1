package com.bbbox.lawyer.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.lawyer.model.service.LawyerService;
import com.bbbox.lawyer.model.vo.Counsel;
import com.bbbox.lawyer.model.vo.Lawyer;

/**
 * Servlet implementation class CounselDetailController
 */
@WebServlet("/counselDetail.la")
public class CounselDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CounselDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//상담 상세보기 (일반 회원용)
		
		int cno = Integer.parseInt(request.getParameter("cno"));
		
		
		Counsel c = new LawyerService().selectCounsel(cno);
	
		Lawyer l = new LawyerService().selectLawyer(Integer.parseInt(c.getRefLno()));
		
		System.out.println("l:" + l);
		
		if(l != null) {
			request.setAttribute("c", c);
			request.setAttribute("l", l);
			request.getRequestDispatcher("views/lawyer/counselDetailView.jsp").forward(request, response);
		}else { //회원탈퇴 하거나 없는경우 (mapper에서 조건걸 수 있으면 이 조건문 없애기) (회원마이페이지에서 오류남 고치기)
			request.getSession().setAttribute("alertMsg", "탈퇴하거나 존재하지 않는 회원입니다.");
			request.setAttribute("cList", new LawyerService().selectCounselList());
			request.getRequestDispatcher("views/manager/manage_counselList_view.jsp").forward(request, response);
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
