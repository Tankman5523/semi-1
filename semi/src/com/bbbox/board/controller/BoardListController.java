package com.bbbox.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.service.BoardService;
import com.bbbox.board.model.vo.Board;
import com.bbbox.common.model.vo.PageInfo;

/**
 * Servlet implementation class BoardListController
 */
@WebServlet("/list.bo")
public class BoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		int listCount = new BoardService().boardListCount();	
		int currentPage = 0;
		if(request.getParameter("currentPage")==null) {
			currentPage=1;
		}else{
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		int pageLimit = 5;
		int boardLimit = 10;
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);		
		int startPage=((int)Math.floor((currentPage-1)/pageLimit)) * pageLimit+1;
		int endPage = startPage+pageLimit-1;
		
		
		if(endPage>maxPage) {
			endPage=maxPage; 
		}
		
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
		
		//검색기능
		String kind = request.getParameter("kind");
		String keyword = request.getParameter("keyword");
		
		
		if(kind == null && keyword == null) {
			ArrayList<Board> list = new BoardService().selectBoardList(pi);
			
			ArrayList<Board> nlist = null;
			nlist = new BoardService().selectNoticeList();
			
			if(list != null) {
				
				if(nlist != null) {
					request.setAttribute("noticeList", nlist);
				}
				request.setAttribute("pageInfo", pi);
				request.setAttribute("boardList", list);
				request.getRequestDispatcher("views/board/boardListView.jsp").forward(request, response);
			}else {
				System.out.println("게시글 리스트조회 실패");
			}
		}else { //검색에 관한 파라미터값이 넘어오면
			ArrayList<Board> list = new BoardService().selectBoardList(pi, kind, keyword);
			
			ArrayList<Board> nlist = null;
			nlist = new BoardService().selectNoticeList();
			
			if(list != null) {
				
				if(nlist != null) {
					request.setAttribute("noticeList", nlist);
				}
				request.setAttribute("pageInfo", pi);
				request.setAttribute("boardList", list);
				request.getRequestDispatcher("views/board/boardListView.jsp").forward(request, response);
			}else {
				System.out.println("게시글 리스트조회 실패");
			}
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
