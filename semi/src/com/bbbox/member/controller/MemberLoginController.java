package com.bbbox.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.member.model.service.MemberService;
import com.bbbox.member.model.vo.Member;

/**
 * Servlet implementation class MemberLoginController
 */
@WebServlet("/login.me")
public class MemberLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberLoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인폼으로 위임
		request.getRequestDispatcher("/views/member/loginPage.jsp").forward(request, response);
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		//입력한 정보 가지고 오기(아이디, 비밀번호)
		String userId = request.getParameter("userId");
		
		String userPwd = request.getParameter("userPwd");
		
		System.out.println(userId);
		
		//입력한 유저 정보에대한 회원 정보 조회해오기
		Member loginUser = new MemberService().loginMember(userId, userPwd);
		
		//조회해온 loginUser 정보 Session에 담기
		if(loginUser !=null) { //로그인 성공
			
			
			request.getSession().setAttribute("loginUser", loginUser);
			request.getSession().setAttribute("alertMsg", "성공적으로 로그인이 완료되었습니다.");
			
			//String before = request.getHeader("Referer");
			response.sendRedirect(request.getContextPath());

			
			
		}else { //로그인 실패
			
			request.getSession().setAttribute("errorMsg", "로그인에 실패하였습니다. 다시 시도해주세요");
			
			response.sendRedirect(request.getContextPath());
			
		}
		
		
	}

}
