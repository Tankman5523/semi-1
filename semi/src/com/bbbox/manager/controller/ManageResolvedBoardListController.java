package com.bbbox.manager.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.service.AccidentBoardService;
import com.bbbox.board.model.vo.Board;
import com.bbbox.common.model.vo.PageInfo;
import com.bbbox.manager.service.ManagerService;

/**
 * Servlet implementation class ManageResolvedBoardListController
 */
@WebServlet("/list.mrb")
public class ManageResolvedBoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageResolvedBoardListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int listCount; //현재 총 게시글의 갯수
		int currentPage; //현재 페이지
		int pageLimit; //페이지 하단에 보여질 페이징 바의 페이지 최대 갯수
		int boardLimit; //한페이지에서 보여질 게시글 최대 갯수
		
		int maxPage; //가장 마지막 페이지가 몇페이지인지 (총 페이지의 갯수)
		int startPage; //페이지 하단에 보여질 페이징 바의 시작 수
		int endPage; //페이지 하단에 보여질 페이징 바의 끝 수
		
		//전체 글 갯수 구하는 메소드
		listCount = new AccidentBoardService().selectResolvedBoardListCount();
		
		//현재 페이지
		if(request.getParameter("currentPage")==null) {
			currentPage=1;
		}else{
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//pageLimit : 페이지 하단에 보여질 페이징 바의 페이지 최대개수 (목록단위)
		pageLimit = 15;
		
		//boardLimit : 한 페이지에 보여질 게시글 개수 (게시글 단위)
		boardLimit = 15;
		
		//maxPage ; listCount와 boardLimit의 영향을 받는 수
		maxPage = (int)Math.ceil((double)listCount / boardLimit);		
		
		//시작페이징바 시작
		startPage=((int)Math.floor((currentPage-1)/pageLimit)) * pageLimit+1;
		
		//endPage : 페이징바 끝수.
		endPage = startPage+pageLimit-1;
		
		if(endPage>maxPage) {//끝수가 총 페이지 수보다 크다면, 해당 수를 총 페이지 수로 바꿔주기
			endPage=maxPage; 
		}
		//정보 객체에 넣기
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
		
		//sort 키워드 가져오기
		String sort = request.getParameter("searchSort"); 
		
		ArrayList<Board> blist = new ManagerService().selectAllResolvedBoard(pi,sort);
		
		request.setAttribute("pi", pi);
		request.setAttribute("blist", blist);
		request.getRequestDispatcher("views/manager/manage_resolvedBoardList_view.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
