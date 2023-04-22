package com.bbbox.member.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.bbbox.common.model.vo.MyFileRenamePolicy;
import com.bbbox.lawyer.model.vo.LawAttachment;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.member.model.service.MemberService;
import com.bbbox.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class MemberApplyLawyerController
 */
@WebServlet("/apply_Lawyer.me")
public class MemberApplyLawyerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberApplyLawyerController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//변호사 신청 페이지로 위임 
		request.getRequestDispatcher("views/member/applyLawyerForm.jsp").forward(request, response);
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		if(ServletFileUpload.isMultipartContent(request)) {
			
			int maxSize = 10*1024*1024;
			
			String savePath = request.getSession().getServletContext().getRealPath("/resources/lawyer");
			
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			//DB에 넘길 데이터
			Member loginUser = (Member)request.getSession().getAttribute("loginUser");
			
			String userNo = String.valueOf(loginUser.getUserNo()); //참조할 회원번호 session에서 꺼내오기
			
			LawAttachment lat = null;
			
			if(multiRequest.getOriginalFileName("profile") != null) {
				
				lat = new LawAttachment();
				
				lat.setRefUno(userNo);
				lat.setOriginName(multiRequest.getOriginalFileName("profile"));
				lat.setChangeName(multiRequest.getFilesystemName("profile"));
				lat.setFilePath("/resources/lawyer/");
				
				System.out.println(lat); //확인용도 
			}
			
			
			String pno = multiRequest.getParameter("category"); //분야번호
			
			String exam = multiRequest.getParameter("test"); //시험종류 
			
			int examSession = Integer.parseInt(multiRequest.getParameter("pass")); //시험 회차
			
			int passDate = Integer.parseInt(multiRequest.getParameter("passdate")); //합격년도
			
			String address = multiRequest.getParameter("resultAddress"); //사무소 주소
			
			String companyName = multiRequest.getParameter("companyName"); //사무소 이름
			
			String companyPn = multiRequest.getParameter("companyPhone"); //사무소 번호 
			
			String comment = multiRequest.getParameter("comment"); //한줄 소개
			
			String career = multiRequest.getParameter("career"); //경력 
			
			Lawyer applyla = new Lawyer(userNo, pno,exam,examSession,passDate,address,companyName,companyPn,comment,career);
			
			System.out.println(applyla);
			
			int result = new MemberService().ApplyLawyar(lat, applyla);
			
			if(result>0) {
				request.getSession().setAttribute("alertMsg","변호사 회원 신청이 완료되었습니다.");
				response.sendRedirect(request.getContextPath()+"/myPage.me");
			}else {
				
				if(lat != null) {
					new File(savePath+lat.getChangeName()).delete();
				}
				
				request.setAttribute("errorMsg", "변호사회원 신청에 실패하였습니다. 다시 시도해주세요 ");
				request.getRequestDispatcher("/myPage.me").forward(request, response);
			}
		
		}
	
	
	}

}
