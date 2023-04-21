package com.bbbox.lawyer.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.lawyer.model.service.LawyerService;

/**
 * Servlet implementation class DibsCheckController
 */
@WebServlet("/dibs.la")
public class DibsCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DibsCheckController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int lawNo = Integer.parseInt(request.getParameter("lawNo"));
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		int count = new LawyerService().dibsCheck(lawNo,userNo);
		
//		if() { //결과값이 있으면 채운하트
//			
//		}else { //없으면 빈하트
//			
//		}
		
//		숫자만 보낼거니까 없어도 되나?
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(count);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String heart = request.getParameter("heart");
		int lawNo = Integer.parseInt(request.getParameter("lawNo"));
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		int count = new LawyerService().dibsUpdate(heart,lawNo,userNo);
		
		System.out.println(heart);
		
		if(count != 0) { //성공했을 때
			
			if(heart.equals("emptyHeart")) { //찜하기 등록을 성공했다면
				count = 1;
			}else { //찜하기 삭제를 성공했다면
				count = 2;
			}
			
		}
		
		//		숫자만 보낼거니까 없어도 되나?
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(count);
	}

}
