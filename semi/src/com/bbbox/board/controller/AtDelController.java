package com.bbbox.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.service.BoardService;
import com.bbbox.board.model.vo.Attachment;

/**
 * Servlet implementation class AtDelController
 */
@WebServlet("/atDel")
public class AtDelController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AtDelController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int fno = Integer.parseInt(request.getParameter("fno"));
		int bno = Integer.parseInt(request.getParameter("bno"));
		int category = Integer.parseInt(request.getParameter("c"));
//		System.out.println("fno"+fno);
//		System.out.println("bno"+bno);
		
		Attachment at = new BoardService().selectAttachment(bno);
		
//		System.out.println(at);
//		System.out.println(at.getFilePath());
		String savePath = "";
		if(category == 1) {
			savePath = request.getSession().getServletContext().getRealPath("/resources/1_board/");			
		}else if(category == 2) {
			savePath = request.getSession().getServletContext().getRealPath("/resources/2_board/");			
		}
		new File(savePath+at.getChangeName()).delete();
		
		int result = new BoardService().delAt(fno);
		
		if(result>0) {
			if(category==1) {
				response.sendRedirect(request.getContextPath()+"/update.bo?bno="+bno);				
			}else {
				response.sendRedirect(request.getContextPath()+"/update.vi?bno="+bno);
			}
		}else {
			request.setAttribute("errorMsg", "안될리가 없지만 혹시 모르니");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
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
