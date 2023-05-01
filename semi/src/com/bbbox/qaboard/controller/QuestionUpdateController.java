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
 * Servlet implementation class QuestionUpdateController
 */
@WebServlet("/modify.qa")
public class QuestionUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuestionUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1대1문의 게시판 업데이트 페이지 위임
		
		int userNo = ((Member)request.getSession().getAttribute("loginUser")).getUserNo();
		
		int qno = Integer.parseInt(request.getParameter("qno"));
		
		Question qa = new QuestionService().selectQuestion(qno, userNo);
		
		request.setAttribute("qa", qa);
		request.getRequestDispatcher("views/board/questionBoard/questionUpdateView.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		//수정 페이지에서 DB에 넣을 정보 가져오기 
		
		request.setCharacterEncoding("UTF-8");
	
		int qno = Integer.parseInt(request.getParameter("qno"));
		
		System.out.println(qno);
		String open = request.getParameter("open");
		
		String title = request.getParameter("title");
		
		String content = request.getParameter("content");
		
		Question updateQa = new Question();
		
		updateQa.setqNo(qno);
		updateQa.setOpen(open);
		updateQa.setTitle(title);
		updateQa.setContent(content);

		int result = new QuestionService().updateQuestion(updateQa);
		
		if(result>0) {
			request.getSession().setAttribute("alertMsg","게시글 수정이 완료되었습니다.");
			response.sendRedirect(request.getContextPath()+"/list.qa");
		}else{
			request.setAttribute("errorMsg", "게시글 수정에 실패하였습니다. 다시 시도해주세요.");
			request.getRequestDispatcher("views/board/questionBoard/questionBOardListView.jsp").forward(request, response);
		}
	
	}

}
