package com.bbbox.manager.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.service.AccidentBoardService;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Search;
import com.bbbox.common.model.vo.PageInfo;
import com.bbbox.manager.service.ManagerService;

/**
 * Servlet implementation class AccidentBoardListSearchController
 */
@WebServlet("/search.mac")
public class ManageAccidentBoardListSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageAccidentBoardListSearchController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//게시판 종류 
		//int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
		int categoryNo = 3;
		
		//필터값 추출
		String region = request.getParameter("region"); 
		if(region.equals("none")) {//기본값 넘어오면 비워주기
			region="";
		}
		
		int partType = Integer.parseInt(request.getParameter("partType"));
		
		String insuranceType = request.getParameter("insuranceType");
		
		if(insuranceType.equals("none")) {
			insuranceType = "";
		}
		
		//검색방식
		String searchFilter = request.getParameter("searchFilter");
		
		String keyword = request.getParameter("keyword");
		ArrayList<Board> list = null;
		
		Search s = new Search(searchFilter, region, partType, insuranceType, keyword,categoryNo);
		
		
		list = new ManagerService().searchAccidentBoard(searchFilter,region,partType,insuranceType,keyword,categoryNo);
		
		
		//값이 비워져있으면 에러나지 않도록 none으로 변경
		if(s.getRegion().equals("")) {
			s.setRegion("none");
		}
		if(s.getInsuranceType().equals("")) {
			s.setInsuranceType("none");
		}
		
		if(list!=null) {
			request.setAttribute("blist", list);
			request.getRequestDispatcher("views/manager/manage_accidentBoardList_view.jsp").forward(request, response);
		}else {
			request.setAttribute("errorMsg", "사건게시판 조회 실패");
			request.getRequestDispatcher(request.getContextPath()).forward(request, response);
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
