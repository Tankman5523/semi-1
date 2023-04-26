package com.bbbox.lawyer.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.lawyer.model.service.LawyerService;

/**
 * Servlet implementation class CounselAnswerController
 */
@WebServlet("/counselAnswer.la")
public class CounselAnswerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CounselAnswerController() {
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
		//변호사 답변 등록 
		
		request.setCharacterEncoding("UTF-8");
		
		String aResult = request.getParameter("result");
		String answer = request.getParameter("answer");
		int csNo = Integer.parseInt(request.getParameter("csNo"));
		
		int result = new LawyerService().updateAnswer(aResult, answer, csNo);
		
		if(result>0) {
			request.getSession().setAttribute("alertMsg", "답변 등록 완료");
			response.sendRedirect(request.getContextPath()+"/myPage.me");
		}else {
			request.setAttribute("errorMsg", "답변 등록 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	}

}
