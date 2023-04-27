package com.bbbox.qaboard.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.member.model.vo.Member;
import com.bbbox.qaboard.model.service.QuestionService;
import com.bbbox.qaboard.model.vo.Question;

/**
 * Servlet implementation class QuestionDetailViewController
 */ 
@WebServlet("/detail.qa")
public class QuestionDetailViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuestionDetailViewController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int qno = Integer.parseInt(request.getParameter("qno"));

		int userNo = ((Member)(request.getSession().getAttribute("loginUser"))).getUserNo();
		
		String admin = ((Member)(request.getSession().getAttribute("loginUser"))).getAdmin();
		
		Question qa = new Question();
		
		if(admin.equals("Y")) {
			qa = new QuestionService().selectQuestion(qno, admin);
		}else {
			
			qa = new QuestionService().selectQuestion(qno,userNo);
		}
		
		request.setAttribute("qa", qa);
		
		request.getRequestDispatcher("views/board/questionBoard/questionDetailView.jsp").forward(request, response);
		
		
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
