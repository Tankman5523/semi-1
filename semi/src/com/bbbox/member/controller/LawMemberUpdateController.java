package com.bbbox.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.bbbox.common.model.vo.MyFileRenamePolicy;
import com.bbbox.lawyer.model.service.LawyerService;
import com.bbbox.lawyer.model.vo.LawAttachment;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.member.model.service.MemberService;
import com.bbbox.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class LawMemberUpdateController
 */
@WebServlet("/update_info.la")
public class LawMemberUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LawMemberUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int userNo = ((Member)request.getSession().getAttribute("loginUser")).getUserNo();
		
		Member applyMem = new MemberService().selectMemberInfo(userNo);
		
		Lawyer lawInfo = new LawyerService().selectApply(userNo); //변호사 정보 
		
		String lat = new LawyerService().selectLawAttachment(userNo); 
		
		request.setAttribute("applyMem", applyMem);
		request.setAttribute("lawInfo", lawInfo);
		request.setAttribute("lat", lat);
		
		request.getRequestDispatcher("views/member/updateInfo-lawMember.jsp").forward(request, response);
		
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		if(ServletFileUpload.isMultipartContent(request)) {
			
			int maxSize = 10*1024*1024;
			
			String savePath = request.getSession().getServletContext().getRealPath("/resources/lawyer");
			
			MultipartRequest multiRequest = new MultipartRequest(request , savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			Member loginUser = (Member)request.getSession().getAttribute("loginUser");
			
			String userNo = String.valueOf(loginUser.getUserNo()); //변호사 정보 업데이트시 사용할 참고 회원번호
			
			String userId = ((Member)request.getSession().getAttribute("loginUser")).getUserId(); //회원 정보 업데이트시 참고할 회원 아이디 
			
			LawAttachment lat = null;
			
			Member m  = null;
			
			Lawyer l = null;
			
			if(multiRequest.getOriginalFileName("profile") !=null) {
				
				
				lat = new LawAttachment();
				
				lat.setRefUno(userNo);
				lat.setOriginName(multiRequest.getOriginalFileName("profile"));
				lat.setChangeName(multiRequest.getFilesystemName("profile"));
				lat.setFilePath("/resources/lawyer/");
				
			}
			
			String pwd = multiRequest.getParameter("newPwd"); //비밀번호
			
			String name = multiRequest.getParameter("newName"); //이름
			
			String phone = multiRequest.getParameter("newPhone"); //핸드폰번호
			
			String email = multiRequest.getParameter("newEmail"); //이메일
			
			String address = multiRequest.getParameter("newAddress"); //주소
			
			String companyAddress = multiRequest.getParameter("resultAddress"); //사무소 주소
			
			String companyName = multiRequest.getParameter("companyName"); //사무소 이름
			
			String companyPn = multiRequest.getParameter("companyPhone"); //사무소 번호 
			
			String comment = multiRequest.getParameter("comment"); //한줄 소개
			
			String career = multiRequest.getParameter("career"); //경력 
			
			m = new Member (userId, pwd, name,phone, email, address);
			
			l= new Lawyer (userNo, companyAddress, companyName, companyPn, comment , career);
			
			int result = new MemberService().updateMember(m);
			
			int result2 = new MemberService().updateLawyer(l, lat);
			
			if(result*result2 > 0) {
				//회원정보 수정 성공 	
				
				Member updateLawMem = new MemberService().loginMember(userId,pwd);
				
				request.setAttribute("updateLawMem", updateLawMem);
				request.setAttribute("alertMsg", "회원정보 수정이 성공적으로 완료되었습니다.");
				
				response.sendRedirect(request.getContextPath());
				
			}else {
				request.setAttribute("errorMsg", "회원정보 수정 실패 다시 시도해주세요");
				request.getRequestDispatcher("/myPage.me").forward(request, response);
			}

		
		}
	
	
	
	
	}

}
