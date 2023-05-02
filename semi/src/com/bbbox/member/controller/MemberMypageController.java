package com.bbbox.member.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bbbox.board.model.vo.Accident;
import com.bbbox.board.model.vo.AccidentReview;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.lawyer.model.service.LawyerService;
import com.bbbox.lawyer.model.vo.Counsel;
import com.bbbox.lawyer.model.vo.LawAttachment;
import com.bbbox.lawyer.model.vo.LawReview;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.member.model.service.MemberService;
import com.bbbox.member.model.vo.Member;
import com.bbbox.qaboard.model.vo.Question;

/**
 * Servlet implementation class MemberMypageController
 */
@WebServlet("/myPage.me")
public class MemberMypageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberMypageController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//세션에 담긴 로그인 유저의 번호 꺼내오기 
		int userNo = ((Member)(request.getSession().getAttribute("loginUser"))).getUserNo();
		
		//변호사 권한조회
		String lawGrant = new MemberService().selectLawyerGrant(userNo);
		
		if(lawGrant.equals("Y")) { //조회해온 변호사 권한이 Y일 경우에만 조회 
			
			//1. 내 사건 조회 해오기 리뷰(변호사)
			ArrayList <AccidentReview> accRev = new MemberService().selectAccidentReviewList(userNo);
			
			//2.내가 맡은 사건 조회해오기 
			ArrayList <Accident> accident = new MemberService().selectAccidentList(userNo);
			
			//3. 나에게 온 상담 내역 조회해오기
			ArrayList <Counsel> cListLaw = new MemberService().selectCounselListLaw(userNo);
			
			//사진조회 
			String lat = new LawyerService().selectLawAttachment(userNo);
			
			request.setAttribute("lat", lat); //변호사 사진 
			request.setAttribute("accRev" , accRev); // 변호사가 작성하는 사건 리뷰 리스트 
			request.setAttribute("accident", accident); //변호사가 맡은 사건 리스트 
			request.setAttribute("cListLaw", cListLaw); //나에게 온 상담 내역 조회 (변호사)
		}else {
			//일반 회원일 경우에 조회 
			
			//1. 좋아요 변호사 리스트 조회해오기(변호사 번호, 변호사 이름) 
			ArrayList <Lawyer> lawList = new MemberService().selectDibsLawyer(userNo);
			
			//2. 상담 신청 목록 조회해오기 
			ArrayList <Counsel> cList = new MemberService().selectCounselList(userNo);
			
			
			//3. 내가 남긴 리뷰 조회해오기(일반회원)
			ArrayList <LawReview> lawRev = new MemberService().selectLawReviewList(userNo);
			
			request.setAttribute("lawList", lawList); // 찜한 변호사 리스트 
			request.setAttribute("cList", cList); // 상담 신청 리스트 
			request.setAttribute("lawRev", lawRev); //회원이 작성하는 변호사 리뷰 리스트
			request.setAttribute("lawRev", lawRev); //회원이 작성하는 변호사 리뷰 리스트
			
		}
		
		//모든 회원 조회 
		
		//1. 내가 쓴 글 조회해오기(게시글 넘버, 제목, 게시글 위치(카테고리))
		ArrayList <Board>  boardList = new MemberService().selectBoardList(userNo);
		//2. 내가 쓴 댓글 조회해오기(게시글 번호, 댓글내용, 작성일 )
		ArrayList <Reply> replyList = new MemberService().selectReplyList(userNo);
		//3. 1:1 문의글 조회 
		ArrayList <Question> qList = new MemberService().selectQuestionList(userNo);
		
		request.setAttribute("boardList", boardList); // 내가 쓴 글 리스트 
		request.setAttribute("replyList", replyList); //내가 쓴 댓글 리스트 
		request.setAttribute("qList", qList); //회원이 작성하는 변호사 리뷰 리스트
		
		request.getRequestDispatcher("views/member/mypage.jsp").forward(request, response);
	
}



	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//세션에 담긴 로그인 유저의 번호 꺼내오기 
		int userNo = ((Member)(request.getSession().getAttribute("loginUser"))).getUserNo();
		
		//변호사 권한조회
		String lawGrant = new MemberService().selectLawyerGrant(userNo);
		
		if(lawGrant.equals("Y")) { //조회해온 변호사 권한이 Y일 경우에만 조회 
			
			//1. 내 사건 조회 해오기 리뷰(변호사)
			ArrayList <AccidentReview> accRev = new MemberService().selectAccidentReviewList(userNo);
			
			//2.내가 맡은 사건 조회해오기 
			ArrayList <Accident> accident = new MemberService().selectAccidentList(userNo);
			
			//3. 나에게 온 상담 내역 조회해오기
			ArrayList <Counsel> cListLaw = new MemberService().selectCounselListLaw(userNo);
			
			//사진조회 
			String lat = new LawyerService().selectLawAttachment(userNo);
			
			request.setAttribute("lat", lat); //변호사 사진 
			request.setAttribute("accRev" , accRev); // 변호사가 작성하는 사건 리뷰 리스트 
			request.setAttribute("accident", accident); //변호사가 맡은 사건 리스트 
			request.setAttribute("cListLaw", cListLaw); //나에게 온 상담 내역 조회 (변호사)
		}else {
			//일반 회원일 경우에 조회 
			
			//1. 좋아요 변호사 리스트 조회해오기(변호사 번호, 변호사 이름) 
			ArrayList <Lawyer> lawList = new MemberService().selectDibsLawyer(userNo);
			
			//2. 상담 신청 목록 조회해오기 
			ArrayList <Counsel> cList = new MemberService().selectCounselList(userNo);
			
			
			//3. 내가 남긴 리뷰 조회해오기(일반회원)
			ArrayList <LawReview> lawRev = new MemberService().selectLawReviewList(userNo);
			
			request.setAttribute("lawList", lawList); // 찜한 변호사 리스트 
			request.setAttribute("cList", cList); // 상담 신청 리스트 
			request.setAttribute("lawRev", lawRev); //회원이 작성하는 변호사 리뷰 리스트
			request.setAttribute("lawRev", lawRev); //회원이 작성하는 변호사 리뷰 리스트
			
		}
		
		//모든 회원 조회 
		
		//1. 내가 쓴 글 조회해오기(게시글 넘버, 제목, 게시글 위치(카테고리))
		ArrayList <Board>  boardList = new MemberService().selectBoardList(userNo);
		//2. 내가 쓴 댓글 조회해오기(게시글 번호, 댓글내용, 작성일 )
		ArrayList <Reply> replyList = new MemberService().selectReplyList(userNo);
		//3. 1:1 문의글 조회 
		ArrayList <Question> qList = new MemberService().selectQuestionList(userNo);
		
		request.setAttribute("boardList", boardList); // 내가 쓴 글 리스트 
		request.setAttribute("replyList", replyList); //내가 쓴 댓글 리스트 
		request.setAttribute("qList", qList); //회원이 작성하는 변호사 리뷰 리스트
		
		request.getRequestDispatcher("views/member/mypage.jsp").forward(request, response);
	}

}
