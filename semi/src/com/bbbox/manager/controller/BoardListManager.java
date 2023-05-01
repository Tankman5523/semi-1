package com.bbbox.manager.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.vo.Board;
import com.bbbox.manager.service.ManagerService;
import com.google.gson.Gson;


/**
 * Servlet implementation class BoardListManager
 */
@WebServlet("/boardList.ma")
public class BoardListManager extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardListManager() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



		//카테고리 배열
		int[] cArr = new int[2];
		cArr[0] = 1; //카테고리번호 -> 일반게시판
		cArr[1] = 2; //카테고리번호 -> 영상게시판
		
		//정렬기능
		String sort = request.getParameter("sort");
		
		if(sort == null) {
			ArrayList<Board> list = new ManagerService().selectFreeBoardList(cArr);
		
			if(list != null) {
				request.setAttribute("boardList", list);
				request.getRequestDispatcher("views/manager/freeboard/boardListView.jsp").forward(request, response);
			}else {
				System.out.println("게시글 리스트조회 실패");
			}
		}else { //정렬에 관한 파라미터값이 넘어오면
		

			ArrayList<Board> list = new ManagerService().selectFreeBoardList(cArr, sort);
			
			if(list != null) {
				request.setAttribute("boardList", list);
				request.getRequestDispatcher("views/manager/freeboard/boardListView.jsp").forward(request, response);
				
			}else {
				System.out.println("게시글 리스트조회 실패");
			}
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
