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
 * Servlet implementation class VideoUpdateController
 */
@WebServlet("/update.vi")
public class VideoUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VideoUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int boardNo = Integer.parseInt(request.getParameter("bno"));
		
		
		//업데이트할 게시글 조회
		Board b = new BoardService().selectBoard(boardNo);
		
		//첨부파일도
		Attachment at = new BoardService().selectAttachment(boardNo);
		
		request.setAttribute("board", b);
		request.setAttribute("at", at);
		
		request.getRequestDispatcher("views/board/videoUpdateForm.jsp").forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");

		if(ServletFileUpload.isMultipartContent(request)) {
			
			//파일사이즈 1Gb
			int maxSize = 1 * 1024 * 1024 * 1024;
			
			
			String savePath = request.getSession().getServletContext().getRealPath("/resources/2_board/");
			

			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());

			
			//보드테이블에 등록할 정보
			int boardNo = Integer.parseInt(multiRequest.getParameter("bno"));
			String title = multiRequest.getParameter("title");
			String content = multiRequest.getParameter("content");
			
			Board b = new Board();
			b.setBoardNo(boardNo);
			b.setTitle(title);
			b.setContent(content);
			
	
			//첨부파일 초기값 세팅
			Attachment at = null;
			
			if(multiRequest.getOriginalFileName("upFile") != null) {
				at = new Attachment();
				at.setOriginName(multiRequest.getOriginalFileName("upFile"));
				at.setChangeName(multiRequest.getFilesystemName("upFile"));
				at.setFilePath("/resources/2_board/");
			}
			
			int result = new BoardService().updateVideo(b,at);



			if(result>0) {
				request.getSession().setAttribute("alertMsg", "수정됨");
				
				response.sendRedirect(request.getContextPath()+"/list.vi?currentPage=1");
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
