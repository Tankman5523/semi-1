package com.bbbox.manager.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.dao.AccidentBoardDao;
import com.bbbox.board.model.service.AccidentBoardService;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.manager.service.ManagerService;

/**
 * Servlet implementation class ManageAccidentBoardDeleteController
 */
@WebServlet("/deleteReal.mac")
public class ManageAccidentBoardDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageAccidentBoardDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int bno = Integer.parseInt(request.getParameter("bno"));
		//첨부파일 정보 날아가기전에 셀렉트 
		Attachment at = new AccidentBoardService().selectAttachment(bno);
		
		int result = new ManagerService().accidentBoardDelete(bno,at); 
		
		if(result>0) { //성공하면 파일지워주기		
			if(at!=null) {//첨부파일 있으면 삭제
				String savePath = request.getSession().getServletContext().getRealPath("/resources/accident_board_file/");
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
