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

/**
 * Servlet implementation class NoticeListManager
 */
@WebServlet("/noticeList.ma")
public class NoticeListManager extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeListManager() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//정렬기능
		String sort = request.getParameter("sort");
		
		if(sort == null) {
			//공지사항리스트 조회
			ArrayList<Board> nlist = new ManagerService().selectFreeBoardNoticeList();
		
			if(nlist != null) {
				request.setAttribute("nlist", nlist);
				request.getRequestDispatcher("views/manager/freeboard/noticeListView.jsp").forward(request, response);
			}else {
				System.out.println("게시글 리스트조회 실패");
			}
		}else { //정렬에 관한 파라미터값이 넘어오면
		

//			ArrayList<Board> nlist = new ManagerService().selectFreeBoardNoticeList(sort);
//			
//			if(nlist != null) {
//				request.setAttribute("nlist", nlist);
//				request.getRequestDispatcher("views/manager/freeboard/noticeListView.jsp").forward(request, response);
//				
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
