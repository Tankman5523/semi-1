package com.bbbox.lawyer.controller;

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
 * Servlet implementation class LawyerListController
 */
@WebServlet("/list.la")
public class LawyerListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LawyerListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//변호사 전체 리스트 조회
		
		ArrayList<Lawyer> lawList = new LawyerService().selectList();
		ArrayList<PartCategory> pList = new LawyerService().selectPart();
		
		request.setAttribute("lawList", lawList);
		request.setAttribute("pList", pList);
		request.getRequestDispatcher("views/lawyer/lawyerListView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//조건으로 검색한 변호사 리스트 조회
		
		request.setCharacterEncoding("UTF-8");
		
		String nameKey = request.getParameter("nameKey");
		String cateKey = request.getParameter("cateKey");
		String localKey = request.getParameter("localKey");
		
		ArrayList<Lawyer> lawList = new LawyerService().searchList(nameKey, cateKey, localKey);
		ArrayList<PartCategory> pList = new LawyerService().selectPart();
		
		request.setAttribute("lawList", lawList);
		request.setAttribute("pList", pList);
		request.getRequestDispatcher("views/lawyer/lawyerListView.jsp").forward(request, response);
		
	}

}
