package com.bbbox.manager.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.lawyer.model.service.LawyerService;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.lawyer.model.vo.PartCategory;

/**
 * Servlet implementation class ManageLawyerListController
 */
@WebServlet("/lawyerList.ma")
public class ManageLawyerListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageLawyerListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//변호사 전체 리스트 조회 (관리자용)
		
		ArrayList<Lawyer> lawList = new LawyerService().manageSelectLawList();
		ArrayList<PartCategory> pList = new LawyerService().selectPart();
		
		request.setAttribute("lawList", lawList);
		request.setAttribute("pList", pList);
		request.getRequestDispatcher("views/manager/manage_lawyerList_view.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//조건으로 검색한 변호사 리스트 조회 (관리자용)
		
		request.setCharacterEncoding("UTF-8");
		
		String nameKey = request.getParameter("nameKey");
		String cateKey = request.getParameter("cateKey");
		String localKey = request.getParameter("localKey");
		String sort = request.getParameter("sort");
		
		ArrayList<Lawyer> lawList = new LawyerService().manageSearchLawList(nameKey, cateKey, localKey, sort);
		ArrayList<PartCategory> pList = new LawyerService().selectPart();
		
		request.setAttribute("lawList", lawList);
		request.setAttribute("pList", pList);
		request.getRequestDispatcher("views/manager/manage_lawyerList_view.jsp").forward(request, response);
	}

}
