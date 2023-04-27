package com.bbbox.manager.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
		ArrayList<Attachment> alist = new ManagerService().selectAttachmentForManage(bno);
		 
		int result = new ManagerService().accidentBoardDelete(bno,alist); 
		
		if(result>0) { //성공하면 파일지워주기		
			if(alist.size()!=0) {//첨부파일 있으면 전부 삭제
				for(int i=0;i<alist.size();i++) {
					String savePath = request.getSession().getServletContext().getRealPath("/resources/accident_board_file/");
					new File(savePath+alist.get(i).getChangeName()).delete();
				}
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
