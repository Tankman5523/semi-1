package com.bbbox.lawyer.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.lawyer.model.service.LawyerService;
import com.bbbox.lawyer.model.vo.Counsel;
import com.bbbox.lawyer.model.vo.Lawyer;

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
		//1.상담신청 수정폼 띄우기 위한 기존 데이터 조회
		//2.회원의 매칭수락/상담종료에 대한 ACCEPT 값 변경 기능
		
		int csNo = Integer.parseInt(request.getParameter("cno"));
		Counsel c = new LawyerService().selectCounsel(csNo);
		Lawyer l = new LawyerService().selectLawyer(Integer.parseInt(c.getRefLno()));
		
		String aResult = request.getParameter("aResult");
		//수정폼을 넘길지("X") or 회원 답변에 의한 상태변경을 할지("accept"/"decline") 구분
		
		if(aResult.equals("X")) { //수정폼을 위한 데이터 조회일 경우
			
			request.setAttribute("c", c);
			request.setAttribute("l", l);
			request.getRequestDispatcher("views/lawyer/counselUpdateForm.jsp").forward(request, response);
			
		}else { //ACCEPT값 변경 기능일 경우
			
			int result = new LawyerService().updateAccept(csNo, aResult);
			
			if(result>0) {
				if(aResult.equals("accept")) {
					request.getSession().setAttribute("alertMsg", "매칭이 완료되었습니다. "+l.getRefUno()+"변호사님과 자세한 법률상담을 통해 사건해결을 진행하시기 바랍니다.");
				}else {
					request.getSession().setAttribute("alertMsg", "상담이 종료되었습니다.");
				}
				response.sendRedirect(request.getContextPath()+"/myPage.me");
			}else {
				request.setAttribute("errorMsg", "답변 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
			
		}
		
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
				
		if(result>0) {
			request.getSession().setAttribute("alertMsg", "상담수정 완료");
			response.sendRedirect(request.getContextPath()+"/myPage.me");
		}else {
			request.setAttribute("errorMsg", "상담수정 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	}

}
