package com.bbbox.lawyer.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.lawyer.model.service.LawyerService;
import com.bbbox.lawyer.model.vo.Counsel;
import com.bbbox.lawyer.model.vo.Lawyer;

/**
 * Servlet implementation class CounselDetailLawController
 */
@WebServlet("/counselDetailLaw.la")
public class CounselDetailLawController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CounselDetailLawController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//상담 상세보기 (변호사용)
		
			//마이페이지에서 상담번호 받아와서 상담정보 조회
			int cno = Integer.parseInt(request.getParameter("cno"));
			Counsel c = new LawyerService().selectCounselLaw(cno);
			//상담정보의 참조변호로 조회한 변호사 정보 조회 //필요없으면 삭제 //조회해오려면 selectCounselLaw 수정해야함
			//Lawyer l = new LawyerService().selectLawyer(Integer.parseInt(c.getRefLno()));
			//request.setAttribute("l", l);
			
			request.setAttribute("c", c);
			request.getRequestDispatcher("views/lawyer/counselDetailLawView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
