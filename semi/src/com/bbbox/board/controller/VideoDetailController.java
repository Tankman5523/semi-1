package com.bbbox.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.service.BoardService;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;

/**
 * Servlet implementation class VideoDetailController
 */
@WebServlet("/detail.vi")
public class VideoDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VideoDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//보고자 하는 게시글 번호
		int boardNo = Integer.parseInt(request.getParameter("bno"));
		
		//조회수 증가
		int result = new BoardService().increaseBoardCount(boardNo);
		
		if(result>0) {
			Board b = new BoardService().selectBoard(boardNo);

			Attachment at = new BoardService().selectAttachment(boardNo);

//			System.out.println(b);
//			System.out.println(at);
			
			request.setAttribute("board", b);
			request.setAttribute("at", at);

			request.getRequestDispatcher("views/board/videoDetailView.jsp").forward(request, response);
		}else {
			System.out.println("조회수 증가 실패");
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
