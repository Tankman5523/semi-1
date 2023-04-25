package com.bbbox.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.service.AccidentBoardService;

/**
 * Servlet implementation class AccidentReviewDeleteController
 */
@WebServlet("/delete.ar")
public class AccidentReviewDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccidentReviewDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int bno = Integer.parseInt(request.getParameter("bno"));
		int arNo = Integer.parseInt(request.getParameter("arNo"));
		int accNo = Integer.parseInt(request.getParameter("accNo"));
		
		int result = new AccidentBoardService().deleteAccidentReview(arNo);
		int result2 = new AccidentBoardService().returnBoard(bno,accNo);
		
		
		if(result>0 && result2>0) {
			
			request.getSession().setAttribute("alertMsg", "리뷰가 성공적으로 삭제되었습니다.");
			response.sendRedirect(request.getContextPath()+"/detail.ac?bno="+bno);
		}else {
			
			request.setAttribute("errorMsg", "리뷰삭제 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
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
