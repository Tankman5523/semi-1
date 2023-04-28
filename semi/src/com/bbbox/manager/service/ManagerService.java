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

	//자유게시판 게시글 총 갯수
	public int freeBoardCount(int[] cArr) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new ManagerDao().freeBoardCount(conn, cArr);
		
		JDBCTemplate.close(conn);
		
		return count;
	}

	//자유게시판 게시글 리스트조회
	public ArrayList<Board> selectFreeBoardList(int[] cArr) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new ManagerDao().selectFreeBoardList(conn, cArr);
		
		JDBCTemplate.close(conn);
		
		return list;
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

	//자유게시판 게시글 정렬 조회
	public ArrayList<Board> selectFreeBoardList(int[] cArr, String sort) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new ManagerDao().selectFreeBoardList(conn, cArr, sort);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	
	//자유게시판 해당 게시글 첨부파일 있는지 여부 조회
	public Attachment selectAt(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Attachment at = new ManagerDao().selectAt(conn, bno);
		
		JDBCTemplate.close(conn);
		
		return at;
	}
		
	//삭제할 게시글 정보 조회
	public Board selectBoard(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Board b = new ManagerDao().selectBoard(conn, bno);
		
		JDBCTemplate.close(conn);
		
		return b;
	}
		
	//자유게시판 게시글 관리 ->삭제
	public int freeBoardDelete(int bno, Attachment at, Board b) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		//해당 게시글 관련 첨부파일 삭제
		int result1 = 1;
		if(at!=null) { //있으면 삭제
			result1 = new ManagerDao().freeBoardAtDelete(conn, bno);
			System.out.println("해당 게시글 첨부파일 삭제완료");
		}
		
		//해당 게시글 관련 댓글 삭제
		int result2 = 1;
		if(b.getRpCount()!=0) {
			result2 = new ManagerDao().freeBoardRpDelete(conn, bno);			
			System.out.println("해당 게시글 댓글 삭제완료");
		}

		
		//해당 게시글 관련 좋아요 삭제
		int result3 = 1;
		if(b.getLiked()!=0) {
			result3 = new ManagerDao().freeBoardLikedDelete(conn, bno);
			System.out.println("해당 게시글 좋아요 삭제완료");			
		}
	
		//해당 게시글 관련 신고 삭제
		int result4 = 1;
		if(b.getReportCount()!=0) {
			result4 = new ManagerDao().freeBoardReportDelete(conn, bno);
		}
		
		//최종 - 해당 게시글 영구삭제
		int result = new ManagerDao().freeBoardDelete(conn, bno);
		
		if(result1*result2*result3*result4*result == 1) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result1*result2*result3*result4*result;
	}

	//공지사항 게시글 리스트조회
	public ArrayList<Board> selectFreeBoardNoticeList() {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new ManagerDao().selectFreeBoardNoticeList(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	//삭제대기 게시글 리스트 조회
	public ArrayList<Board> selectFreeDWBoardList(int[] cArr) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new ManagerDao().selectFreeDWBoardList(conn, cArr);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	//정렬에의한 삭제대기 게시글 리스트 조회
	public ArrayList<Board> selectFreeDWBoardList(int[] cArr, String sort) {

		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new ManagerDao().selectFreeDWBoardList(conn, cArr, sort);
		
		JDBCTemplate.close(conn);
		
		return list;
	}
	
	
}
