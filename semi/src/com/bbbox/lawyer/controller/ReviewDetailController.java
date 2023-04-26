package com.bbbox.lawyer.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.vo.Accident;
import com.bbbox.lawyer.model.service.LawyerService;
import com.bbbox.lawyer.model.vo.LawReview;
import com.bbbox.lawyer.model.vo.Lawyer;

/**
 * Servlet implementation class ReviewDetailController
 */
@WebServlet("/reviewDetail.la")
public class ReviewDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//변호사 리뷰 상세보기
		
		int reNo = Integer.parseInt(request.getParameter("reNo"));
		LawReview re = new LawyerService().selectReview(reNo);
		Accident ac = new LawyerService().selectAccident(re.getRefAno());
		Lawyer l = new LawyerService().selectLawyer(ac.getRefLno());
		
		request.setAttribute("re", re);
		request.setAttribute("ac", ac);
		request.setAttribute("l", l);
		request.getRequestDispatcher("views/lawyer/reviewDetailView.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
