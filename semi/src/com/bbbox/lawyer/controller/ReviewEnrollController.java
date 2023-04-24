package com.bbbox.lawyer.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		//리뷰작성 폼 띄우기 위한 정보 조회
		
		Lawyer l = new LawyerService().selectLawyer(Integer.parseInt(request.getParameter("lno")));
		//일단 고정값으로 테스트하고 위 구문으로 바꾸기
		//int lno = 1;
		//Lawyer l = new LawyerService().selectLawyer(lno);
		
		request.setAttribute("l", l);
		
		request.getRequestDispatcher("views/lawyer/reviewEnrollForm.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		//일단 사고 번호는 고정값으로 (REF_ANO)
		int accNo = 1;
		String star = request.getParameter("star");
		String content = request.getParameter("content");
		
		int result = new LawyerService().insertReview(accNo, star, content);
		
		if(result>0) { //성공시 알림메세지로 리뷰작성 완료 띄우고 마이페이지로 이동(재요청)
			request.getSession().setAttribute("alertMsg", "리뷰작성 완료");
			response.sendRedirect(request.getContextPath()+"/myPage.me");
		}else { //실패시 에러페이지로 이동(상담신청 작성 실패) 메세지 (위임)
			request.setAttribute("errorMsg", "리뷰작성 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	}

}
