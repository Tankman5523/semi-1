package com.bbbox.lawyer.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.lawyer.model.service.LawyerService;

/**
 * Servlet implementation class ReviewDeleteController
 */
@WebServlet("/reviewDelete.la")
public class ReviewDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//변호사 리뷰 삭제
		
		int reNo = Integer.parseInt(request.getParameter("reNo"));
		
		int result = new LawyerService().deleteReview(reNo);
		
		if(result>0) { //성공시 알림메세지로 리뷰 삭제 완료 띄우고 마이페이지로 이동(재요청)
			request.getSession().setAttribute("alertMsg", "리뷰 삭제 완료");
			response.sendRedirect(request.getContextPath()+"/myPage.me");
		}else { //실패시 에러페이지로 이동(리뷰 삭제 실패) 메세지 (위임)
			request.setAttribute("errorMsg", "리뷰 삭제 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//마이페이지에서 리뷰 삭제하기 
		
		int reNo = Integer.parseInt(request.getParameter("reNo"));
	
		int result = new LawyerService().deleteReview(reNo);
		
		if(result>0) {
			response.getWriter().print("YY");
		}else {
			response.getWriter().print("NN");
		}
		
	}

}
