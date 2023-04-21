package com.bbbox.lawyer.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bbbox.lawyer.model.service.LawyerService;
import com.bbbox.lawyer.model.vo.Counsel;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.lawyer.model.vo.PartCategory;

/**
 * Servlet implementation class CounselEnrollForm
 */
@WebServlet("/counsel.la")
public class CounselEnrollController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CounselEnrollController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Lawyer l = new LawyerService().selectLawyer(Integer.parseInt(request.getParameter("lno")));
		ArrayList<Lawyer> lawList = new LawyerService().selectList();
		ArrayList<PartCategory> pList = new LawyerService().selectPart();
		

		request.setAttribute("lawList", lawList); //이름만 가져와도 되면 수정하기  / 리스트뷰에서 가져오는 것도 마찬가지
		request.setAttribute("pList", pList);
		request.setAttribute("l", l);
		
		request.getRequestDispatcher("views/lawyer/counselEnrollForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String lawNo = request.getParameter("lawNameKey");
		String userNo = request.getParameter("userNo");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		Counsel c = new Counsel();
		c.setRefLno(lawNo);
		c.setCsWriter(userNo);
		c.setCsTitle(title);
		c.setCsContent(content);
		
		int result = new LawyerService().insertCounsel(c);
		
		System.out.println(result);
				
		if(result>0) { //성공시 알림메세지로 상담신청 완료 띄우고 마이페이지로 이동(재요청)
			request.getSession().setAttribute("alertMsg", "상담신청 완료");
			response.sendRedirect(request.getContextPath()+"/myPage.me");
		}else { //실패시 에러페이지로 이동(상담신청 작성 실패) 메세지 (위임)
			request.setAttribute("errorMsg", "상담신청 작성 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	}

}
