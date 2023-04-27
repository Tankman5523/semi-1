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
import com.google.gson.Gson;

/**
 * Servlet implementation class CounselOptionController
 */
@WebServlet("/counselOption.la")
public class CounselOptionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CounselOptionController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//분야 옵션 선택에 따른 변호사 리스트
		
		String partName = request.getParameter("partKey"); //선택된 분야
		ArrayList<Lawyer> list = new ArrayList<>(); //변호사 리스트 받을 객체배열 생성
		
		if(partName.equals("전체")) { //전체를 선택했다면 전체 변호사 리스트 조회
			list = new LawyerService().selectList();
		}else { //선택된 분야에 해당하는 변호사 리스트 조회
			list = new LawyerService().lawOptionChange(partName);
		}
		
		response.setContentType("json/application; charset=UTF-8");
		new Gson().toJson(list,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//변호사이름 옵션 선택에 따른 분야 리스트
		
		String lawNo = request.getParameter("lawNameKey"); //선택된 변호사의 번호
		PartCategory part = new LawyerService().partOptionChange(lawNo); //선택된 변호사의 분야
		
		response.setContentType("json/application; charset=UTF-8");
		new Gson().toJson(part,response.getWriter());
	}

}
