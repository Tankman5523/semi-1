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
 * Servlet implementation class AccidentReviewEnrollController
 */
@WebServlet("/enroll.ar")
public class AccidentReviewEnrollController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccidentReviewEnrollController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int bno=Integer.parseInt(request.getParameter("bno"));
		int accNo=Integer.parseInt(request.getParameter("accNo"));
		String oldFileChangeName=request.getParameter("oldFileChangeName");
		
		request.setAttribute("bno", bno);
		request.setAttribute("accNo", accNo);
		request.setAttribute("oldFileChangeName", oldFileChangeName);
		
		request.getRequestDispatcher("views/board/accidentReviewEnrollForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		//동영상 받아왔기때문에 multiPart로 받아야한다.
		if(ServletFileUpload.isMultipartContent(request)) {
			
			
			//파일 최대 100mb 
			int maxSize = 100 * 1024 * 1024;
			
			String savePath = request.getSession().getServletContext().getRealPath("/resources/accident_board_file/");
			
			MultipartRequest multiRequest = new MultipartRequest(request,savePath,maxSize,"UTF-8",new MyFileRenamePolicy());
			
		
			//참조값
			int uno=Integer.parseInt(multiRequest.getParameter("uno"));
			int bno=Integer.parseInt(multiRequest.getParameter("bno"));
			int accNo=Integer.parseInt(multiRequest.getParameter("accNo"));
			
			
			String content=multiRequest.getParameter("content");
			int correctRateMe=Integer.parseInt(multiRequest.getParameter("correctRateMe"));
			int correctRateYou=Integer.parseInt(multiRequest.getParameter("correctRateYou"));
			
			//uno로 lawNo을 가져온다
			int lawNo = new AccidentBoardService().selectLawNoByUno(uno);
			
			
			
			AccidentReview ar = new AccidentReview();
			ar.setContent(content);
			ar.setCorrectRateMe(correctRateMe);
			ar.setCorrectRateYou(correctRateYou);
			ar.setRefAccNo(accNo);
			ar.setLawNo(lawNo);
			
			
			//리뷰정보 넣기
			int result = new AccidentBoardService().insertAccidentReview(ar);
			
			if(result>0) {
				// SOLVE(해결) , CATEGORY_TYPE(게시판종류) 변경해주기
				result = new AccidentBoardService().shiftBoard(bno,accNo,lawNo);
			
				
				
				//파일 파라메터
				if(result>0) {//리뷰정보 입력 성공
					if(multiRequest.getOriginalFileName("reviewVideo")!=null) {
						Attachment at = new Attachment();
						
						at.setRefBno(bno);
						at.setOriginName(multiRequest.getOriginalFileName("reviewVideo")); //원본명
						at.setChangeName(multiRequest.getFilesystemName("reviewVideo")); //수정명(실제 서버에 업로드된 파일명)
						at.setFilePath("/resources/accident_board_file/");
						
						result = new AccidentBoardService().updateAccidentAttachment(at);
						
						if(result>0) { //파일 입력 성공
							//기존파일 지우기
							String oldFileChangeName=multiRequest.getParameter("oldFileChangeName");
							new File(savePath+oldFileChangeName).delete();
							request.getSession().setAttribute("alertMsg", "리뷰가 성공적으로 작성 되었습니다.");
							request.getRequestDispatcher("/detail.rb?bno="+bno).forward(request, response);
						}else {
							System.out.println("영상 입력 실패");
							request.setAttribute("errorMsg", "새로운 영상 입력 실패");
							request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
						}
						
					}else {//새로운 영상을 넣지 않았다면,
						request.getSession().setAttribute("alertMsg", "리뷰가 성공적으로 작성 되었습니다.");
						request.getRequestDispatcher("/detail.rb?bno="+bno).forward(request, response);
					}
					
				}else {//카테고리 , solve값 변경 실패
					System.out.println("게시판 변경 실패");
					request.setAttribute("errorMsg", "게시판 변경 실패");
					request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
				}
			}else {//리뷰정보 입력 실패
				System.out.println("리뷰 입력 실패");
				request.setAttribute("errorMsg", "리뷰정보 입력 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
		}
	}

}
