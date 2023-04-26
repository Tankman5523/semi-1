package com.bbbox.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.service.BoardService;

/**
 * Servlet implementation class delRpController
 */
@WebServlet("/delRp")
public class delRpController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public delRpController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int rpNo = Integer.parseInt(request.getParameter("rpNo"));
		int bno = Integer.parseInt(request.getParameter("bno"));
		System.out.println(rpNo);
		
		//RP테이블에서 삭제
		int result = new BoardService().delRp(rpNo);
		
		int result2 = 0;
		if(result>0) {
			//rp테이블 삭제 성공했으면 board테이블에서 rp카운트 다운
			result2 = new BoardService().RpCountDown(bno);
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
