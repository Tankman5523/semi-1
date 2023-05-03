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
 * Servlet implementation class VideoListController
 */
@WebServlet("/list.vi")
public class VideoListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VideoListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int a = 0;
		
		int listCount = new BoardService().VideoListCount(); //현재 총 게시글의 갯수
		int currentPage = 0; //현재 페이지
		if(request.getParameter("currentPage")==null) { 
			currentPage=1;
		}else{
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		int pageLimit = 5; //페이지 하단에 보여질 페이징 바의 페이지 최대 갯수
		int boardLimit = 9; //한페이지에서 보여질 게시글 최대 갯수
		int maxPage = (int)Math.ceil((double)listCount / boardLimit); //가장 마지막 페이지		
		int startPage=((int)Math.floor((currentPage-1)/pageLimit)) * pageLimit+1; //페이징 바의 시작 수
		int endPage = startPage+pageLimit-1; //페이징 바의 끝 수 
		
		if(endPage>maxPage) {
			endPage=maxPage; 
		} 
		
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
		
		//검색기능
		String kind = request.getParameter("kind");
		String keyword = request.getParameter("keyword");
		
		
		if(kind == null && keyword == null) {
			ArrayList<Board> vlist = new BoardService().selectVideoList(pi);
			
//			System.out.println(vlist);
			
			ArrayList<Board> nlist = null;
			nlist = new BoardService().selectNoticeList();
			
			if(vlist != null) {
				
				if(nlist != null) {
					request.setAttribute("noticeList", nlist);
				}
				request.setAttribute("a", a);
				request.setAttribute("pageInfo", pi);
				request.setAttribute("vlist", vlist);
				request.getRequestDispatcher("views/board/videoListView.jsp").forward(request, response);
			}else {
				System.out.println("게시글 리스트조회 실패");
			}
		}else { //검색에 관한 파라미터값이 넘어오면
			
			a = 1;
			
			listCount = new BoardService().videoKeywordCount(kind, keyword);
			maxPage = (int)Math.ceil((double)listCount / boardLimit);	
			endPage = startPage+pageLimit-1;
			if(endPage>maxPage) {
				endPage=maxPage; 
			}
			
			pi.setListCount(listCount);
			pi.setMaxPage(maxPage);
			pi.setEndPage(endPage);
			
			ArrayList<Board> vlist = new BoardService().selectVideoList(pi, kind, keyword);
			
			ArrayList<Board> nlist = null;
			nlist = new BoardService().selectNoticeList();
			
			if(vlist != null) {
				
				if(nlist != null) {
					request.setAttribute("noticeList", nlist);
				}
				
				request.setAttribute("a", a);
				request.setAttribute("kind", kind);
				request.setAttribute("keyword", keyword);
				request.setAttribute("pageInfo", pi);
				request.setAttribute("vlist", vlist);
				request.getRequestDispatcher("views/board/videoListView.jsp").forward(request, response);
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
