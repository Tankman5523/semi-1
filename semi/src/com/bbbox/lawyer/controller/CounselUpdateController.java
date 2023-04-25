package com.bbbox.lawyer.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.lawyer.model.service.LawyerService;
import com.bbbox.lawyer.model.vo.Counsel;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.lawyer.model.vo.PartCategory;

/**
 * Servlet implementation class CounselUpdateController
 */
@WebServlet("/counselUpdate.la")
public class CounselUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CounselUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//상담신청 수정폼 띄우기 위한 기존 데이터 조회 (상담번호 이용)
			
		//상담번호로 상담내용 조회
		Counsel c = new LawyerService().selectCounsel(Integer.parseInt(request.getParameter("cno")));
		
		//상담번호로 변호사 정보 조회
		Lawyer l = new LawyerService().selectLawyer(Integer.parseInt(c.getRefLno()));
		
		request.setAttribute("c", c);
		request.setAttribute("l", l);
		request.getRequestDispatcher("views/lawyer/counselUpdateForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//상담 수정내용 업데이트
		
		request.setCharacterEncoding("UTF-8");
		
		int cno = Integer.parseInt(request.getParameter("cno"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		int result = new LawyerService().updateCounsel(cno, title, content);
				
		if(result>0) { //성공시 알림메세지로 상담신청 완료 띄우고 마이페이지로 이동(재요청)
			request.getSession().setAttribute("alertMsg", "상담수정 완료");
			response.sendRedirect(request.getContextPath()+"/myPage.me");
		}else { //실패시 에러페이지로 이동(상담신청 작성 실패) 메세지 (위임)
			request.setAttribute("errorMsg", "상담수정 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	}

}
