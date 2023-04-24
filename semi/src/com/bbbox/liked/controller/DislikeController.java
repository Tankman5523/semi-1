package com.bbbox.liked.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.service.BoardService;
import com.bbbox.liked.model.service.LikedService;
import com.bbbox.liked.model.vo.Dislike;

/**
 * Servlet implementation class DislikeController
 */
@WebServlet("/dislike.bo")
public class DislikeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DislikeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int boardNo = Integer.parseInt(request.getParameter("bno"));
		int userNo = Integer.parseInt(request.getParameter("uno"));
		
		Dislike dl = new Dislike(userNo,boardNo);
		
		int result = new LikedService().insertDislike(dl);
		
		int result2 = 0;
		
		if(result>0) {
			result2 = new BoardService().insertDislike(boardNo);
		}
		
		response.getWriter().print(result2);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
