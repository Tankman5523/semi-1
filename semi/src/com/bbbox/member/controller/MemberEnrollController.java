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
 * Servlet implementation class MemberEnrollController
 */
@WebServlet("/enroll.me")
public class MemberEnrollController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberEnrollController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원가입 폼으로 위임하기
		request.getRequestDispatcher("views/member/enroll_form.jsp").forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		//입력정보 가져오기
		String inputId = request.getParameter("inputId");
		String inputPwd = request.getParameter("inputPwd");
		String inputName = request.getParameter("inputName");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		
		Member insertMember = new Member(inputId,inputPwd,inputName,email,phone,address);
		
		int result = new MemberService().insertMember(insertMember);
		
		if(result>0) {
			request.getSession().setAttribute("alertMsg", "회원가입이 완료되었습니다.");
			response.sendRedirect(request.getContextPath());
			
		}else {
			request.setAttribute("errorMsg", "회원가입에 실패하였습니다. 다시 시도해주세요.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	
	}

}
