package com.bbbox.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.bbbox.board.model.service.BoardService;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.common.model.vo.MyFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BoardInsertController
 */
@WebServlet("/insert.bo")
public class BoardInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.getRequestDispatcher("views/board/boardInsertForm.jsp").forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		if(ServletFileUpload.isMultipartContent(request)) {
			
			//파일사이즈 10Mb
			int maxSize = 10 * 1024 * 1024;
			
			
			String savePath = request.getSession().getServletContext().getRealPath("/resources/1_board/");
			

			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());

			
			//보드테이블에 등록할 정보
			String userNo = multiRequest.getParameter("userNo");
			String title = multiRequest.getParameter("title");
			String content = multiRequest.getParameter("content");
			int notice = Integer.parseInt(multiRequest.getParameter("notice"));
			
			Board b = null;
			
			if(notice>0) {
				b = new Board();
				b.setBoardWriter(userNo);
				b.setTitle(title);
				b.setContent(content);
				b.setNotice("Y");
			}else {
				b = new Board();
				b.setBoardWriter(userNo);
				b.setTitle(title);
				b.setContent(content);
				b.setNotice("N");
			}
			
			
			//첨부파일 초기값 세팅
			Attachment at = null;
			
			if(multiRequest.getOriginalFileName("upFile") != null) {
				at = new Attachment();
				at.setOriginName(multiRequest.getOriginalFileName("upFile"));
				at.setChangeName(multiRequest.getFilesystemName("upFile"));
				at.setFilePath("/resources/1_board/");
			}
			
			int result = new BoardService().insertBoard(b,at);
			
			if(result>0) {
				request.getSession().setAttribute("alertMsg", "게시글 작성 성공");
				
				response.sendRedirect(request.getContextPath()+"/list.bo?currentPage=1");
			}else {
				if(at!=null) {
					new File(savePath+at.getChangeName()).delete();
				}
				request.setAttribute("errorMsg", "게시글 작성 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
			
			
		}
	
	}

}
