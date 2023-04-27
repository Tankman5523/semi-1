package com.bbbox.qaboard.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.qaboard.model.service.QuestionService;

/**
 * Servlet implementation class QuestionAnswerController
 */
@WebServlet("/answer.qa")
public class QuestionAnswerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuestionAnswerController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 답변 조회
		response.setContentType("text/html; charset=UTF-8");
		
		int qno = Integer.parseInt(request.getParameter("qno"));
		
		System.out.println(qno);
		
		String answer = new QuestionService().selectAnswer(qno);
		
		if(answer != null) {
			response.getWriter().print(answer);
		}
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//답변 입력 
		
		int qno = Integer.parseInt(request.getParameter("qno"));
		
		String answer = request.getParameter("answer");
		
		int result = new QuestionService().insertAnswer(qno,answer);
		
		
		if (result>0) {
			
			response.getWriter().print("YY");
		}else {
			response.getWriter().print("NN");
		}
	
	}

}
