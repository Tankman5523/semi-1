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
 * Servlet implementation class AccidentEnroll
 */
@WebServlet("/enroll.acc")
public class AccidentInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccidentInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		request.setCharacterEncoding("UTF-8");
		//동영상 받아왔기때문에 multiPart로 받아야한다.
		
		if(ServletFileUpload.isMultipartContent(request)) {
			
			
			//파일 최대 50mb 
			int maxSize = 50 * 1024 * 1024;
			
			String savePath = request.getSession().getServletContext().getRealPath("/resources/accident_board_file/");
			
			MultipartRequest multiRequest = new MultipartRequest(request,savePath,maxSize,"UTF-8",new MyFileRenamePolicy());
			
			
			//폼으로 받아온 요소 가져오기
			
			//개인정보
			String userNo = multiRequest.getParameter("userNo"); //writer_no으로도 사용
			String userName = multiRequest.getParameter("userName");
			String phone = multiRequest.getParameter("phone");
			String email = multiRequest.getParameter("email");
			
			//글정보 
			String title = multiRequest.getParameter("title");
			String content = multiRequest.getParameter("content");
			
			//사건정보
			int partNo = Integer.parseInt(multiRequest.getParameter("partCategory"));
			String insuranceType = multiRequest.getParameter("insuranceType");
			String region = multiRequest.getParameter("region");
			int accidentRateMe = Integer.parseInt(multiRequest.getParameter("accidentRateMe"));
			int accidentRateYou = Integer.parseInt(multiRequest.getParameter("accidentRateYou"));
			
			//게시글정보 먼저 등록
			Board b = new Board();
			b.setBoardWriter(userNo);
			b.setTitle(title);
			b.setContent(content);
			
			Accident ac= null;
			Attachment at = null;
			
			
			int result = new AccidentBoardService().insertAccidentBoard(b);
			
			if(result>0) {//너무 복잡하면 서비스에 한번에 넣어서 처리하는 방법도 있음
					
				//방금등록한 글번호 찾아오기
				int refBno = new AccidentBoardService().selectRefBoardNo();
				//--> 이 구문에서 에러나면 앞구문에서  board 입력에  commit 안해서 bno못읽어오는것. 
				
				
				if(refBno!=0) { //가져온 글번호가 잘못되지 않았을때
					//사고정보 등록
					ac = new Accident();
					
					//위에서 넣은 게시글의 넘버를 가져온다.
					ac.setRefBno(refBno);
					ac.setRefPno(partNo);
					ac.setInsuranceType(insuranceType);
					ac.setRegion(region);
					ac.setAccRateMe(accidentRateMe);
					ac.setAccRateYou(accidentRateYou);
					
					result = new AccidentBoardService().insertAccidentInfo(ac);
					
					if(result>0) {
						//첨부파일정보
						
						//혹시나 오류로 파일들어가는 경우 이중방지
						if(multiRequest.getOriginalFileName("video")!=null) {
							at = new Attachment();
							at.setRefBno(refBno);
							at.setOriginName(multiRequest.getOriginalFileName("video")); //원본명
							at.setChangeName(multiRequest.getFilesystemName("video")); //수정명(실제 서버에 업로드된 파일명)
							at.setFilePath("/resources/accident_board_file/");
							
							result= new AccidentBoardService().insertAccidentAttachment(at);
							if(result==0) { //파일 db에 등록 실패
								System.out.println("파일 DB등록 실패");
								//실패시 위에서 넘어온 파일 삭제
								new File(savePath+at.getChangeName()).delete();
								request.getRequestDispatcher("/list.ac").forward(request, response);
								
							}
							
							//게시판으로 보내기
							//System.out.println("최종성공");
							response.sendRedirect("/list.ac");
						}else {
							//오류로 없는 파일객체가 들어가서 실패
							System.out.println("파일오류실패");
							request.getRequestDispatcher("/list.ac").forward(request, response);
						}
					}else {
						//사건정보 등록 실패
						System.out.println("사건정보 등록 실패");
						request.getRequestDispatcher(request.getContextPath()+"/list.ac").forward(request, response);
					}
				}else {
					//글번호 찾아오기 실패
					System.out.println("글번호 조회 실패");
					request.getRequestDispatcher("/list.ac").forward(request, response);
				}
			}else {
				//게시판등록 실패
				System.out.println("게시판등록 실패");
				request.getRequestDispatcher("/list.ac").forward(request, response);
			}
		}
	}
}
