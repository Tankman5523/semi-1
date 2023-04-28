package com.bbbox.manager.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.common.model.vo.PageInfo;
import com.bbbox.qaboard.model.service.QuestionService;
import com.bbbox.qaboard.model.vo.Question;

/**
 * Servlet implementation class ManagerQuestionBoardListController
 */
@WebServlet("/manage.list.qa")
public class ManagerQuestionBoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerQuestionBoardListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ArrayList <Question> qList = new QuestionService().selectQuestionBoardList();
		
		//페이징 처리를 위해 모든 게시글 숫자 조회해오기 
				int listCount = new QuestionService().selectQuestionBoardCount();
				
				int currentPage = 0; // 현재페이지
				
				if(request.getParameter("currentPage") == null) {
					currentPage = 1;
				}else {
					currentPage=Integer.parseInt(request.getParameter("currentPage"));
				}
				
				int pageLimit = 5; //페이지 하단에 보여질 페이징 바의 최대 갯수
				int boardLimit = 10; //한 페이지에서 보여질 게시글의 최대 개수
				int maxPage =(int)Math.ceil((double)listCount/boardLimit); // 가장 마지막 페이지
				int startPage = ((int)Math.floor((currentPage-1))/pageLimit)* pageLimit+1; // 페이징바의 시작수 
				int endPage = startPage + pageLimit -1; //페이징바의 끝 수 
				
				if(endPage>maxPage) {
					endPage = maxPage;
				}
				
				PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit,maxPage,startPage,endPage);
				
				//1:1문의 게시판으로 위임
				request.setAttribute("pageInfo", pi);
				request.setAttribute("qList", qList);
				
				request.getRequestDispatcher("views/manager/manager_qaBoardList.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
