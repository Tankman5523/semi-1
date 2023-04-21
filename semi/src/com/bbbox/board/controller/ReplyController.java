package com.bbbox.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.service.BoardService;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.member.model.vo.Member;
import com.google.gson.Gson;

/**
 * Servlet implementation class ReplyController
 */
@WebServlet({ "/insertRp", "/listRp" })
public class ReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReplyController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        String contextPath = request.getContextPath(); // 현재 웹 애플리케이션의 경로를 가져옴
        String map = request.getRequestURI().substring(contextPath.length()); // URI에서 웹 애플리케이션 경로를 제거하여 명령어 추출
        
        if("/insertRp".equals(map)) {
            // insertRp에 대한 처리
        	Member m = (Member)request.getSession().getAttribute("loginUser");
        	
        	int uno = m.getUserNo();
        	int bno = Integer.parseInt(request.getParameter("bno"));
        	String content = request.getParameter("content");
        	
        	int result = new BoardService().insertRp(uno, bno, content);
        	
        	response.getWriter().print(result);
        	
        	
        }else if("/listRp".equals(map)) {
            // listRp에 대한 처리
			int bno = Integer.parseInt(request.getParameter("bno"));

			ArrayList<Reply> rpList = new BoardService().selectRpList(bno);
			
//			System.out.println(rpList);
			
			response.setContentType("json/application; charset=UTF-8");
			new Gson().toJson(rpList, response.getWriter());
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
