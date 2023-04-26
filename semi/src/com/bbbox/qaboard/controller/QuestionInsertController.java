package com.bbbox.qaboard.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.member.model.vo.Member;
import com.bbbox.qaboard.model.service.QuestionService;

/**
 * Servlet implementation class QuestionDetailView
 */
@WebServlet("/insert.qa")
public class QuestionInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuestionInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		//페이지 위임 
		request.getRequestDispatcher("views/board/questionBoard/questionInsertView.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		int userNo = ((Member)request.getSession().getAttribute("loginUser")).getUserNo();

		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String open = request.getParameter("open");
		
		int result = new QuestionService().insertQuestion(userNo, title, content, open);
		
		if(result>0) {
			request.getSession().setAttribute("alertMsg", "문의글 작성이 완료되었습니다.");
			response.sendRedirect(request.getContextPath()+"/list.qa");
			
		}else {
			request.setAttribute("errorMsg","문의글 작성에 실패하였습니다. 다시 시도해주세요 ");
			request.getRequestDispatcher("/list.qa").forward(request, response);
		}
		
		
		
		
		
	
	}

}
