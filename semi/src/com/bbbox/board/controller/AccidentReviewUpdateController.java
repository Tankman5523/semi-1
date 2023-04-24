package com.bbbox.board.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.bbbox.board.model.service.AccidentBoardService;
import com.bbbox.board.model.vo.AccidentReview;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.common.model.vo.MyFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class AccidentReviewUpdateController
 */
@WebServlet("/update.ar")
public class AccidentReviewUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccidentReviewUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//참조용 값
		int arNo = Integer.parseInt(request.getParameter("arNo"));
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		AccidentReview ar = new AccidentBoardService().selectAccidentReview(arNo);
		Attachment at = new AccidentBoardService().selectAttachment(bno);
		
		if(ar!=null && at!=null) {
			request.setAttribute("ar", ar);
			request.setAttribute("at", at);
			
			request.getRequestDispatcher("views/board/accidentReviewUpdateForm.jsp").forward(request, response);
		}else {
			System.out.println("리뷰 불러오기 실패");
			request.setAttribute("errorMsg", "리뷰 불러오기 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		if(ServletFileUpload.isMultipartContent(request)) {
			
			//파일 최대 100mb 
			int maxSize = 100 * 1024 * 1024;
			
			String savePath = request.getSession().getServletContext().getRealPath("/resources/accident_board_file/");
			
			MultipartRequest multiRequest = new MultipartRequest(request,savePath,maxSize,"UTF-8",new MyFileRenamePolicy());
			
			//참조값
			int uno = Integer.parseInt(multiRequest.getParameter("uno"));
			int bno = Integer.parseInt(multiRequest.getParameter("bno"));
			int arNo = Integer.parseInt(multiRequest.getParameter("arNo"));
			
			String oldFileName= multiRequest.getParameter("oldFileChangeName");
			
			String content = multiRequest.getParameter("content");
			
			int correctRateMe = Integer.parseInt(multiRequest.getParameter("correctRateMe"));
			int correctRateYou = Integer.parseInt(multiRequest.getParameter("correctRateYou"));
			
			AccidentReview ar = new AccidentReview();
			ar.setContent(content);
			ar.setCorrectRateMe(correctRateMe);
			ar.setCorrectRateYou(correctRateYou);
			ar.setArNo(arNo);
			//DB에 수정할 정보 넣기
			int result = new AccidentBoardService().updateAccidentReview(ar);
			
			Attachment at =null;
			
			if(result>0) {
				
				//영상 파일정보 변경
				if(multiRequest.getOriginalFileName("newVideo")!=null) {
					at = new Attachment();
					
					at.setRefBno(bno);
					at.setOriginName(multiRequest.getOriginalFileName("newVideo"));
					at.setChangeName(multiRequest.getFilesystemName("newVideo"));
					at.setFilePath("/resources/accident_board_file/");
					
					result = new AccidentBoardService().updateAccidentAttachment(at);
					
					if(result>0) { //성공시 기존파일 삭제
						
						new File(savePath+oldFileName).delete();
						request.getSession().setAttribute("alertMsg", "리뷰가 수정되었습니다.");
						request.getRequestDispatcher("/detail.rb?bno="+bno).forward(request, response);
					}else {//파일 입력 실패
						System.out.println("영상 입력 실패");
						request.setAttribute("errorMsg", "새로운 영상 입력 실패");
						request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
					}
					
				}else {
					//새로운 영상 없음
					request.getSession().setAttribute("alertMsg", "리뷰가 수정되었습니다.");
					request.getRequestDispatcher("/detail.rb?bno="+bno).forward(request, response);
				}
				
			}else {
				request.setAttribute("errorMsg", "리뷰 수정 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
			
		}
		
	}

}
