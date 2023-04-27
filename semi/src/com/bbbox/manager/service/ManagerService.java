package com.bbbox.manager.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.board.model.dao.AccidentBoardDao;
import com.bbbox.board.model.vo.AccidentReview;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.common.JDBCTemplate;
import com.bbbox.common.model.vo.PageInfo;
import com.bbbox.manager.dao.ManagerDao;
import com.bbbox.member.model.dao.MemberDao;
import com.bbbox.member.model.vo.Member;

public class ManagerService {

	public ArrayList<Board> selectAllAccidentBoard(PageInfo pi, String sort) {
		
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Board> blist = new ManagerDao().selectAllAccidentBoard(conn,pi,sort);
		
		JDBCTemplate.close(conn);
		
		return blist;
	}

	public ArrayList<Board> selectAllResolvedBoard(PageInfo pi, String sort) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Board> blist = new ManagerDao().selectAllResolvedBoard(conn,pi,sort);
		
		JDBCTemplate.close(conn);
		
		return blist;
	}

	public int boardStatusOn(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new ManagerDao().boardStatusOn(conn,bno);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int boardStatusOff(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new ManagerDao().boardStatusOff(conn,bno);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	//게시글에 해당하는 첨부파일(status='N'된것까지) 조회
	public ArrayList<Attachment> selectAttachmentForManage(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Attachment> alist = new ManagerDao().selectAttachmentForManage(conn,bno);
		
		JDBCTemplate.close(conn);
		
		return alist;
	}
	
	public Reply selectRpListForManage(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		Reply rp = new ManagerDao().selectRpListForManage(conn,bno);
		
		JDBCTemplate.close(conn);
		
		return rp;
	}
	

	public int accidentBoardDelete(int bno, ArrayList<Attachment> alist) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result5 = 1; //리뷰없으면 패스
		//리뷰정보 참조할 accNo 가져오기
		int accNo = new AccidentBoardDao().selectAccNo(conn,bno);
		//리뷰정보 가져오기(리뷰가 없을때 오류방지)
		AccidentReview ar = new AccidentBoardDao().resolvedBoardReviewSelectDetail(conn, accNo);
		if(ar!=null) {
			result5 = new ManagerDao().accidentReviewDelete(conn,accNo); 
		}else {
			System.out.println("리뷰정보없음");
		}
		
		int result4 = 1; //리플없으면 패스
		//리플없을때 오류 방지
		Reply rp = new ManagerDao().selectRpListForManage(conn, bno);
		if(rp!=null) {
			result4 = new ManagerDao().accidentReplyDelete(conn,bno);
		}else {
			System.out.println("리플정보없음");
		}
		
		int result3 = 1; //첨부파일 없으면 패스
		if(alist.size()!=0) {
			result3 = new ManagerDao().accidentAttachmentDelete(conn,bno);
		}else {
			System.out.println("영상정보없음");
		}
		
		int result2 = new ManagerDao().accidentInfoDelete(conn,bno);
		int result = new ManagerDao().accidentBoardDelete(conn,bno);
		
		if(result>0 && result2>0 && result3>0 && result4>0 && result5>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result*result2*result3*result4*result5;
	}

	public int accidentReviewDelete(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		int accNo = new AccidentBoardDao().selectAccNo(conn,bno);
		
		int result = new ManagerDao().accidentReviewDelete(conn, accNo);
		
		int result2 = new AccidentBoardDao().returnSolve(conn, accNo);
		int result3 = new AccidentBoardDao().returnBoardCategory(conn, bno);
		
		
		if(result>0 && result2>0 && result3>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result*result2*result3;
	}
	
	//변호사회원 전환 신청 조회
	public ArrayList<Member> selectApplyLaw() {

		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList < Member> applyLaw = new ManagerDao().selectApplyLaw(conn);
		
		JDBCTemplate.close(conn);
		
		return applyLaw;
	}

	//전체 회원 조회 메소드 
	public ArrayList<Member> selectAllMember() {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList <Member> memberList = new ManagerDao().selectAllMember(conn);
		
		JDBCTemplate.close(conn);
		
		return memberList;
	}
	
	
}
