package com.bbbox.lawyer.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.vo.Accident;
import com.bbbox.lawyer.model.service.LawyerService;
import com.bbbox.lawyer.model.vo.Lawyer;

/**
 * Servlet implementation class ReviewEnrollController
 */
@WebServlet("/review.la")
public class ReviewEnrollController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewEnrollController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//변호사 리뷰 작성 폼 띄우기 위한 정보 조회
		
		//사건번호로 사건정보 조회 & 참조변호사번호로 변호사 정보 조회
		Accident ac = new LawyerService().selectAccident(Integer.parseInt(request.getParameter("accNo")));
		Lawyer l = new LawyerService().selectLawyer(ac.getRefLno());
		
		request.setAttribute("ac", ac);
		request.setAttribute("l", l);
		request.getRequestDispatcher("views/lawyer/reviewEnrollForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//변호사 리뷰 작성 등록
		
		request.setCharacterEncoding("UTF-8");
		
		int accNo = Integer.parseInt(request.getParameter("accNo"));
		String star = request.getParameter("star");
		String content = request.getParameter("content");
		
		int result = new LawyerService().insertReview(accNo, star, content);
		
		if(result>0) {
			request.getSession().setAttribute("alertMsg", "리뷰작성 완료");
			response.sendRedirect(request.getContextPath()+"/myPage.me");
		}else {
			request.setAttribute("errorMsg", "리뷰작성 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	}

}
