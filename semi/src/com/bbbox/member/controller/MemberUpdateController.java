package com.bbbox.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.member.model.dao.MemberDao;
import com.bbbox.member.model.service.MemberService;
import com.bbbox.member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdateController
 */
@WebServlet("/update_info.me")
public class MemberUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//페이지 위임
		request.getRequestDispatcher("views/member/edit_user_info.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//수정된 회원 정보 가져오기
		
		request.setCharacterEncoding("UTF-8");
		
		Member loginUser = (Member)request.getSession().getAttribute("loginUser");
		
		String userId = loginUser.getUserId();
		
		String newPwd = request.getParameter("newPwd");
		String newPhone = request.getParameter("newPhone");
		String newName = request.getParameter("newName");
		String newEmail = request.getParameter("newEmail");
		String newAddress = request.getParameter("newAddress");
		
		Member m = new Member(userId, newPwd, newName, newPhone, newEmail, newAddress);
		
		int result = new MemberService().updateMember(m);
		
		
		if(result>0) {
			request.getSession().setAttribute("alertMsg", "회원정보 수정이 완료되었습니다.");
			
			Member updateMem = new MemberService().loginMember(userId, newPwd);
			
			request.getSession().setAttribute("loginUser", updateMem);
			
			request.getRequestDispatcher("/myPage.me").forward(request, response);
			
		}else {
			request.setAttribute("errorMsg", "회원정보 수정 실패 다시 시도해주세요");
			
			request.getRequestDispatcher("/myPage.me").forward(request, response);
		}
		
		
		
		
		
	
	
	}

}
