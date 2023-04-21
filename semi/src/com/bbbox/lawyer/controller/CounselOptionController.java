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
		
		String partName = request.getParameter("cateKey");
		
		ArrayList<Lawyer> list = new LawyerService().lawOptionChange(partName);
		
		response.setContentType("json/application; charset=UTF-8");
		
		new Gson().toJson(list,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String lawNo = request.getParameter("lawNameKey");
		PartCategory part = new LawyerService().partOptionChange(lawNo);
		
		response.setContentType("json/application; charset=UTF-8");
		Gson gson = new Gson();
		
		gson.toJson(part,response.getWriter());
		
	}

}
