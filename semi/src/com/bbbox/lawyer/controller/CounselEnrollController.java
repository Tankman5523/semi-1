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
@WebServlet("/counselEnroll.la")
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
		//상담신청 폼 띄우기 위한 정보 조회
		
		Lawyer l = new LawyerService().selectLawyer(Integer.parseInt(request.getParameter("lno"))); //해당 변호사 정보
		
		ArrayList<Lawyer> lawList = new LawyerService().selectList(); //옵션선택을 위한 전체 변호사리스트
		ArrayList<PartCategory> pList = new LawyerService().selectPart(); //옵션선택을 위한 전체 분야리스트

		request.setAttribute("lawList", lawList); //이름만 가져와도 되면 수정하기  / 리스트뷰에서 가져오는 것도 마찬가지
		request.setAttribute("pList", pList);
		request.setAttribute("l", l);
		
		request.getRequestDispatcher("views/lawyer/counselEnrollForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//상담신청 내용 등록
		
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
				
		if(result>0) {
			request.getSession().setAttribute("alertMsg", "상담신청 완료");
			response.sendRedirect(request.getContextPath()+"/myPage.me");
			//myPage가 post방식으로 변경되어 문제 발생
			
		}else {
			request.setAttribute("errorMsg", "상담신청 작성 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	}

}
