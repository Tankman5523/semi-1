package com.bbbox.manager.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.vo.Board;
import com.bbbox.common.model.vo.PageInfo;
import com.bbbox.manager.service.ManagerService;


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

		//처음 넘어왔을땐 정렬 적용이 안된상태
		int a = 0;
		//카테고리 배열
		int[] cArr = new int[2];
		cArr[0] = 1; //카테고리번호 -> 일반게시판
		cArr[1] = 2; //카테고리번호 -> 영상게시판
		
		int listCount = new ManagerService().freeBoardCount(cArr); // 자유게시판의 총 게시글갯수(공지게시글, status=n상태 게시글 제외)
		int currentPage = 0; //현재 페이지
		if(request.getParameter("currentPage")==null) { 
			currentPage=1;
		}else{
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		int pageLimit = 5; //페이지 하단에 보여질 페이징 바의 페이지 최대 갯수
		int boardLimit = 20; //한페이지에서 보여질 게시글 최대 갯수

		int maxPage = (int)Math.ceil((double)listCount / boardLimit); //가장 마지막 페이지		
		int startPage=((int)Math.floor((currentPage-1)/pageLimit)) * pageLimit+1; //페이징 바의 시작 수
		int endPage = startPage+pageLimit-1; //페이징 바의 끝 수 
		
		if(endPage>maxPage) {
			endPage=maxPage; 
		} 
		
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
		
		//정렬기능
		String sort = request.getParameter("sort");
		
		
		if(sort == null) {
			ArrayList<Board> list = new ManagerService().selectFreeBoardList(pi, cArr);
		
			if(list != null) {
				request.setAttribute("a", a);
				request.setAttribute("pageInfo", pi);
				request.setAttribute("boardList", list);
				request.getRequestDispatcher("views/manager/freeboard/boardListView.jsp").forward(request, response);
			}else {
				System.out.println("게시글 리스트조회 실패");
			}
		}else { //검색에 관한 파라미터값이 넘어오면
		
			System.out.println("낼하자 후..");
//			System.out.println(new BoardService().boardKeywordCount(kind, keyword));
//			//키워드가 페이징에 영향을 주기때문에 영향받는 변수들 수정
//			a = 1;
//			
//			listCount = new BoardService().boardKeywordCount(kind, keyword);
//			maxPage = (int)Math.ceil((double)listCount / boardLimit);	
//			endPage = startPage+pageLimit-1;
//			if(endPage>maxPage) {
//				endPage=maxPage; 
//			}
//			
//			pi.setListCount(listCount);
//			pi.setMaxPage(maxPage);
//			pi.setEndPage(endPage);
//			
//			ArrayList<Board> list = new BoardService().selectBoardList(pi, kind, keyword);
//			
//			ArrayList<Board> nlist = null;
//			nlist = new BoardService().selectNoticeList();
//			
////			System.out.println(pi);
//			
//			if(list != null) {
//				
//				if(nlist != null) {
//					request.setAttribute("noticeList", nlist);
//				}
//				request.setAttribute("a", a);
//				request.setAttribute("kind", kind);
//				request.setAttribute("keyword", keyword);
//				request.setAttribute("pageInfo", pi);
//				request.setAttribute("boardList", list);
//				request.getRequestDispatcher("views/board/boardListView.jsp").forward(request, response);
//			}else {
//				System.out.println("게시글 리스트조회 실패");
//			}
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
