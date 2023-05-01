package com.bbbox.manager.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.manager.service.ManagerService;

/**
 * Servlet implementation class BoardDeleteManager
 */
@WebServlet("/boardDel.ma")
public class BoardDeleteManager extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardDeleteManager() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int bno = Integer.parseInt(request.getParameter("bno"));
		//첨부파일 정보 날아가기전에 셀렉트 
		Attachment at = new ManagerService().selectAt(bno);
		Board b = new ManagerService().selectBoard(bno);
		
		System.out.println(at);
		System.out.println(b);
		int result = new ManagerService().freeBoardDelete(bno,at,b); 
		
		if(result>0) { //성공하면 파일지워주기		
			if(at != null) { //첨부파일 있으면 전부 삭제
				String savePath = "";
				if(b.getCategoryNo() == 1) {
					savePath = request.getSession().getServletContext().getRealPath("/resources/1_board/");			
				}else if(b.getCategoryNo() == 2) {
					savePath = request.getSession().getServletContext().getRealPath("/resources/2_board/");			
				}
				
				new File(savePath+at.getChangeName()).delete();
			}
		}
		
		response.getWriter().print(result);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
