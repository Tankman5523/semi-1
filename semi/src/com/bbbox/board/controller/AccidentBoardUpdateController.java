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
import com.bbbox.board.model.vo.Accident;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.common.model.vo.MyFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class AccidentBoardUpdateController
 */
@WebServlet("/update.ac")
public class AccidentBoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccidentBoardUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//updateForm으로 넘겨줄 데이터 추출
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		//게시판정보 + 첨부파일 경로
		Board b = new AccidentBoardService().accidentBoardSelectDetail(bno);
		if(b==null) { // 정보를 가져오지 못한다면 -> ac가 아니라 rs에서 가져와야한다.
			b = new AccidentBoardService().resolvedBoardSelectDetail(bno); 
		}
		//사건정보
		Accident ac = new AccidentBoardService().accidentSelectDetail(bno);
		if(ac==null) {
			ac = new AccidentBoardService().resolvedAccidentSelectDetail(bno);
		}
		
		
		
		if(b!=null && ac!=null) {
			request.setAttribute("board", b);
			request.setAttribute("accident", ac);
			if(b.getCategoryNo()==4) {
				request.getRequestDispatcher("views/board/resolvedBoardUpdateForm.jsp").forward(request, response);
			}else {
				request.getRequestDispatcher("views/board/accidentBoardUpdateForm.jsp").forward(request, response);
			}
		}else {
			request.setAttribute("errorMsg", "게시글정보 불러오기 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		if(ServletFileUpload.isMultipartContent(request)) {
			
			//파일사이즈 50Mb
			int maxSize = 50 * 1024 * 1024;
			
			
			String savePath = request.getSession().getServletContext().getRealPath("/resources/accident_board_file/");
			

			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			//개인정보
			String userNo = multiRequest.getParameter("userNo"); //writer_no으로도 사용
			String userName = multiRequest.getParameter("userName");
			String phone = multiRequest.getParameter("phone");
			String email = multiRequest.getParameter("email");
			
			//글정보 
			String title = multiRequest.getParameter("title");
			String content = multiRequest.getParameter("content");
			
			//글번호*
			int boardNo = Integer.parseInt(multiRequest.getParameter("bno"));
			//게시판 번호
			int categoryNo = Integer.parseInt(multiRequest.getParameter("cno"));
			
			//사건정보
			int partNo = Integer.parseInt(multiRequest.getParameter("partCategory"));
			String insuranceType = multiRequest.getParameter("insuranceType");
			String region = multiRequest.getParameter("region");
			int accidentRateMe = Integer.parseInt(multiRequest.getParameter("accidentRateMe"));
			int accidentRateYou = Integer.parseInt(multiRequest.getParameter("accidentRateYou"));
			
			//대체시 삭제할 기존파일명
			String oldFileName = multiRequest.getParameter("oldFileName"); 
			
			//게시글정보 먼저 등록
			Board b = new Board();
			b.setBoardNo(boardNo);
			b.setBoardWriter(userNo);
			b.setTitle(title);
			b.setContent(content);
			
			
			Accident ac= new Accident();
			ac.setRefBno(boardNo);
			ac.setRefPno(partNo);
			ac.setInsuranceType(insuranceType);
			ac.setRegion(region);
			ac.setAccRateMe(accidentRateMe);
			ac.setAccRateYou(accidentRateYou);
			
			//게시글 , 사건데이터 먼저 DB에 update
			int result = new AccidentBoardService().updateAccidentBoard(b,ac);
			
			//데이터 대입에 성공하면 첨부파일 데이터 update
			if(result>0) {
				System.out.println("게시글 사건데이터 성공");
				Attachment at = new Attachment();
				//새로운 파일이 있으면 객체 만들어서 데이터 넣기
				if(multiRequest.getOriginalFileName("newVideo")!=null) {
					
					at.setRefBno(boardNo);
					at.setOriginName(multiRequest.getOriginalFileName("newVideo")); //원본명
					at.setChangeName(multiRequest.getFilesystemName("newVideo")); //수정명(실제 서버에 업로드된 파일명)
					at.setFilePath("/resources/accident_board_file/");
					
					result = new AccidentBoardService().updateAccidentAttachment(at);
					if(result>0) {//첨부파일 입력 성공시
						System.out.println("첨부파일 성공");
						//기존파일 지워주기
						new File(savePath+oldFileName).delete();
						
						request.getSession().setAttribute("alertMsg", "게시글이 성공적으로 수정되었습니다.");
						if(categoryNo == 4) {
							request.getRequestDispatcher("/detail.rb?bno="+boardNo).forward(request, response);
						}else if(categoryNo == 3) {
							request.getRequestDispatcher("/detail.ac?bno="+boardNo).forward(request, response);
						}
					}else {//첨부파일 입력 실패시
						request.setAttribute("errorMsg", "게시글 수정 실패");
						request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
					}
				//첨부파일 수정 없을시
				}else {
					System.out.println("게시글만 수정 성공");
					request.getSession().setAttribute("alertMsg", "게시글이 성공적으로 수정되었습니다.");
					if(categoryNo == 4) {//해결게시판
						response.sendRedirect(request.getContextPath()+"/detail.rb?bno="+boardNo);
					}else if(categoryNo == 3) {//cno가 3일때 = 사건게시판
						response.sendRedirect(request.getContextPath()+"/detail.ac?bno="+boardNo);
					}
				}
			}else {
				System.out.println("데이터 삽입 실패");
			}
			
		}
	}

}
