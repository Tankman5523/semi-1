package com.bbbox.member.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.board.model.vo.Accident;
import com.bbbox.board.model.vo.AccidentReview;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.common.JDBCTemplate;
import com.bbbox.lawyer.model.vo.Counsel;
import com.bbbox.lawyer.model.vo.LawAttachment;
import com.bbbox.lawyer.model.vo.LawReview;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.member.model.dao.MemberDao;
import com.bbbox.member.model.vo.Member;
import com.bbbox.qaboard.model.vo.Question;

public class MemberService {
	
	//회원 로그인 메소드	
	public Member loginMember(String userId, String userPwd) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Member loginUser = new MemberDao().loginMember(conn, userId, userPwd);
		
		JDBCTemplate.close(conn);
		
		return loginUser;
	}
	
	//회원가입 메소드 
	public int insertMember(Member insertMember) {

		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().insertMember(conn, insertMember);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
			
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	
	//아이디 중복확인
	public int MemberIdCheck(String checkId) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new MemberDao().MemberIdCheck(conn, checkId);
		
		JDBCTemplate.close(conn);
		
		return count;
	}
	
	//이메일 중복 확인
	public Member selectEmail(String testEmail) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Member m = new MemberDao().selectEmail(conn, testEmail);
		
		JDBCTemplate.close(conn);
		
		return m;
	}

	
	//회원정보 수정 메소드
	public int updateMember(Member m) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().updateMember(conn, m);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		return result;
	}

	public int updatePwd(String email, String tempPwd) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().updatePwd(conn, email, tempPwd);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
	
		return result;
	}
	
	//회원 탈퇴 메소드	
	public int deleteMember(int userNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().deleteMember(conn, userNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else{
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//변호사 회원 신청 
	public int ApplyLawyar(LawAttachment lat, Lawyer applyla) {

		Connection conn = JDBCTemplate.getConnection();
		//사진 등록 결과 
		int result1 = new MemberDao().insertProfile(conn,lat);
		
		//신청결과 
		int result2 = new MemberDao().insertApply(conn, applyla);
		
		//신청 유저의 lawyer 상태값 변경
		int result3 = new MemberDao().updateLawyerGrant(conn, applyla);
		
		
		if(result1*result2*result3>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result1*result2*result3;
	}

	public String selectLawyerGrant(int userNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		String lawyer = new MemberDao().selectLawyerGrant(conn,userNo);
		
		JDBCTemplate.close(conn);
		
		return lawyer;
	}
	
	
	//찜한 변호사 목록 조회하는 메소드 
	public ArrayList<Lawyer> selectDibsLawyer(int userNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Lawyer> lawList = new MemberDao().selectDibsLawyer(conn, userNo);
		
		JDBCTemplate.close(conn);
		
		return lawList;
	}
	
	//내 게시글 목록 조회하는 메소드
	public ArrayList<Board> selectBoardList(int userNo) {

		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList <Board> boardList = new MemberDao().selectBoardList(conn, userNo);
		
		JDBCTemplate.close(conn);
		
		return boardList;
	}
	
	//내가 쓴 댓글 조회하는 메소드 
	public ArrayList<Reply> selectReplyList(int userNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList <Reply> replyList = new MemberDao().selectReplyList(conn, userNo);
		
		JDBCTemplate.close(conn);
		
		return replyList;
	}
	//내 상담 신청 내역 조회하는 메소드 	
	public ArrayList<Counsel> selectCounselList(int userNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Counsel> cList = new MemberDao().selectCounselList(conn, userNo);
		
		JDBCTemplate.close(conn);
		
		return cList;
	}
	//회원이 작성한 변호사 리뷰 조회하는 메소드 
	public ArrayList<LawReview> selectLawReviewList(int userNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<LawReview> lawRev = new MemberDao().selectLawReviewList(conn, userNo);
		
		JDBCTemplate.close(conn);
				
		return lawRev;
	}
	
	//변호사가 작성한 사건 리뷰 조회하는 메소드
	public ArrayList<AccidentReview> selectAccidentReviewList(int userNo) {

		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<AccidentReview> accRev = new MemberDao().selectAccidentReviewList(conn, userNo);
		
		JDBCTemplate.close(conn);
		
		return accRev;
	}

	//변호사가 맡은 사건 조회 메소드(해결X) 
	public ArrayList<Accident> selectAccidentList(int userNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Accident> accident = new MemberDao().selectAccidentList(conn, userNo);
		
		JDBCTemplate.close(conn);
		
		
		return accident;
	}

	//나에게 온 상담내역 조회하는 메소드 (변호사)
	public ArrayList<Counsel> selectCounselListLaw(int userNo) {

		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Counsel> cListLaw = new MemberDao().selectCounselListLaw(conn, userNo);
		
		JDBCTemplate.close(conn);
		
		return cListLaw;
	}
	
	// 1대 1 문의글 조회 하는 메소드 
	public ArrayList<Question> selectQuestionList(int userNo) {

		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList <Question> qList = new MemberDao().selectQuestionList(conn, userNo);
		
		JDBCTemplate.close(conn);
		
		return qList;
	}
	
	//변호사 신청 회원 정보 조회(관리자)
	public Member selectMemberInfo(int userNo) {

		Connection conn = JDBCTemplate.getConnection();
		
		Member applyMem = new MemberDao().selectMemberInfo(conn, userNo);
		
		JDBCTemplate.close(conn);
		
		return applyMem;
	}
	
	//변호사 신청 승인(관리자) 
	public int acceptLawyer(int uno, int resultNum) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().acceptLawyer(conn, uno, resultNum);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result;
	}
	
	//변호사 회원 정보 수정 메소드 
	public int updateLawyer(Lawyer l, LawAttachment lat) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result1 = new MemberDao().updateLawyer(conn, l);
		
		int result2 = new MemberDao().updateProfile(conn, lat);
		
		if(result1*result2>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result1*result2;
	}
	
	
	
	

	

}
