package com.bbbox.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.service.AccidentBoardService;
import com.bbbox.board.model.service.BoardService;
import com.bbbox.board.model.vo.Accident;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;

/**
 * Servlet implementation class AccidentBoardDetailController
 */
@WebServlet("/detail.ac")
public class AccidentBoardDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccidentBoardDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int bno = Integer.parseInt(request.getParameter("bno"));
		
		//조회수 카운팅
		int result = new BoardService().increaseBoardCount(bno);
		
		if(result>0) {
			//게시판정보 + 첨부파일 경로
			Board b = new AccidentBoardService().accidentBoardSelectDetail(bno);
			//사건정보
			Accident ac = new AccidentBoardService().accidentSelectDetail(bno);
			//댓글정보
			ArrayList<Reply> rplist = new AccidentBoardService().accidentReplySelectDetail(bno);
			
			if(b!=null&&ac!=null&&rplist!=null) {//성공
				request.setAttribute("board", b);
				request.setAttribute("accident", ac);
				request.setAttribute("rplist", rplist);
				
				request.getRequestDispatcher("views/board/accidentBoardDetailView.jsp").forward(request, response);
			}else {//실패
				request.setAttribute("errorMsg", "게시물 조회 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
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
