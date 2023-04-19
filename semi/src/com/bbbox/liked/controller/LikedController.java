package com.bbbox.liked.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.bbbox.board.model.service.BoardService;
import com.bbbox.liked.model.service.LikedService;
import com.bbbox.liked.model.vo.Liked;

/**
 * Servlet implementation class LikedController
 */
@WebServlet("/liked.bo")
public class LikedController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LikedController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int boardNo = Integer.parseInt(request.getParameter("bno"));
		int userNo = Integer.parseInt(request.getParameter("uno"));
		
		Liked l = new Liked(userNo, boardNo);
		
		//좋아요등록
		int result = new LikedService().insertLiked(l);
		
		int result2 = 0;
		
		if(result>0) {
			//보드에 좋아요카운트 갱신
			result2 = new BoardService().insertLiked(boardNo);
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
